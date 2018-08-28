//
//  GSTableViewController.m
//  UICollectionViewLayout
//
//  Created by 管章鹏 on 2018/7/4.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSCollectionListVC.h"

@interface GSCollectionListVC ()

@end

@implementation GSCollectionListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CollectionView的使用";
    self.dataArray = @[@"GSDateVC",@"GSInfiniteVC",@"GSCustomLayoutVC",@"GSWaterFlowVC"];
    self.titleArray = @[@"日历",@"无限循环轮播",@"自定义布局",@"流水布局"];
}
@end
