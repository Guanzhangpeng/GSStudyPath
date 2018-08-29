//
//  GSSelectButton.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/29.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSSelectButton.h"

@implementation GSSelectButton

const CGFloat ratio = 5.f/8.f;

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0.f, 0.f, self.gs_width-20.f, self.gs_height);
    
    CGFloat imageWidth = 10.f;
    CGFloat imageHeight = 10.f*ratio;
    self.imageView.frame = CGRectMake(self.gs_width-20.f, (self.gs_height-imageHeight)/2, imageWidth, imageWidth*ratio);
}

@end
