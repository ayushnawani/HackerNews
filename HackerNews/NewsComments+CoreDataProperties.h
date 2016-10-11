//
//  NewsComments+CoreDataProperties.h
//  HackerNews
//
//  Created by Ayush Nawani on 11/10/16.
//  Copyright © 2016 Ayush Nawani. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NewsComments.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsComments (CoreDataProperties)

@property (nullable, nonatomic, retain) NSMutableArray *commentArray;
@property (nullable, nonatomic, retain) NSNumber *newsId;

@end

NS_ASSUME_NONNULL_END
