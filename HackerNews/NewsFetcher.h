//
//  NewsFetcher.h
//  HackerNews
//
//  Created by Ayush Nawani on 23/09/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsFetcher : NSObject

-(NSMutableArray*)fetchNewsFromServer;

@end
