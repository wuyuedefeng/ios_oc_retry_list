//
//  CompanyCoreDataTool.m
//  ios_retry_list
//
//  Created by senwang on 16/1/10.
//  Copyright © 2016年 senwang. All rights reserved.
//

#import "CompanyCoreDataTool.h"
#import <CoreData/CoreData.h>

@interface CompanyCoreDataTool (){
    NSManagedObjectContext *_context;
}
@end

@implementation CompanyCoreDataTool

+ (void)testCompanyCoreData{
    CompanyCoreDataTool *companyCoreDataTool = [[CompanyCoreDataTool alloc] init];
    [companyCoreDataTool setupContext];
}


-(void)setupContext{
    
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 模型文件  该方法会将所有coredata model放到一个数据库中
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // 持久化存储调度器
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",doc);
    NSString *sqlitePath = [doc stringByAppendingPathComponent:@"company.sqlite"];
    
    //数据存储的类型 数据库存储路径
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:nil];
    
    
    _context.persistentStoreCoordinator = store;
}


@end
