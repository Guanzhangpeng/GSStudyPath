//
//  GSCarModal.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSCarModal.h"

@implementation GSCarModal

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)CarWithDict: (NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)CarsWithArray:(NSArray *)array{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        [arrayM addObject:[GSCarModal CarWithDict:array[i]]];
    }
    return arrayM;
    
}
@end
