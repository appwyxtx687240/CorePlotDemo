//
//  ZJBondModel.m
//  FundManager
//
//  Created by Summer on 16/9/20.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "ZJBondModel.h"

@implementation ZJBondModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"new_state":@"theNewState"}];
}


-(NSString *)titleForState{
    if ([self.state isEqualToString:@"0"]) {
        return @"正常";
    }else if ([self.state isEqualToString:@"1"]) {
        return @"违约";
    }else if ([self.state isEqualToString:@"2"]) {
        return @"破产";
    }else if ([self.state isEqualToString:@"3"]) {
        return @"重组";
    }else if ([self.state isEqualToString:@"4"]) {
        return @"注销";
    }else{
        return nil;
    }
}

@end


