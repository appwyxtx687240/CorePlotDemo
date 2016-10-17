//
//  ZJSubjectScoreModel.h
//  FundManager
//
//  Created by Summer on 16/9/27.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "JSONModel.h"
#import "ZJLineChargeModel.h"

/**
 总体评分模型
 */
@interface ZJSubjectScoreModel : JSONModel

/**
 评分卡的名称，例如：主体信用总评分
 */
@property (copy, nonatomic) NSString<Optional> *score_card_titile;

/**
 评分卡的最近一次总分
 */
@property (copy, nonatomic) NSString<Optional> *score_card_value;
/**
 关于评分的几句话说明
 */
@property (copy, nonatomic) NSString<Optional> *score_card_brief;
/**
 图表数据，是历史评分，用来画折线图
 */
@property (strong, nonatomic) ZJLineChargeModel<Optional> *line_charge;


@end
