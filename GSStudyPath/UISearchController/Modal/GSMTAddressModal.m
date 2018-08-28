//
//  GSMTAddressModal.m
//  GSStudyPath
//
//  Created by 管章鹏 on 2018/8/28.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSMTAddressModal.h"

@implementation GSMTAddressModal

- (instancetype)init {
    if (self = [super init]) {
        NSString *cityPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        NSString *cityDataPath = [[NSBundle mainBundle] pathForResource:@"citydata" ofType:@"plist"];
        
        _cityArr = [NSMutableArray arrayWithContentsOfFile:cityPath];
        NSMutableArray* _cityDataArr = [NSMutableArray arrayWithContentsOfFile:cityDataPath];
        //对数据进行处理
        _cityDataDict = [self filterCityData:_cityDataArr];
    }
    return self;
}

- (NSMutableDictionary *)filterCityData:(NSArray *)cityDataArr {
    
    NSMutableDictionary *citiesDict = [NSMutableDictionary dictionary];
    for (NSDictionary *provinceDict in cityDataArr) {
        NSArray *cityList = provinceDict[@"citylist"];
        for (NSDictionary *dict in cityList) {
            NSMutableString *cityName = [NSMutableString stringWithString:dict[@"cityName"]];
            if (![cityName hasSuffix:@"市"]) {
                [cityName appendString:@"市"];
            }
            
            NSArray *areas = dict[@"arealist"];
            NSMutableArray *areaArray = [NSMutableArray array];
            
            for (NSDictionary *areaDict in areas) {
                [areaArray addObject:areaDict[@"areaName"]];
            }
            citiesDict[cityName] = areaArray;
        }
    }
    return citiesDict;
}
@end
