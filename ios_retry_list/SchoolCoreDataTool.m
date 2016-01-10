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
    [schoolCoreDataTool addStudent];
//    [schoolCoreDataTool readStudents];
//    [schoolCoreDataTool deleteStudentWithName:@"wangyi"];
    
//    [schoolCoreDataTool likeSearcher];
    [schoolCoreDataTool searchStudentWithName:@"wangyi"];
    
    
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

# pragma mark 删除student
- (void)deleteStudentWithName:(NSString *)name{
    // 删除zhangsan
    // 1.查找到zhangsan
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",name];
    request.predicate = pre;
    
    // 2.删除 匹配到姓名的学生
    NSArray *students = [_context executeFetchRequest:request error:nil];
    
    for (Student *student in students) {
        NSLog(@"删除学生 %@",student.name);
        [_context deleteObject:student];
        
        //可以同时删除关系表中的老师
        //[_context deleteObject:student.teacher];
    }
    
    // 3.用context同步下数据库
    //所有的操作暂时都是在内存里，调用save 同步数据库
    [_context save:nil];
}

#pragma mark 模糊查询
- (NSArray *)searchStudentWithName:(NSString *)name{
    
    // 1.查找员工
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",name];
    request.predicate = pre;
    
    NSError *error = nil;
    NSArray *students = [_context executeFetchRequest:request error:&error];
    
    if (!error) {
        NSLog(@"students: %@",students);
        for (Student *student in students) {
            NSLog(@"search --> %@ %@ %@",student.name,student.age,student.teacher.name);
        }
    }else{
        NSLog(@"%@",error);
    }
    
    return students;
}

#pragma mark 模糊查询
- (void)likeSearcher {
    
    // 查询
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    // 过滤
    // 1.查询以wang开头学生
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@",@"wang"];
    
    // 2.以si 结尾
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name ENDSWITH %@",@"si"];
    
    // 3.名字包含 g
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"g"];
    
    // 4.like 以si结尾
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like %@",@"wang*"];
    request.predicate = pre;
    
    //读取信息
    NSError *error = nil;
    NSArray *students = [_context executeFetchRequest:request error:&error];
    if (!error) {
        NSLog(@"students: %@",students);
        for (Student *student in students) {
            NSLog(@"like_search --> %@ %@ %@",student.name,student.age,student.teacher.name);
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
