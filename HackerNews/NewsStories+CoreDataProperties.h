//
//  NewsStories+CoreDataProperties.h
//  HackerNews
//
//  Created by Ayush Nawani on 08/10/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NewsStories.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsStories (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *score;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *author;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSArray *kids;



@end

NS_ASSUME_NONNULL_END
