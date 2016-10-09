//
//  NewsFetcher.h
//  HackerNews
//
//  Created by Ayush Nawani on 23/09/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NewsFetcher : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

-(NSMutableArray*)fetchNewsFromServer:(NSInteger)startIndex endIndex:(NSInteger)endIndex;
-(NSInteger)topStoriesCount;
@end
