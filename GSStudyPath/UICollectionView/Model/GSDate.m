//
//  GSDate.m
//  UICollectionViewLayout
//
//  Created by 管章鹏 on 2018/7/5.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "GSDate.h"

@implementation GSDate

+ (NSInteger)totalDaysInMonthFromDate:(NSDate *)date{
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}
+ (NSInteger)weekDayMonthOfFirstDayFromStr:(NSString*)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; //GMT
    
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:dateStr];
    
    return  [self weekDayMonthOfFirstDayFromDate:date];
}

+ (NSInteger)weekDayMonthOfFirstDayFromDate:(NSDate*)date{
    
    // 1 sun  2 Mon 3 thes
    NSInteger firstDayOfMonthInt = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    
    return firstDayOfMonthInt-1;
}
@end
