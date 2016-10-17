//
//  WFWCurveListViewModel.h
//  qyzy
//
//  Created by wangfeiyuan on 16/1/12.
//  Copyright © 2016年 Chinamobo. All rights reserved.
//

#import "JSONModel.h"
/**曲线列表Model*/
@interface WFWCurveListViewModel : JSONModel

/**血高压数据列表*/
@property (strong, nonatomic) NSArray <Optional> *phvalue_list;
/**血低压数据列表*/
@property (strong, nonatomic) NSArray <Optional> *plvalue_list;
/**血压范围最大值*/
@property (strong, nonatomic) NSString <Optional> *prange_max;
/**血压范围最小值*/
@property (strong, nonatomic) NSString <Optional> *prange_min;
/**血压单位*/
@property (strong, nonatomic) NSString <Optional> *putil;

@end

/**曲线列表子Model-血高压数据列表/*/
@interface WFWCurveListViewChildrenModel : JSONModel

/**监测录入值*/
@property (strong, nonatomic) NSString <Optional> *inputvalue;
/**录入日期*/
@property (strong, nonatomic) NSString <Optional> *smdate;

@end
