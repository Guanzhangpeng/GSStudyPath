//
//  GSProxy.m
//  kdzs
//
//  Created by 管章鹏 on 2018/8/1.
//  Copyright © 2018年 gzp. All rights reserved.
//

#import "GSProxy.h"

@implementation GSProxy

+(instancetype)proxyWithTarget:(id)target{
    GSProxy *proxy = [GSProxy alloc];
    proxy.target = target;
    return proxy;
}
-(void)forwardInvocation:(NSInvocation *)invocation{

    [invocation invokeWithTarget:self.target];
}
-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSMethodSignature *signature = nil;
    if ([self.target methodSignatureForSelector:sel]) {
        signature = [self.target methodSignatureForSelector:sel];
    }
    else
    {
        signature = [super methodSignatureForSelector:sel];
    }
    return signature;
}
@end
