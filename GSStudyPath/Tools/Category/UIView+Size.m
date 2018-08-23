//
//  UIView+Size.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/23.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "UIView+Size.h"

@implementation UIView (Size)
- (void)setGs_x:(CGFloat)gs_x
{
    CGRect frame = self.frame;
    frame.origin.x = gs_x;
    self.frame = frame;
}

- (CGFloat)gs_x
{
    return self.frame.origin.x;
}

- (void)setGs_y:(CGFloat)gs_y
{
    CGRect frame = self.frame;
    frame.origin.y = gs_y;
    self.frame = frame;
}

- (CGFloat)gs_y
{
    return self.frame.origin.y;
}

- (void)setGs_width:(CGFloat)gs_width
{
    CGRect frame = self.frame;
    frame.size.width = gs_width;
    self.frame = frame;
}

- (CGFloat)gs_width
{
    return self.frame.size.width;
}

- (void)setGs_height:(CGFloat)gs_height
{
    CGRect frame = self.frame;
    frame.size.height = gs_height;
    self.frame = frame;
}

- (CGFloat)gs_height
{
    return self.frame.size.height;
}

- (void)setGs_origin:(CGPoint)gs_origin
{
    CGRect frame = self.frame;
    frame.origin = gs_origin;
    self.frame = frame;
}

- (CGPoint)gs_origin
{
    return self.frame.origin;
}

- (void)setGs_size:(CGSize)gs_size
{
    CGRect frame = self.frame;
    frame.size = gs_size;
    self.frame = frame;
}

- (CGSize)gs_size
{
    return self.frame.size;
}
@end
