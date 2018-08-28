//
//  GSCarModal.h
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSCarModal : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)CarWithDict: (NSDictionary *)dict;

+ (NSArray *)CarsWithArray:(NSArray *)array;
@end
