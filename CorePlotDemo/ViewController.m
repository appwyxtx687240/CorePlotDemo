//
//  ViewController.m
//  CorePlotDemo
//
//  Created by Summer on 2016/10/11.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "ViewController.h"
#import "CorePlot-CocoaTouch.h"

@interface ViewController ()

@property (strong, nonatomic) CPTXYGraph *scatterGraph;

@property (strong, nonatomic) NSMutableArray *dataForPlot;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CPTXYGraph *newGraph = [[CPTXYGraph alloc]initWithFrame:CGRectZero];

}



@end
