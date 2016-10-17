//
//  NSString+WFWExtension.h
//  NSDateTest
//
//  Created by wangfeiyuan on 15/12/11.
//  Copyright © 2015年 wangfeiwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WFWExtension)

#pragma mark - 时间字符串转与NSTimeInterval字符串互转
//将时间字符串转为NSTimeInterval字符串
+ (NSString *)timeIntervalStringFromDateString:(NSString *)string withFormatString:(NSString *)formatString;
//将NSTimeInterval字符串转为时间字符串
+ (NSString *)dateStringFromTimeIntervalString:(NSString *)string withFormatString:(NSString *)formatString;

#pragma mark - NSDate与NSTimeInterval字符串互转
//NSDate转NSTimeInterval字符串
+ (NSString *)timeIntervalStringFromDate:(NSDate *)date;
//NSTimeInterval字符串转NSDate
+ (NSDate *)dateFromTimeIntervalString:(NSString *)timeIntervalString;

// 获取今天日期的timeInterval格式字符串
+ (NSString *)timeIntervalStringOfToday;

#pragma mark - NSDate与时间字符串互转
//NSDate转时间字符串
+ (NSString *)dateStringFromDate:(NSDate *)date withFormatString:(NSString *)formatString;
//将时间字符串转为NSDate
+ (NSDate *)dateFromDateString:(NSString *)dateString withFormatString:(NSString *)formatString;

@end
