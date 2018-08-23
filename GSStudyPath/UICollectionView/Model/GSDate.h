//
//  GSDate.h
//  UICollectionViewLayout
//
//  Created by 管章鹏 on 2018/7/5.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSDate : NSObject

/**
 * 计算当月共有多少天
 **/
+ (NSInteger)totalDaysInMonthFromDate:(NSDate *)date;

+ (NSInteger)weekDayMonthOfFirstDayFromStr:(NSString*)dateStr;
/**
 * 计算当月日期的星期分布
 **/
+ (NSInteger)weekDayMonthOfFirstDayFromDate:(NSDate*)date;
@end
