//
//  GSQQFriendModal.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/30.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSQQFriendModal.h"

@implementation GSQQFriendModal

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)friendWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)friendsWithArray:(NSArray *)friendsArray{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (NSDictionary *dict in friendsArray) {
        GSQQFriendModal *friendModal = [[self alloc] initWithDict:dict];
        [dataArray addObject:friendModal];
    }
    return dataArray;
}

@end
