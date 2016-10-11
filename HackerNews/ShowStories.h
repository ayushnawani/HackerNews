//
//  ShowStories.h
//  HackerNews
//
//  Created by Ayush Nawani on 09/10/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface ShowStories : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSNumber *newsId;
@property(nonatomic,strong) NSArray *kids;
@property(nonatomic,weak) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITableView *commentTable;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@end
