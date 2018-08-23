//
//  GSProxy.h
//  kdzs
//
//  Created by 管章鹏 on 2018/8/1.
//  Copyright © 2018年 gzp. All rights reserved.
//  代理对象 用于解决NSTimer循环引用问题

#import <Foundation/Foundation.h>

@interface GSProxy : NSProxy

@property (nonatomic, weak) id target;
+ (instancetype) proxyWithTarget:(id)target;
@end
