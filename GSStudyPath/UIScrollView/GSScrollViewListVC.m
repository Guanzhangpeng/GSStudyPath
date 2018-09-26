//
//  GSScrollViewListVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/20.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSScrollViewListVC.h"

@interface GSScrollViewListVC ()

@end

@implementation GSScrollViewListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIScrollView的使用";
    self.dataArray = @[@"GSSegmentBarVC",@"GSAlipayHomeVC"];
    self.titleArray = @[@"SegmentBar 效果",@"支付宝首页效果"];
}

@end
