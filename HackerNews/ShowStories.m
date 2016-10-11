//
//  ShowStories.m
//  HackerNews
//
//  Created by Ayush Nawani on 09/10/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import "ShowStories.h"
#import "NewsComments.h"

@interface ShowStories ()

@end

@implementation ShowStories
{
    NSMutableArray *commentsText;
    NSMutableArray *allDBComments;
    NSMutableArray *allServerComments;
    NSArray *currentDBComment;
}

-(void)viewWillAppear:(BOOL)animated {
    commentsText = [NSMutableArray array];
    allDBComments = [[NSMutableArray alloc] init];
    allServerComments = [[NSMutableArray alloc] init];
    BOOL flag = false;
    
    [super viewWillAppear:animated];
    if (self.url.length > 0) {
        [self fetchCommentsFromDB];
        if(allDBComments.count < 1) {
            [self fetchCommentsFromServer];
            [self saveCommentsToDB];
            [self fetchCommentsFromDB];
        }
        else {
            for (NSInteger i = 0; i < allDBComments.count; i++) {
                NewsComments *commentItem = allDBComments[i];
                if ([commentItem.newsId isEqual:self.newsId]) {
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                [self fetchCommentsFromServer];
                [self saveCommentsToDB];
                [self fetchCommentsFromDB];
            }
        
        
        }
    }
}

- (void)viewDidLoad {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 250, 5)];
    [labelView setFont:[UIFont boldSystemFontOfSize:16]];
    labelView.text = @"Comments";
    
    [headerView addSubview:labelView];
    [labelView sizeToFit];
    labelView.center = headerView.center;
    self.commentTable.tableHeaderView = headerView;
    self.commentTable.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    //self.commentTable.frame = self.view.frame;
    self.commentTable.scrollEnabled = YES;
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    if (self.url.length > 0) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        
    }
    else {
        NSString *htmlFile = [[NSBundle mainBundle]
                              pathForResource:@"NoNews" ofType:@"html"];
        NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        [self.webView loadData:htmlData MIMEType:@"text/html"
              textEncodingName:@"UTF-8" baseURL:baseURL];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)fetchCommentsFromServer {
    
    NSString *initalString = @"https://hacker-news.firebaseio.com/v0/item/";
    NSString *jsonString = @".json";
    
    for (NSInteger i = 0 ; i < [self.kids count]; i++) {
        NSString *commentURL = [NSString stringWithFormat:@"%@%@%@",initalString,self.kids[i],jsonString ];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:commentURL]];
        NSDictionary *commentsDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        [allServerComments addObject:commentsDict];
        
        if ([[commentsDict objectForKey:@"type"] isEqualToString:@"comment"]) {
            if ([commentsDict objectForKey:@"text"] ) {
                [commentsText addObject:[commentsDict objectForKey:@"text"]];
            }
        }
    }
}


-(BOOL)fetchCommentsFromDB {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"NewsComments"];
    allDBComments = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for (NSInteger i = 0; i < allDBComments.count; i++) {
        NewsComments *commentItem = allDBComments[i];
        if ([self.newsId isEqualToValue:commentItem.newsId]) {
            currentDBComment = commentItem.commentArray;
            break;
        }
    }
    return true;
}

-(void)saveCommentsToDB {
    
    NSDictionary *comment;
    NSMutableArray *commentArray = [NSMutableArray array];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *commentManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"NewsComments" inManagedObjectContext:context];
    
    for(NSInteger i = 0 ; i < allServerComments.count ; i++) {
        comment = allServerComments[i];
        NSString *commentText = [comment objectForKey:@"text"];
        NSInteger length = commentText.length;
        if( length < 1) continue;
        NSString *commentUser = [comment objectForKey:@"by"];
        NSString *commentId = [comment objectForKey:@"id"];
        
        
        NSMutableDictionary *commentDictionary = [NSMutableDictionary dictionary];
        
        [commentDictionary setValue:commentText forKey:@"commentText"];
        [commentDictionary setValue:commentUser forKey:@"commentUser"];
        [commentDictionary setValue:commentId forKey:@"commentId"];
        [commentArray addObject:commentDictionary];
    }
    
    [commentManagedObject setValue:commentArray forKey:@"commentArray"];
    [commentManagedObject setValue:self.newsId forKey:@"newsId"];
    
    NSError *error = nil;
    
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

# pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [currentDBComment count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"comment"];
        
        [[cell textLabel] setNumberOfLines:5]; // unlimited number of lines
        [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
        [[cell textLabel] setFont:[UIFont systemFontOfSize: 14.0]];
    }
    else {
        [[cell textLabel] setNumberOfLines:5]; // unlimited number of lines
        [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
        [[cell textLabel] setFont:[UIFont systemFontOfSize: 14.0]];
    }
    NSDictionary *commentItem = currentDBComment[item];
    NSString *commentText = [commentItem objectForKey:@"commentText"];
    [[cell textLabel] setText:commentText];
    
    return cell;
}

# pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // this method is called for each cell and returns height
    NSDictionary *commentItem = currentDBComment[indexPath.item];
    NSString *text = [commentItem objectForKey:@"commentText"];
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize: 14.0] forWidth:[tableView frame].size.width - 40.0 lineBreakMode:NSLineBreakByWordWrapping];
    // return either default height or height to fit the text
    return textSize.height < 44.0 ? 44.0 : textSize.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55.0;
}

@end
