//
//  NewsFetcher.m
//  HackerNews
//
//  Created by Ayush Nawani on 23/09/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import "NewsFetcher.h"

@implementation NewsFetcher
{
    NSMutableData *_responseData;
    NSArray *topStoriesList;
    NSString *topStoriesURL;
    NSString *initalString;
    NSString *jsonString;
}

-(instancetype)init{
    
    topStoriesURL = @"https://hacker-news.firebaseio.com/v0/topstories.json";
    initalString = @"https://hacker-news.firebaseio.com/v0/item/";
    jsonString = @".json";

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:topStoriesURL]];
    topStoriesList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    return  self;
}
-(NSInteger)topStoriesCount {
  return topStoriesList.count;
}

-(NSMutableArray*)fetchNewsFromServer:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    
    NSMutableArray *allStories = [NSMutableArray array];
    
    
    for (NSInteger i = startIndex; i < endIndex; i++) {
        NSNumber *story = topStoriesList[i];
        
        NSString *eachStoriesURL =[NSString stringWithFormat:@"%@%@%@",initalString,story.stringValue,jsonString];
        
        NSData *storyData = [NSData dataWithContentsOfURL:[NSURL URLWithString:eachStoriesURL]];
        NSArray *storyArray = [NSJSONSerialization JSONObjectWithData:storyData options:kNilOptions error:nil];
        [allStories addObject:storyArray];
    }
    
    NSSortDescriptor *valueDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:YES];
    NSMutableArray *sorted = [allStories sortedArrayUsingDescriptors:@[valueDescriptor]];

    return sorted;
}



@end
