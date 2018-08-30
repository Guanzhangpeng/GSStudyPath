//
//  ZPSegmentBarStyle.m
//  ZPSegmentBarOC
//
//  Created by 管章鹏 on 2017/3/30.
//  Copyright © 2017年 zswangzp@163.com. All rights reserved.
//

#import "ZPSegmentBarStyle.h"

@implementation ZPSegmentBarStyle
- (instancetype)init
{
    self = [super init];
    if (self) {
        //标题能否滚动;
        self.isScrollEnabled=YES;
        
        //字体大小和间距
        self.titleHeight=44;
        self.titleMargin=20;
        self.titleFont=[UIFont systemFontOfSize:17];
        self.titleViewBG=[UIColor purpleColor];
        
        //字体颜色
        self.normalColor=[UIColor whiteColor];
        self.selecteColor=[UIColor orangeColor];
        
        //显示bottomLine
        self.bottomLineHeight=2;
        self.isShowBottomLine=YES;
        self.bottomLineColor=[UIColor orangeColor];
        
        //字体放大
        self.isNeedScale=YES;
        self.maxScale=1.2;
        
        
        //遮盖
        self.isShowCover = YES;
        self.coverViewColor= [UIColor blackColor];
        self.coverViewAlpha=0.7;
        self.coverViewHeight=25;
        self.coverViewRadius=12;
        self.coverViewMargin=6;
    }
    return self;
}
@end
