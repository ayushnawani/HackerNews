//
//  ViewController.h
//  HackerNews
//
//  Created by Ayush Nawani on 30/08/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

