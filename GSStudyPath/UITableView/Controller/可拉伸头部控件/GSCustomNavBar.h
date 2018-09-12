//
//  GSCustomNavBar.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/9/11.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSCustomNavBar : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor  *titleColor;
@property (nonatomic, strong) NSString *leftImage;
@property (nonatomic, strong) NSString *rightImage;

@property (nonatomic, strong) void(^leftBtnAction)(void);

@end
