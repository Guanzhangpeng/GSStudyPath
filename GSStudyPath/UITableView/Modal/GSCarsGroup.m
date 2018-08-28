//
//  GSCarsGroup.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSCarsGroup.h"
#import "GSCarModal.h"
@implementation GSCarsGroup

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValue:dict[@"title"] forKey:@"title"];
//        [self setValue:dict[@"cars"] forKey:@"cars"];
        self.cars = [GSCarModal CarsWithArray:dict[@"cars"]];
    }
    return self;
}
+ (instancetype)carsGroupWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)carsGroup{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total" ofType:@"plist"];
    NSArray *dataArray= [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *carsArray = [NSMutableArray array];
    for (int i=0; i<dataArray.count; i++) {
        GSCarsGroup *carsGroup = [GSCarsGroup carsGroupWithDict:dataArray[i]];
        [carsArray addObject:carsGroup];
    }
    return carsArray;
}
@end
