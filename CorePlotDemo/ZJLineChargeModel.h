//
//  ZJLineChargeModel.h
//  CorePlotDemo
//
//  Created by Summer on 2016/10/17.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "JSONModel.h"

@protocol ZJLittleGradeModel<NSObject>

@end

@protocol ZJLineChargeXModel<NSObject>

@end

@protocol ZJValueListModel<NSObject>

@end

@protocol ZJLineChargeDatasetModel<NSObject>

@end

/**
 历史评分
 */
@interface ZJLineChargeModel : JSONModel

/**
 整数值，x轴长度，不得小于1，如果小于1则认为line charge无效
 */
@property (copy, nonatomic) NSString<Optional> *line_charge_length;

/**
 X轴的文字集合
 */
@property (strong, nonatomic) NSArray<ZJLineChargeXModel, Optional> *line_charge_x;

/**
 整数值，数据集个数，不得小于1，如果小于1则认为line charge无效
 */
@property (copy, nonatomic) NSString<Optional> *line_charge_dataset_count;

/**
 画线的集合，每条线的纵坐标集合
 */
@property (strong, nonatomic) NSArray<ZJLineChargeDatasetModel, Optional> *line_charge_dataset;


@end


/**
 评分项及分数
 */
@interface ZJLittleGradeModel : JSONModel

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

/**
 横坐标
 */
@interface ZJLineChargeXModel : JSONModel

/**
 X轴的坐标段
 */
@property (copy, nonatomic) NSString<Optional> *x_name;

@end


/**
 纵坐标集合
 */
@interface ZJLineChargeDatasetModel : JSONModel

/**
 Y轴值的名称
 */
@property (copy, nonatomic) NSString<Optional> *value_title;
/**
 Y轴值集合
 */
@property (strong, nonatomic) NSArray<ZJValueListModel, Optional> *value_list;

@end

/**
 纵坐标
 */
@interface ZJValueListModel : JSONModel

/**
 Y轴值
 */
@property (copy, nonatomic) NSString<Optional> *y_value;

@end

