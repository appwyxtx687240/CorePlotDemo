//
//  ZJPlotScoreCell.m
//  CorePlotDemo
//
//  Created by Summer on 2016/10/17.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "ZJPlotScoreCell.h"
#import "CorePlot-CocoaTouch.h"
#import "ZJSubScoreCell.h"


@interface ZJPlotScoreCell ()<UITableViewDataSource, UITableViewDelegate>

/**
 主体评分
 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

/**
 评分的简短描述
 */
@property (weak, nonatomic) IBOutlet UILabel *briefLabel;

/**
 画图的背景view
 */
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostView;

/**
 画图的头视图, 包括线条名称及所表示的线条样式
 */
@property (weak, nonatomic) IBOutlet UIView *graphHeaderView;

/**
 展示分项评分的列表
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZJPlotScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
}

-(void)setSubjectScore:(ZJSubjectScoreModel *)subjectScore {
    _subjectScore = subjectScore;


}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"Cell" owner:nil options:nil]lastObject];
    }

//    cell.model = self.items[indexPath.row];

    return cell;
}



@end
