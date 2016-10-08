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
}

-(void)startFetching {
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://hacker-news.firebaseio.com/v0/topstories.json"]];
//    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

//    NSMutableURLRequest *request =
//    [NSMutableURLRequest requestWithURL:[NSURL
//                                         URLWithString:@"https://hacker-news.firebaseio.com/v0/topstories.json"]
//                                        cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
//                                        timeoutInterval:10];
//    [request setHTTPMethod: @"GET"];
    
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://hacker-news.firebaseio.com/v0/item/8863.json?print=pretty"]];
//    NSArray *topStoriesList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


//#pragma mark NSURLConnection Delegate Methods
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//// A response has been received, this is where we initialize the instance var you created
//// so that we can append data to it in the didReceiveData method
//// Furthermore, this method is called each time there is a redirect so reinitializing it
//// also serves to clear it
//_responseData = [[NSMutableData alloc] init];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    // Append the new data to the instance variable you declared
//    [_responseData appendData:data];
//}
//
//- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
//                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
//    // Return nil to indicate not necessary to store a cached response for this connection
//    return nil;
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    // The request is complete and data has been received
//    // You can parse the stuff in your instance variable now
//    
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    // The request has failed for some reason!
//    // Check the error var
//}

@end
