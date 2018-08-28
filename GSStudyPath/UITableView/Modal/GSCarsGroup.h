//
//  GSCarsGroup.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GSCarModal;
@interface GSCarsGroup : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<GSCarModal *> *cars;
@property (nonatomic, strong) NSArray<GSCarsGroup *> *carsGroupArray;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)carsGroupWithDict:(NSDictionary *)dict;

+ (NSArray *)carsGroup;

@end
