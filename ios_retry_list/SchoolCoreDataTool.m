//
//  SchoolCoreDataTool.m
//  ios_retry_list
//
//  Created by senwang on 16/1/10.
//  Copyright © 2016年 senwang. All rights reserved.
//

#import "SchoolCoreDataTool.h"
#import <CoreData/CoreData.h>
#import "Student.h"
#import "Teacher.h"
@interface SchoolCoreDataTool (){
    NSManagedObjectContext *_context;
}
@end

@implementation SchoolCoreDataTool

+ (void)testCompanyCoreData{
    SchoolCoreDataTool *schoolCoreDataTool = [[SchoolCoreDataTool alloc] init];
    [schoolCoreDataTool setupContext];
    [schoolCoreDataTool readStudents];
    
    
}

# pragma mark 添加学生
- (void)addStudent{
    Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:_context];
    stu.name = @"wangyi";
    stu.age = @18;
    
    //创建老师
    Teacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:_context];
    teacher.name = @"laoshi1";
    teacher.age = @31;
    
    stu.teacher = teacher;
    
    //保存
    [_context save:nil];
    
}

# pragma mark 查询
- (void)readStudents{
    //查找ios部门的员工
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    // 过滤查询  没有查询全部
    // NSPredicate *pre = [NSPredicate predicateWithFormat:@"teacher.name = %@",@"laoshi1"];
    // request.predicate = pre;
    
    //读取信息
    NSError *error = nil;
    NSArray *students = [_context executeFetchRequest:request error:&error];
    if (!error) {
        NSLog(@"students: %@",students);
        for (Student *student in students) {
            NSLog(@"name:%@ departName:%@ ",student.name,student.teacher.name);
        }
    }else{
        NSLog(@"%@",error);
    }
}


# pragma mark 设置上下文
-(void)setupContext{
    
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 模型文件  该方法会将所有coredata model放到一个数据库中
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // 持久化存储调度器
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",doc);
    NSString *sqlitePath = [doc stringByAppendingPathComponent:@"school.sqlite"];
    
    //数据存储的类型 数据库存储路径
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:nil];
    
    
    _context.persistentStoreCoordinator = store;
}

@end
