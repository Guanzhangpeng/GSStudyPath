//
//  GSNavigationController.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/25.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSNavigationController.h"

@interface GSNavigationController ()

@end

@implementation GSNavigationController

+(void)load{
    
    //隐藏返回按钮标题
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0) forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
