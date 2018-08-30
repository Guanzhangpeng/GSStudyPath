//
//  GSNewsVC.m
//  UICollectionViewLayout
//
//  Created by 管章鹏 on 2018/7/5.
//  Copyright © 2018年 管章鹏. All rights reserved.
//  无限循环轮播


#import "GSInfiniteVC.h"
#import "GSInfiniteView.h"
@implementation GSInfiniteVC
#pragma mark 系统回调方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"无限轮播";
    self.view.backgroundColor = [UIColor whiteColor];
    GSInfiniteView *infiniteView = [[GSInfiniteView alloc] initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, 280)];
    infiniteView.imgArray = @[@"1",@"2",@"3",@"4",@"5"];//图片数组
    infiniteView.desArray = @[@"第十六届",@"还是到了发生了",@"胜利大街分类数据得浪费",@"胜利大街菲利斯佛罗伦萨的积分老师讲东方闪电",@"东山街道解放路围殴我可是绝大部分快睡吧达芙妮"];//描述数组
    infiniteView.imgClick = ^(NSInteger index) {
        NSLog(@"点击了第 %ld 张图片",index);
    };
    [self.view addSubview:infiniteView];
}
@end
