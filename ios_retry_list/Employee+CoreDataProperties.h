//
//  Employee+CoreDataProperties.h
//  ios_retry_list
//
//  Created by senwang on 16/1/10.
//  Copyright © 2016年 senwang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) NSNumber *gender;

@end

NS_ASSUME_NONNULL_END
