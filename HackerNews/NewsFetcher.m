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

-(NSMutableArray*)fetchNewsFromServer:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:topStoriesURL]];
    NSArray *topStoriesList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSMutableArray *allStories = [NSMutableArray array];
    
    
    for (NSInteger i = startIndex; i < endIndex; i++) {
        NSNumber *story = topStoriesList[i];
        
        NSString *eachStoriesURL =[NSString stringWithFormat:@"%@%@%@",initalString,story.stringValue,jsonString];
        
        NSData *storyData = [NSData dataWithContentsOfURL:[NSURL URLWithString:eachStoriesURL]];
        NSArray *storyArray = [NSJSONSerialization JSONObjectWithData:storyData options:kNilOptions error:nil];
        [allStories addObject:storyArray];
    }
    
    
    //    for (NSInteger i = 0; i < allStories.count ; i++) {
    //        for (NSInteger j = 0; j < allStories.count-1; j++) {
    //            NSDictionary *currentSingleStory  = [allStories objectAtIndex:j];
    //            NSNumber *currentScore = [currentSingleStory objectForKey:@"score"];
    //
    //            NSDictionary *nextSingleStory  = [allStories objectAtIndex:j+1];
    //            NSNumber *nextScore = [nextSingleStory objectForKey:@"score"];
    //
    //            if (currentScore.doubleValue > nextScore.doubleValue) {
    //                [allStories insertObject:nextSingleStory atIndex:j];
    //                [allStories insertObject:currentSingleStory atIndex:j+1];
    //            }
    //
    //        }
    //
    //    }
    NSSortDescriptor *valueDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:YES];
    NSMutableArray *sorted = [allStories sortedArrayUsingDescriptors:@[valueDescriptor]];

    return sorted;
}



@end
