//
//  GSInfiniteView.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/23.
//  Copyright © 2018年 管章鹏. All rights reserved.
//  无限图片轮播

#import <UIKit/UIKit.h>

@interface GSInfiniteView : UIView
@property (nonatomic , strong) NSArray *imgArray;
@property (nonatomic , strong) NSArray *desArray;
@property (nonatomic , strong) void(^imgClick)(NSInteger index);
@property (nonatomic , assign, getter=isShowImgDescription) BOOL showDescription;
@end
