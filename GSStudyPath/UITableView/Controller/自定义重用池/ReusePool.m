//
//  ReusePool.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2019/7/15.
//  Copyright © 2019 管章鹏. All rights reserved.
//

#import "ReusePool.h"

@interface ReusePool()
//等待使用的队列
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;

//正在使用的队列
@property (nonatomic, strong) NSMutableSet *usingQueue;
@end
@implementation ReusePool

-(instancetype)init{
    if (self = [super init]) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}
//从重用池中获取一个视图View
- (UIView *)dequeueReusabelView{
   UIView *view = [_waitUsedQueue anyObject];
    if (nil == view) {
        //说明重用池是空的
        return nil;
    }else{
        [_waitUsedQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}

//向重用池中添加一个视图View
- (void)addUsingView:(UIView *)view{
    if (view == nil) {
        return;
    }
    [_usingQueue addObject:view];
}

//重用方法. 将当前正在使用的视图View添加到可重用队列中.
- (void)reset{
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        [_waitUsedQueue addObject:view];
        [_usingQueue removeObject:view];
    }
}
@end
