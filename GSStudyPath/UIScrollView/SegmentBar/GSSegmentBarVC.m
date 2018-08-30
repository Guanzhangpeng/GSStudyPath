//
//  GSSegmentBarVC.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/30.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSSegmentBarVC.h"
#import "ZPSegmentView.h"
@interface GSSegmentBarVC ()

@end

@implementation GSSegmentBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    CGRect frame=CGRectMake(0, 0, self.view.width, self.view.height);
    NSArray * titles=@[@"头条",@"娱乐",@"视频"];
    NSMutableArray * childVcs=[NSMutableArray array];
    for (int i=0; i<titles.count; i++) {
        UITableViewController * vc=[[UITableViewController alloc]init];
        vc.view.backgroundColor=[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        [childVcs addObject:vc];
    }
    
    ZPSegmentBarStyle * style=[[ZPSegmentBarStyle alloc] init];
    style.isScrollEnabled=NO;//导航条是否可以滚动,默认YES;
    style.isShowCover=YES;//导航条是否显示遮盖效果,默认YES;
    style.coverViewMargin=6;//遮盖间距;
    style.isShowBottomLine=YES;//导航条下方是否显示BottomLine,默认YES;
    style.bottomLineColor=[UIColor orangeColor];//BottomLine 的颜色;
    style.isNeedScale=YES;//导航条是否有放大效果,默认YES;
    
    ZPSegmentView * segmentView=[[ZPSegmentView alloc]initWithFrame:frame];
    [segmentView setupWithtitles:titles style:style childVcs:childVcs parentVc:self];
    [self.view addSubview:segmentView];
}

@end
