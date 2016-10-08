//
//  ViewController.m
//  HackerNews
//
//  Created by Ayush Nawani on 30/08/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import "ViewController.h"
#import "NewsFetcher.h"
#import "NewsStories.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *allStories;
    NSMutableArray *allNews;
}

-(void)viewWillAppear:(BOOL)animated
{

    NewsFetcher *newsFetcher = [[NewsFetcher alloc] init];
    allStories = [newsFetcher fetchNewsFromServer];
    [self saveNews];
    [self fetchNewsFromDB];
    
//    if (!(allNews.count < 70)) {
//        <#statements#>
//    }
    // allStories = [newsFetcher fetchNewsFromServer];
    
    //[self saveNews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}






- (BOOL)saveNews {

    NSDictionary *story;

    NSManagedObjectContext *context = [self managedObjectContext];

    
    for (NSInteger i = 0; i < 60; i++) {
        
        story = [allStories objectAtIndex:i];
        
        NSNumber *score = [story objectForKey:@"score"];
        NSString *author = [story objectForKey:@"by"];
        NSString *url = [story objectForKey:@"url"];
        NSString *title = [story objectForKey:@"title"];

        
        NSManagedObject *newStoriesObject = [NSEntityDescription insertNewObjectForEntityForName:@"NewsStories" inManagedObjectContext:context];

        [newStoriesObject setValue:score forKey:@"score"];
        [newStoriesObject setValue:url forKey:@"url"];
        [newStoriesObject setValue:author forKey:@"author"];
        [newStoriesObject setValue:title forKey:@"title"];
        
        NSError *error = nil;
        // Save the object to persistent store
        

        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
    }
    
    
    return true;
}

-(BOOL)fetchNewsFromDB {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"NewsStories"];
    allNews = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return true;
    //[self.tableView reloadData];;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NewsStories *story = allNews[indexPath.item];
    UILabel *title = (UILabel *)[cell viewWithTag:1];
    UILabel *author = (UILabel *)[cell viewWithTag:2];
    title.text = story.title;
    author.text = story.author;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return allNews.count;
}

@end
