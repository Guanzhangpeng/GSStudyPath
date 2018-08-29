//
//  GSShadowView.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/29.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSShadowView.h"

@implementation GSShadowView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.touchBlock) {
        self.touchBlock();
    }    
    [super touchesBegan:touches withEvent:event];
}

@end
