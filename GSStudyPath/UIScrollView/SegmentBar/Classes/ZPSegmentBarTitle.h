//
//  ZPSegmentBar.h
//  ZPSegmentBarOC
//
//  Created by 管章鹏 on 2017/3/30.
//  Copyright © 2017年 zswangzp@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZPSegmentBarTitle,ZPSegmentBarStyle;

@protocol ZPSegmentBarTitleDelegate <NSObject>

-(void)segmentBarTitle:(ZPSegmentBarTitle * )segmentBarTitle fromIndex:(NSInteger )fromIndex toIndex:(NSInteger)targetIndex;

@end

@interface ZPSegmentBarTitle : UIView



-(void)setupWithTitles:(NSArray <NSString *> *)titles style:(ZPSegmentBarStyle *)style;

@property(nonatomic,weak) id<ZPSegmentBarTitleDelegate> delegate;


@end
