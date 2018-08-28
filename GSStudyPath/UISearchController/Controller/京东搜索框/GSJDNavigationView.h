//
//  GSJDNavigationView.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/24.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSJDButton.h"
@interface GSJDNavigationView : UIView

typedef void (^btnBlock)(void);

@property (nonatomic, strong) UIImageView *searchView;
@property (nonatomic, strong) GSJDButton *scanBtn;
@property (nonatomic, strong) GSJDButton *messageBtn;
@property (nonatomic, strong) UIButton *audioBtn;
@property (nonatomic, strong) btnBlock scanActionBlock;
@property (nonatomic, strong) btnBlock messageActionBlock;
@property (nonatomic, strong) btnBlock audioActionBlock;
@property (nonatomic, strong) btnBlock searchActionBlock;

@end
