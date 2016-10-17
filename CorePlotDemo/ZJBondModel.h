//
//  ZJBondModel.h
//  FundManager
//
//  Created by Summer on 16/9/20.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "JSONModel.h"
@class ZJSubjectScoreModel;


@protocol ZJLittleGradeModel<NSObject>

@end

@protocol ZJLineChargeXModel<NSObject>

@end

@protocol ZJLineChargeModel<NSObject>

@end

@protocol ZJValueListModel<NSObject>

@end

@protocol ZJLineChargeDatasetModel<NSObject>

@end


/**
 债券模型
 */
@interface ZJBondModel : JSONModel

/**
 债券名称
 */
@property (copy, nonatomic) NSString<Optional> *bund_name;
/**
 债券代码
 */
@property (copy, nonatomic) NSString<Optional> *bund_code;
/**
 收藏状态, Y 已收藏 N未收藏
 */
@property (copy, nonatomic) NSString<Optional> *collect_state;
/**
 债券id
 */
@property (copy, nonatomic) NSString<Optional> *bid;
/**
 票面价格
 */
@property (copy, nonatomic) NSString<Optional> *issue_price;
/**
 发行日期
 */
@property (copy, nonatomic) NSString<Optional> *iss_datetime;
/**
 债券期限
 */
@property (copy, nonatomic) NSString<Optional> *deadline;
/**
 发行规模（万元）,保存两位小数
 */
@property (copy, nonatomic) NSString<Optional> *scale;

/**
 主体评级,来自键值
 */
@property (copy, nonatomic) NSString<Optional> *main_rate;

/**
 主体评级机构
 */
@property (copy, nonatomic) NSString<Optional> *rate_org;

/**
 债券产品类型, 来自键值
 */
@property (copy, nonatomic) NSString<Optional> *pro_type;

/**
 主承销商
 */
@property (copy, nonatomic) NSString<Optional> *lead;

/**
 发行人
 */
@property (copy, nonatomic) NSString<Optional> *publisher;

/**
 企业/主体性质
 */
@property (copy, nonatomic) NSString<Optional> *com_property;

/**
 起息日期
 */
@property (copy, nonatomic) NSString<Optional> *date_of_value;
/**
 付息频率
 */
@property (copy, nonatomic) NSString<Optional> *next_pay;
/**
 到期日期
 */
@property (copy, nonatomic) NSString<Optional> *mat_date;

/**
 担保方式
 */
@property (copy, nonatomic) NSString<Optional> *gua_style;
/**
 担保人, （公司名称，会很长）
 */
@property (copy, nonatomic) NSString<Optional> *bondsman;
/**
 是否为新债, 0 新债 1 续存 2旧债
 */
@property (copy, nonatomic) NSString<Optional> *isnew;

/**
 主体id
 */
@property (copy, nonatomic) NSString<Optional> *mainid;

/**
 注册资本
 */
@property (copy, nonatomic) NSString<Optional> *register_money;

/**
 上一季度收入
 */
@property (copy, nonatomic) NSString<Optional> *quarter_income;

/**
 上一季度利润
 */
@property (copy, nonatomic) NSString<Optional> *quarter_profit;

/**
 行业分类
 */
@property (copy, nonatomic) NSString<Optional> *profession;

/**
 总体评分
 */
@property (strong, nonatomic) ZJSubjectScoreModel<Optional> *main_score_card;

/**
 其他评分项
 */
@property (strong, nonatomic) NSArray<ZJLittleGradeModel, Optional> *little_grade;
/**
 主体状态 0 正常  1违约 2破产 3 重组  4注销
 */
@property (copy, nonatomic) NSString<Optional> *state;
/**
 主体是否预警 0 正常 1 预警
 */
@property (copy, nonatomic) NSString<Optional> *is_warning;

/**
 是否命中热点要闻, 0 没命中 1命中
 */
@property (copy, nonatomic) NSString<Optional> *is_hot;

/**
 排序
 */
@property (copy, nonatomic) NSString<Optional> *order;


/**
 主体状态对应的标题

 @return
 */
-(NSString *)titleForState;

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
@property (strong, nonatomic) NSArray<ZJLineChargeModel, Optional> *line_charge;

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



