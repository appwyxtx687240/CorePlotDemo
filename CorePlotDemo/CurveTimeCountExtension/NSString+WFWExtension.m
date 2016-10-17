//
//  NSString+WFWExtension.m
//  NSDateTest
//
//  Created by wangfeiyuan on 15/12/11.
//  Copyright © 2015年 wangfeiwan. All rights reserved.
//

#import "NSString+WFWExtension.h"
#import "NSDate+FSExtension.h"
#import "NSString+FSExtension.h"

@implementation NSString (WFWExtension)

#pragma mark - 时间字符串转与NSTimeInterval字符串互转
/**将时间字符串转为NSTimeInterval字符串*/
+ (NSString *)timeIntervalStringFromDateString:(NSString *)string withFormatString:(NSString *)formatString
{
    //1.NSDate字符串转NSDate
    NSDate *date = [NSDate fs_dateFromString:string format:formatString];
    //2.NSDate转NSTimeInterval
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    //3.NSTimeInterval转为NSTimeInterval字符串
    NSString *timeIntervalString = [NSString stringWithFormat:@"%.0f",timeInterval];
    
    return timeIntervalString;
}
/**将NSTimeInterval字符串转为时间字符串**/
+ (NSString *)dateStringFromTimeIntervalString:(NSString *)string withFormatString:(NSString *)formatString
{
    //1.NSTimeInterval字符串转换为NSTimeInterval
    //时间字符串一般为10位
    // 非空
    if (![string isEqual:[NSNull null]])
    {
        if (string.length <= 8)
        {
            return @"";
        }else
        {
            NSTimeInterval timeInterval = [string doubleValue];
            //2.NSTimeInterval转换为NSDate
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
            //3.NSDate转换为NSDate字符串
            NSString *dateString = [date fs_stringWithFormat:formatString];
            
            return dateString;
        }
    }
    else
    {
        return @"";
    }

}


#pragma mark - NSDate与NSTimeInterval字符串互转
/**NSDate转NSTimeInterval字符串*/
+ (NSString *)timeIntervalStringFromDate:(NSDate *)date
{
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    //3.NSTimeInterval转为NSTimeInterval字符串
    NSString *timeIntervalString = [NSString stringWithFormat:@"%.0f",timeInterval];
    return timeIntervalString;
}
/**NSDate转NSTimeInterval字符串*/
+ (NSDate *)dateFromTimeIntervalString:(NSString *)timeIntervalString
{
    NSTimeInterval timeInterval = [timeIntervalString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return date;
}


/**获取今天日期的timeInterval格式字符串*/
+ (NSString *)timeIntervalStringOfToday
{
    //1.获取今天的NSDate值
    NSDate *date = [NSDate date];
    //2.NSDate转NSTimeInterval
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    //3.NSTimeInterval转为NSTimeInterval字符串
    NSString *timeIntervalString = [NSString stringWithFormat:@"%.0f",timeInterval];
    
    return timeIntervalString;
}

#pragma mark - NSDate与时间字符串互转
//NSDate转时间字符串
+ (NSString *)dateStringFromDate:(NSDate *)date withFormatString:(NSString *)formatString
{
    //3.NSDate转换为NSDate字符串
    NSString *dateString = [date fs_stringWithFormat:formatString];
    return dateString;
}
//将时间字符串转为NSDate
+ (NSDate *)dateFromDateString:(NSString *)dateString withFormatString:(NSString *)formatString
{
    //时间字符串转换为NSDate
    NSDate *date = [NSDate fs_dateFromString:dateString format:formatString];
    return date;
}

@end
