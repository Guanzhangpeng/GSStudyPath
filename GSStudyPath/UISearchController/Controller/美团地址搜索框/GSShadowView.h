//
//  GSShadowView.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/29.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSShadowView : UIView

typedef void(^touchActionBlock)();
@property (nonatomic, strong) touchActionBlock touchBlock;

@end
