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
- (id)forwardingTargetForSelector:(SEL)selector
{
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}
@end
