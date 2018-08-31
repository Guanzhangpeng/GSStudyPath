//
//  GSQQFriendModal.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/30.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSQQFriendModal : NSObject

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, assign, getter= isVip) BOOL vip;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendWithDict:(NSDictionary *)dict;

+ (NSArray *)friendsWithArray:(NSArray *)friendsArray;
@end
