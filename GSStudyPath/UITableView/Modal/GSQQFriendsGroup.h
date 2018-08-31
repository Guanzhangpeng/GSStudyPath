//
//  GSQQFriendsGroup.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/30.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GSQQFriendModal;

@interface GSQQFriendsGroup : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger online;
@property (nonatomic, strong) NSArray<GSQQFriendModal *> *friends;

@property (nonatomic, assign, getter=isOpen) BOOL open;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendsGroupWithDict:(NSDictionary *)dict;

@end
