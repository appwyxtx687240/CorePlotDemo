//
//  ZJSubScoreCell.h
//  CorePlotDemo
//
//  Created by Summer on 2016/10/17.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSubjectScoreModel.h"

@interface ZJSubScoreCell : UITableViewCell

/**
 评分模型
 */
@property (strong, nonatomic) ZJSubjectScoreModel *score;
@end
