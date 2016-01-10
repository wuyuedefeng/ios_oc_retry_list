//
//  ViewController.m
//  ios_retry_list
//
//  Created by senwang on 16/1/10.
//  Copyright © 2016年 senwang. All rights reserved.
//

#import "ViewController.h"
//core data test
#import "CompanyCoreDataTool.h"
#import "WechatWeiboCoreDataTool.h"
#import "SchoolCoreDataTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [CompanyCoreDataTool testCompanyCoreData];
//    [WechatWeiboCoreDataTool testCompanyCoreData];
    [SchoolCoreDataTool testCompanyCoreData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
