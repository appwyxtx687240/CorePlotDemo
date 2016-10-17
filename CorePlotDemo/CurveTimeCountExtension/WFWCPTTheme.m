//
//  WFWCPTTheme.m
//  CorePotDemoEight
//
//  Created by wangfeiyuan on 15/12/10.
//  Copyright © 2015年 wangfeiwan. All rights reserved.
//

#import "WFWCPTTheme.h"
#import "CPTColor.h"

@implementation WFWCPTTheme

/**设置画布样式*/
-(void)applyThemeToBackground:(CPTGraph *)graph
{
    //1.背景图
    graph.fill = [CPTFill fillWithColor:[CPTColor colorWithCGColor:[UIColor whiteColor].CGColor]];
    
    //2.边距
    graph.paddingLeft   = CPTFloat(10.0);
    graph.paddingTop    = CPTFloat(80.0);
    graph.paddingRight  = CPTFloat(10.0);
    graph.paddingBottom = CPTFloat(10.0);
}

/**设置XY轴样式*/
-(void)applyThemeToAxisSet:(CPTAxisSet *)axisSet
{
    //3.坐标轴
    //3.1 x轴
    //获取图纸对象的坐标系

    // 设置坐标系风格
    // 从坐标轴集合转为XY轴集合(CPTAxisSet和CPTXYAxisSet不是同一个类)
    CPTXYAxisSet *xyAxisSet = (CPTXYAxisSet *)axisSet;
    
    
    CPTXYAxis *x = xyAxisSet.xAxis;
    //设置每个大刻度线之间分布几个小刻度线
    x.minorTicksPerInterval = 0;//横轴坐标是按数据给的这里无效
    
    //设置样式
    CPTMutableLineStyle *xLineStyle = [CPTMutableLineStyle lineStyle];
    xLineStyle.lineWidth = 1.0;
    xLineStyle.lineColor = [CPTColor lightGrayColor];
    //(1)小刻度的样式(minor较小的,Tick标记)
    //    x.minorTickLineStyle = xLineStyle;
    //(2)网格的样式
    //    x.majorGridLineStyle = xLineStyle;
    //(3)主刻度的样式
    x.majorTickLineStyle = xLineStyle;
    //(4)x轴横轴样式
    x.axisLineStyle = xLineStyle;
    //(5)刻度标签样式
    CPTMutableTextStyle *whiteTextStyle = [[CPTMutableTextStyle alloc] init];
    whiteTextStyle.color = [CPTColor whiteColor];
    whiteTextStyle.fontSize = CPTFloat(10.0);
    x.labelTextStyle = whiteTextStyle;
    //主刻度与小刻度的区别主要在于主刻度下面有对应的标签.
    
    //3.2 y轴
    CPTXYAxis *y = xyAxisSet.yAxis;
    //刻度间隔为10
    y.majorIntervalLength = [NSNumber numberWithFloat:10];
    
    //样式
    CPTMutableLineStyle *yLineStyle = [CPTMutableLineStyle lineStyle];
    yLineStyle.lineWidth = 1.0;
    yLineStyle.lineColor = [CPTColor lightGrayColor];
    //(1)小刻度的样式(minor较小的,Tick标记)
    //    y.minorTickLineStyle = xLineStyle;
    //(2)网格的样式
    //    x.majorGridLineStyle = xLineStyle;
    //(3)主刻度的样式
    y.majorTickLineStyle = yLineStyle;
    //(4)x轴横轴样式
    y.axisLineStyle = yLineStyle;
    y.labelTextStyle = whiteTextStyle;
    //设置小数点个数
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:0];
    y.labelFormatter = numberFormatter;
    
  
}



@end
