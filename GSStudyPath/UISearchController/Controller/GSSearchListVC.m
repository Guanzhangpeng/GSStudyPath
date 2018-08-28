//
//  GSSearchListVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/24.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSSearchListVC.h"

@interface GSSearchListVC ()

@end

@implementation GSSearchListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"searchController的使用";
    self.titleArray = @[
                        @"UISearchController 基本使用",
                        @"高仿京东搜索框"
                        ];
    
    self.dataArray = @[
                        @"GSNormalSearchVC",
                        @"JDHomeVC"
                       ];
    
}

@end
