//
//  GSSegmentedControl.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSSegmentedControl.h"
#import "UIColor+Utils.h"
@implementation GSSegmentedControl
-(instancetype)initWithItems:(NSArray *)items{
    if (self = [super initWithItems:items]) {
        self.frame = CGRectMake(0.f, 0.f, 160.f, 30.f);
        self.selectedSegmentIndex = 0;//默认选中第一个
        [self setTintColor:[UIColor colorWithHexString:@"#00bfaf"]];
    }
    return self;
}

@end
