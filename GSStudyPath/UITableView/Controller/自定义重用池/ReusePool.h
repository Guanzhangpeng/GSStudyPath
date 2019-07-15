//
//  ReusePool.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2019/7/15.
//  Copyright © 2019 管章鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//实现重用机制的类
@interface ReusePool : NSObject

//从重用池中获取一个视图View
- (UIView *)dequeueReusabelView;

//向重用池中添加一个视图View
- (void)addUsingView:(UIView *)view;

//重用方法. 将当前正在使用的视图View添加到可重用队列中.
- (void)reset;
@end

NS_ASSUME_NONNULL_END
