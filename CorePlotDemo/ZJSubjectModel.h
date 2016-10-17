//
//  ZJSubjectModel.h
//  FundManager
//
//  Created by Summer on 16/9/20.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "JSONModel.h"
#import "ZJBondModel.h"

@class ZJSubjectScoreModel;

/**
 主体模型
 */
@interface ZJSubjectModel : JSONModel

/**
 主体名称
 */
@property (copy, nonatomic) NSString<Optional> *main_name;
/**
 企业/主体性质
 */
@property (copy, nonatomic) NSString<Optional> *com_property;
/**
 收藏状态 Y 收藏  N 未收藏
 */
@property (copy, nonatomic) NSString<Optional> *collect_state;
/**
 预警原因
 */
@property (copy, nonatomic) NSString<Optional> *re_warning;
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
 总体评分 对象
 */
@property (copy, nonatomic) ZJSubjectScoreModel<Optional> *main_score_card;
/**
 其他评分项 集合
 */
@property (strong, nonatomic) NSArray<ZJLittleGradeModel ,Optional> *little_grade;

/**
 主体id
 */
@property (copy, nonatomic) NSString<Optional> *mid;

/**
 排序
 */
@property (copy, nonatomic) NSString<Optional> *order;

/**
 主体状态, 0 正常  1 违约  2 破产  3 重组  4 注销
 */
@property (copy, nonatomic) NSString<Optional> *state;

/**
 是否命中推荐的热点要闻 0 没命中 1命中
 */
@property (copy, nonatomic) NSString<Optional> *is_hot;
/**
 主体是否预警, 0 正常 1 预警
 */
@property (copy, nonatomic) NSString<Optional> *is_warning;

/**
 主体状态对应的标题

 @return
 */
-(NSString *)titleForState;

@end


/**
 主体风险榜
 */
@interface ZJSubjectRiskModel : JSONModel

/**
 主体名称
 */
@property (copy, nonatomic) NSString<Optional> *main_name;

/**
 预警原因
 */
@property (copy, nonatomic) NSString<Optional> *re_warning;

/**
 主体id
 */
@property (copy, nonatomic) NSString<Optional> *mid;

@end



/**
 主体违约榜
 */
@interface ZJSubjectViolateModel : JSONModel

/**
 主体名称
 */
@property (copy, nonatomic) NSString<Optional> *main_name;

/**
 违约时间
 */
@property (copy, nonatomic) NSString<Optional> *default_time;

/**
 主体id
 */
@property (copy, nonatomic) NSString<Optional> *mid;

@end



/**
 事件榜
 */
@interface ZJSubjectEventModel : JSONModel

/**
 主体名称
 */
@property (copy, nonatomic) NSString<Optional> *main_name;

/**
 事件摘要
 */
@property (copy, nonatomic) NSString<Optional> *event_content;

/**
 主体id
 */
@property (copy, nonatomic) NSString<Optional> *mid;

/**
 命中标签,0 新闻热点 1 机构观点
 */
@property (copy, nonatomic) NSString<Optional> *type;


/**
 获取命中标签对应的标题

 @return 
 */
-(NSString *)titleForType;
@end














