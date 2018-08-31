//
//  GSQQFriendsGroup.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/30.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSQQFriendsGroup.h"
#import "GSQQFriendModal.h"

@implementation GSQQFriendsGroup

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.online = [dict[@"online"] integerValue];
        self.friends = [GSQQFriendModal friendsWithArray:dict[@"friends"]];
    }
    return self;
}
+ (instancetype)friendsGroupWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
