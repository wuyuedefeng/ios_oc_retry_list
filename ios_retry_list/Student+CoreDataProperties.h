//
//  Student+CoreDataProperties.h
//  ios_retry_list
//
//  Created by senwang on 16/1/10.
//  Copyright © 2016年 senwang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) Teacher *teacher;

@end

NS_ASSUME_NONNULL_END
