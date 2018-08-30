//
//  ZPSegmentView.h
//  ZPSegmentBarOC
//
//  Created by 管章鹏 on 2017/4/1.
//  Copyright © 2017年 zswangzp@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPSegmentBarTitle.h"
#import "ZPSegmentBarContent.h"
#import "ZPSegmentBarStyle.h"
#import "UIView+ZPSegmentBar.h"


@interface ZPSegmentView : UIView


/**
 初始化ZPSegmentView,设置各项数据;

 @param titles 当前View大小
 @param style 当前View相关的样式
 @param childVcs 子控制器
 @param parentVc 父控制器
 */
-(void)setupWithtitles:(NSArray<NSString *>*)titles style:(ZPSegmentBarStyle *)style childVcs:(NSArray<UIViewController*>*)childVcs parentVc:(UIViewController *)parentVc;

@property (nonatomic , strong) ZPSegmentBarContent *contentView;
@end
