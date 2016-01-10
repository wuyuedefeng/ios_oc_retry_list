//
//  WechatCoreDataTool.m
//  ios_retry_list
//
//  Created by senwang on 16/1/10.
//  Copyright © 2016年 senwang. All rights reserved.
//

#import "WechatWeiboCoreDataTool.h"
#import <CoreData/CoreData.h>

@implementation WechatWeiboCoreDataTool

+ (void)testCompanyCoreData{
    WechatWeiboCoreDataTool *coreDataTool = [[WechatWeiboCoreDataTool alloc] init];
    NSManagedObjectContext *wechatContext = [coreDataTool setupContextWithModelName:@"Wechat"];
    NSManagedObjectContext *weiboContext = [coreDataTool setupContextWithModelName:@"Weibo"];
    
    NSLog(@"%@",wechatContext);
    NSLog(@"%@",weiboContext);
}


/**
 *  根据模型文件名 返回上下文
 */
-(NSManagedObjectContext *)setupContextWithModelName:(NSString *)modelName{
    
    // 1.上下文 关联Company.xcdatamodeld 模型文件
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 关联模型文件
    
    // 创建一个模型对象
    // 传一个nil 会把 bundle下的所有模型文件 关联起来
    // 查找model文件的URL
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // 持久化存储调度器
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 存储数据库的名字
    NSError *error = nil;
    
    // 获取docment目录
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 数据库保存的路径
    NSString *sqlitePath = [doc stringByAppendingFormat:@"/%@.slqite",modelName];
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:&error];
    
    context.persistentStoreCoordinator = store;
    
    return context;
}


@end
