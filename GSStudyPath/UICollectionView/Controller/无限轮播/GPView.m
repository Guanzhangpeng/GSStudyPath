//
//  GPView.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2019/5/14.
//  Copyright © 2019 管章鹏. All rights reserved.
//

#import "GPView.h"

@implementation GPView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 必须清空背景色，不然绘制出来的区域之外有黑色背景
//        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    float x = rect.origin.x;
    float y = rect.origin.y;
    float w = rect.size.width;
    float h = rect.size.height;
    // 一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 画笔线的颜色
    CGContextSetRGBStrokeColor(context,1,0,0,0);
    // 线的宽度
    CGContextSetLineWidth(context, 1.0);
    // 填充颜色
    UIColor *fullColor = [UIColor whiteColor];
    CGContextSetFillColorWithColor(context, fullColor.CGColor);
    // 绘制路径
    CGContextMoveToPoint(context,x,y);
    CGContextAddLineToPoint(context,x,h);
    CGContextAddLineToPoint(context,w,h);
    CGContextAddLineToPoint(context,w,y);
    CGContextAddArcToPoint(context,w/2.0,30,x,y,w*2);
    CGContextAddLineToPoint(context,x,y);
    // CGContextStrokePath(context);
    // 绘制路径加填充
    CGContextDrawPath(context, kCGPathFillStroke);
}
@end
