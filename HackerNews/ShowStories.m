//
//  ShowStories.m
//  HackerNews
//
//  Created by Ayush Nawani on 09/10/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import "ShowStories.h"

@interface ShowStories ()

@end

@implementation ShowStories
{
    NSMutableArray *commentsText;
}

-(void)viewWillAppear:(BOOL)animated {
    commentsText = [NSMutableArray array];
    [super viewWillAppear:animated];
    if (self.url.length > 0) {
        [self fetchKids];
    }
    self.commentTable.frame = self.view.frame;
    self.commentTable.scrollEnabled = YES;
    self.commentTable.bounces = YES;

}

- (void)viewDidLoad {
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


-(void)fetchKids {
    
    NSString *initalString = @"https://hacker-news.firebaseio.com/v0/item/";
    NSString *jsonString = @".json";
    
    for (NSInteger i ; i < [self.kids count]; i++) {
        NSString *commentURL = [NSString stringWithFormat:@"%@%@%@",initalString,self.kids[i],jsonString ];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:commentURL]];
        NSDictionary *commentsDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if ([[commentsDict objectForKey:@"type"] isEqualToString:@"comment"]) {
            if ([commentsDict objectForKey:@"text"] ) {
                [commentsText addObject:[commentsDict objectForKey:@"text"]];
            }
        }
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [commentsText count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    cell.textLabel.text = commentsText[item];
    return cell;
}



@end
