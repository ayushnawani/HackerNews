//
//  ShowStories.h
//  HackerNews
//
//  Created by Ayush Nawani on 09/10/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShowStories : UIViewController

@property(nonatomic,strong) NSString *url;
@property(nonatomic,weak) IBOutlet UIWebView *webView;

@end
