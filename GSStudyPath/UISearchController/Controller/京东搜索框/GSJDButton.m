//
//  GSJDButton.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/25.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSJDButton.h"

@implementation GSJDButton

-(void)layoutSubviews{
    [super layoutSubviews];
    if (!_noImage) {
        self.imageView.frame = CGRectMake(6.f, 0, self.gs_width - 12.f, self.gs_width - 12.f);
        self.titleLabel.frame = CGRectMake(0.f, self.gs_height - 12.f, self.gs_width, 12.f);
        self.titleLabel.font = [UIFont systemFontOfSize:9.f];
    }else{
        self.imageView.frame = CGRectZero;
        self.titleLabel.frame = CGRectMake(0.f, 0.f, self.gs_width, self.gs_height);
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}
@end
