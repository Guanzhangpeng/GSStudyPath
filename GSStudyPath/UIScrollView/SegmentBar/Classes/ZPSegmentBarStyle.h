//
//  ZPSegmentBarStyle.h
//  ZPSegmentBarOC
//
//  Created by 管章鹏 on 2017/3/30.
//  Copyright © 2017年 zswangzp@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPSegmentBarStyle : NSObject
@property(nonatomic,assign) BOOL isDealFirstItem;//自动滚动的时候需要特殊处理下第一个选项
@property(nonatomic,assign) BOOL isScrollEnabled;////标题能否滚动
@property(nonatomic,assign) CGFloat titleMargin;//能滚动情况下,文字的间距


/**
 字体属性以及间距
 */
@property(nonatomic,assign) CGFloat titleHeight;    //ZPSegmentBar的高度
@property(nonatomic,strong) UIFont  * titleFont;     //title的字体
@property(nonatomic,strong) UIColor * normalColor; //文本普通颜色
@property(nonatomic,strong) UIColor * selecteColor;//文本选中颜色

@property(nonatomic,strong) UIColor * titleViewBG;//titleView的背景颜色;


/**
 BottomLine
 */
@property(nonatomic,assign)BOOL isShowBottomLine;//是否显示底部Line
@property(nonatomic,strong)UIColor *  bottomLineColor;//line颜色
@property(nonatomic,assign) CGFloat bottomLineHeight;//Line的高度



/**
 缩放动画
 */
@property(nonatomic,assign) BOOL isNeedScale;//是否需要缩放动画效果
@property(nonatomic,assign) CGFloat maxScale;////放大系数;



/**
 遮盖
 */
@property(nonatomic,assign) BOOL isShowCover;//是否显示遮盖效果
@property(nonatomic,strong) UIColor *  coverViewColor;//遮盖颜色
@property(nonatomic,assign) CGFloat coverViewHeight;//遮盖高度
@property(nonatomic,assign) CGFloat coverViewRadius;//遮盖圆角
@property(nonatomic,assign) CGFloat coverViewAlpha;//遮盖透明度
@property(nonatomic,assign) CGFloat coverViewMargin;//遮盖间距
@end
