//
//  CurveListViewController.m
//  qyzy
//
//  Created by wangfeiyuan on 15/11/23.
//  Copyright © 2015年 Chinamobo. All rights reserved.
//

#import "CurveListViewController.h"
#import "WFWCPTTheme.h"
#import "NSString+WFWExtension.h"
#import "WFWCurveListViewModel.h"



//通用小圆点填充颜色
#define LINECOLOR 0xffd432

//高压线条小圆点颜色
#define HIGHBLOODLINECOLOR 0x3dd7af


@interface CurveListViewController ()
/**
 * 高血压曲线图相关属性
 */
//高血压宿主视图
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *highBloodGraphView;
/**高压图例*/
@property (weak, nonatomic) IBOutlet UIImageView *highBloodGraphicSymbolImageView;
/**低压图例*/
@property (weak, nonatomic) IBOutlet UIImageView *lowBloodGraphicSymbolImageView;
/**高血压头视图*/
@property (weak, nonatomic) IBOutlet UIView *highBloodHeaderView;
//高血压图片背景
@property (nonatomic, strong) CPTXYGraph *highBloodGraph;
//高压数据点数组
@property (nonatomic, strong) NSMutableArray *highBloodPoints;
//低压数据点数组
@property (nonatomic, strong) NSMutableArray *lowBloodPoints;



/**存储总下载数据的Model*/
@property (nonatomic, strong) WFWCurveListViewModel *dataModel;

@end

@implementation CurveListViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];

    [self initUI];

    [self downloadData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 @property (strong, nonatomic) NSArray <Optional> *phvalue_list;
 @property (strong, nonatomic) NSArray <Optional> *plvalue_list;
 @property (strong, nonatomic) NSString <Optional> *prange_max;
 @property (strong, nonatomic) NSString <Optional> *prange_min;
 @property (strong, nonatomic) NSString <Optional> *putil;
 */
#pragma mark - NetWork
/**下载数据*/
- (void)downloadData
{


    WFWCurveListViewModel *model = [[WFWCurveListViewModel alloc] init];
    model.plvalue_list = @[
                           @{@"smdate":@"1473749091", @"inputvalue":@"60"},
                           @{@"smdate":@"1473759091", @"inputvalue":@"70"},
                           @{@"smdate":@"1473769091", @"inputvalue":@"80"},
                           @{@"smdate":@"1473779091", @"inputvalue":@"60"}];

    model.phvalue_list = @[
                           @{@"smdate":@"1473749091", @"inputvalue":@"100"},
                           @{@"smdate":@"1473759091", @"inputvalue":@"110"},
                           @{@"smdate":@"1473769091", @"inputvalue":@"120"},
                           @{@"smdate":@"1473779091", @"inputvalue":@"100"}];
    model.prange_max = @"220";
    model.prange_min = @"50";
    model.putil = @"Pa";
    _dataModel = model;

    /**高血压*/
    // 高压数组值赋值
    [_highBloodPoints addObjectsFromArray:model.phvalue_list?:[NSMutableArray array]];
    // 低压数组值赋值
    [_lowBloodPoints addObjectsFromArray:model.plvalue_list?:[NSMutableArray array]];

    [self loadData];

}

#pragma mark - InitUI
/**加载视图方法*/
- (void)initUI
{
    //容器数组初始化
    _highBloodPoints = [NSMutableArray array];
    _lowBloodPoints = [NSMutableArray array];

}

#pragma mark - DealWithData

#pragma mark - LoadData
// 加载数据
- (void)loadData
{
    [self loadHighBloodGraph];
}

#pragma mark - 血压曲线列表
#pragma mark -加载血压曲线列表总方法
- (void)loadHighBloodGraph
{
    // 设置头视图
    [self setupHeaderViewOfHighBlood];
    // 设置图纸视图
    [self setupGraphViewOfHighBlood];


    // 设置图形空间
    // 一屏暂展示0-4共五个数据
    [self setupSpaceOfHighBloodWithXOfPlotSpaceToLeft:60 * 60 * 12
                                withXOfPlotSpaceToRight:60 * 60 *12
                             withTimesOfLeftSpaceToPlot:0.25
                            withTimesOfRightSpaceToPlot:0.25
                                   withIndexOfStartData:0
                                     withIndexOfEndData:4
                                       withYOriginPoint:40
                                 withYOriginToScreenTop:90
                              withYOriginToScreenBottom:20
                                 withXSlideSpaceToRight:60 * 60 * 24 * 5
                                        withXStringName:@"smdate"
                                        withYStringName:@"inputvalue"];
    // 设置坐标轴
    [self setupAxisViewOfHighBloodWithYStepLength:10
                        withXAxisConstraintToBottom:25
                          withYAxisConstraintToLeft:25
                    withYMinStartPointOfExceptPoint:20
                      withYMinEndPointOfExceptPoint:40
                    withYMaxStartPointOfExceptPoint:141
                      withYMaxEndPointOfExceptPoint:241];

    // 设置自定义x轴坐标值
    [self setupCustomXLocationOfHighBloodWithPointDataArray:_highBloodPoints
                                              withXStringName:@"smdate"
                                              withYStringName:@"inputvalue"];
    // 设置折线图
    [self setupPlotViewOfHighBlood];

}

#pragma mark-设置血压曲线图头视图
- (void)setupHeaderViewOfHighBlood
{
    //1.头视图设置
    //将头视图置为无响应
    self.highBloodHeaderView.userInteractionEnabled = NO;
    //图例设置圆角
    _highBloodGraphicSymbolImageView.layer.masksToBounds = YES;
    _lowBloodGraphicSymbolImageView.layer.masksToBounds = YES;
}


#pragma mark-设置血压曲线图纸视图
- (void)setupGraphViewOfHighBlood
{
    //2.图纸设置
    //2.1 宿主视图初始化(使用IB生成)
    CPTGraphHostingView *hostView = self.highBloodGraphView;
    //2.2 图纸视图视初始化
    _highBloodGraph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    //使用自定义主题
    CPTTheme *theme = [[WFWCPTTheme alloc] init];
    [_highBloodGraph applyTheme:theme];
    //2.3 宿主视图视持有图纸视图
    hostView.hostedGraph = _highBloodGraph;
}
#pragma mark-设置血压曲线图形空间
- (void)setupSpaceOfHighBloodWithXOfPlotSpaceToLeft:(double)xOfPlotSpaceToLeft     //一个点时折线图距离左边距的距离
                              withXOfPlotSpaceToRight:(double)xOfPlotSpaceToRight    //一个点折线图距离右边距的距离
                           withTimesOfLeftSpaceToPlot:(double)timesOfLeftSpaceToPlot //多个点时"折线图距离左边的距离"与"折线图宽度"的比例
                          withTimesOfRightSpaceToPlot:(double)timesOfRightSpaceToPlot//多个点时"折线图距离左边的距离"与"折线图宽
                                 withIndexOfStartData:(NSInteger)indexOfStart        //折线图一屏显示的数据起点下标数
                                   withIndexOfEndData:(NSInteger)indexOfEnd          //折线图一屏显示的数据终点下标数
                                     withYOriginPoint:(double)yOriginPoint           //Y轴原点纵坐标
                               withYOriginToScreenTop:(double)yOriginToScreenTop     //Y轴原点纵坐标距离顶部边缘距离
                            withYOriginToScreenBottom:(double)yOriginToScreenBottom  //Y轴原点纵坐标距离顶部边缘距离
                               withXSlideSpaceToRight:(double)xSlideSpaceToRight     //X轴向右边多滑动的范围
                                      withXStringName:(NSString *)xStringName        // 折线图X轴字段名称
                                      withYStringName:(NSString *)yStringName        // 折线图Y轴字段名称
{
    //3.图形空间(一屏展示内容及全局滑动范围)
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)_highBloodGraph.defaultPlotSpace;
    //允许滑动
    plotSpace.allowsUserInteraction = YES;
    //3.1 设置一屏内可显示的x,y坐标范围

    /**
     *  图形空间相关数据设置
     */

    /** X轴方向*/

    //折线图距离左边距的距离
    double XOfPlotSpaceToLeft =  xOfPlotSpaceToLeft;
    //折线图距离右边距的距离
    double XOfPlotSpaceToRight = xOfPlotSpaceToRight;

    //折线图一屏显示的起点的数据顺序数(开始显示第几个数据,从第一个点开始)
    NSInteger indexOfStartData = indexOfStart;
    //折线图一屏显示的终点的数据顺序数(最后显示第几个数据,到第五个点为止)
    NSInteger indexOfEndData = indexOfEnd;

    /** Y轴方向*/
    //Y轴和X轴交点位置Y的坐标值,即Y轴原点
    double YOriginPoint = yOriginPoint;
    //Y轴原点距离顶部边缘距离
    double YOriginToScreenTop = yOriginToScreenTop;
    //Y轴原点距离底部边缘距离
    double YOriginToScreenBottom = yOriginToScreenBottom;

    //X轴向右边多滑动的范围
    double XSlideSpaceToRight = xSlideSpaceToRight;

    //3.1.1 X轴方向范围

    // xRange,x轴方向图形空间宽度
    // 有两个属性,一是plotRangeWithLocationDecimal(起点),二是lengthDecimal(长度)
    // NSDecimal是小数类型,参数需要先转换成double类型,再用CPTDecimalFromDouble方法转换成NSDecimal类型
    // plotRangeWithLocationDecimal参数_x轴方向屏幕起点:从数据点数组中取出要展示的第一个数据(这里取第0个),减去("折线图距离y轴的距离" + "y轴距离屏幕左边缘的距离"),这里实际采用的2倍"折线图距离y轴的距离",即double xSpaceToScreenMargin = plotXSpaceToYAxis * 2;
    // lengthDecimal参数_x轴方向屏幕跨度长度:从数据点数组中取出要展示的最后一个数据(这里取第4个),加上"折线图距离屏幕边缘的距离",这里取2倍的"折线图距离左边缘的距离",就是xSpaceToScreenMargin * 2

    // 折线图起点
    double startOfPlot = 0;
    // 折线图终点
    double endOfPlot = 0;
    // 折线图圆点的范围长度
    double lengthOfPlot = endOfPlot - startOfPlot;
    // 折线图前面空的距离
    double xSpaceToLeft = 0;
    // 折线图后面空的距离
    double xSpaceToRight = 0;

    if (_highBloodPoints.count >= (indexOfEndData + 1))
    {// 大于等于5时

        startOfPlot = [_highBloodPoints[indexOfStartData][xStringName] doubleValue];

        endOfPlot = [_highBloodPoints[indexOfEndData][xStringName] doubleValue];

        lengthOfPlot = endOfPlot - startOfPlot;
        // 折线图宽度 * 倍数
        xSpaceToLeft = lengthOfPlot * timesOfLeftSpaceToPlot;

        xSpaceToRight = lengthOfPlot * timesOfRightSpaceToPlot;

        // 大于等于5时取前5个数据作为图形空间
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromDouble(startOfPlot - xSpaceToLeft)
                                                        lengthDecimal:CPTDecimalFromDouble(lengthOfPlot + xSpaceToLeft + xSpaceToRight)];
    }
    else if (_highBloodPoints.count > 1 && _highBloodPoints.count < (indexOfEndData + 1))
    {// 大于1小于5时

        startOfPlot = [_highBloodPoints[indexOfStartData][xStringName] doubleValue];
        // 折线图终点(用最后一个点)
        endOfPlot = [[_highBloodPoints lastObject][xStringName] doubleValue];

        lengthOfPlot = endOfPlot - startOfPlot;

        xSpaceToLeft = lengthOfPlot * timesOfLeftSpaceToPlot;

        xSpaceToRight = lengthOfPlot * timesOfRightSpaceToPlot;

        // 小于5时,取第一个数据到最后一个数据作为图形空间
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromDouble(startOfPlot - xSpaceToLeft)
                                                        lengthDecimal:CPTDecimalFromDouble(endOfPlot - startOfPlot + xSpaceToLeft + xSpaceToRight)];
    }
    else if (_highBloodPoints.count == 1)
    {// 1个点时
        startOfPlot = [_highBloodPoints[indexOfStartData][xStringName] doubleValue];
        // 折线图终点(用最后一个点)
        endOfPlot = [[_highBloodPoints lastObject][xStringName] doubleValue];

        lengthOfPlot = endOfPlot - startOfPlot;
        // 一个点时,折线图距左边距离等于给定的值
        xSpaceToLeft = XOfPlotSpaceToLeft;

        xSpaceToRight = XOfPlotSpaceToRight;

        // 前后空相同的给定值
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromDouble(startOfPlot - xSpaceToLeft)
                                                        lengthDecimal:CPTDecimalFromDouble(lengthOfPlot + xSpaceToLeft + xSpaceToRight)];
    }

    //3.1.2 Y轴方向范围

    // y轴的范围可以固定

    // 要注意,这里所指的x轴只是假想的参考,并不会实际影响x轴的位置,因为x轴固定约束了距离底边的距离
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(YOriginPoint - YOriginToScreenBottom)
                                                    lengthDecimal:CPTDecimalFromFloat(YOriginPoint + YOriginToScreenTop)];


    //3.2 设置全局x,y坐标滑动范围
    //3.2.1 X轴方向滑动范围
    if (_highBloodPoints.count > 0)
    {// 有值时
        //滑动范围为"最后一个数据" - "第一个数据" + "折线图距离屏幕边缘的距离" + "多出的滑动范围"
        double firstXPoint = [_highBloodPoints[0][xStringName] doubleValue];
        double lastXPoint = [[_highBloodPoints lastObject][xStringName] doubleValue];

        plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromDouble(firstXPoint - xSpaceToLeft)
                                                              lengthDecimal:CPTDecimalFromDouble(lastXPoint - firstXPoint + xSpaceToLeft + xSpaceToRight + XSlideSpaceToRight)];
    }

    //3.2.2 Y轴方向滑动范围
    //y轴不允许滚动,则将y轴滚动范围设为和图形空间相等
    plotSpace.globalYRange = plotSpace.yRange;

}

#pragma mark -设置血压曲线坐标轴基本设置
- (void)setupAxisViewOfHighBloodWithYStepLength:(float)yStepLength                 // Y轴步长
                      withXAxisConstraintToBottom:(CGFloat)xAxisConstraintToBottom   // X轴距离视图底部的约束长度
                        withYAxisConstraintToLeft:(CGFloat)yAxisConstraintToLeft     // Y轴距离视图左边的约束长度
                  withYMinStartPointOfExceptPoint:(float)yMinStartPoint              // Y轴需要排除的点的范围_最小值起点
                    withYMinEndPointOfExceptPoint:(float)yMinEndPoint                // Y轴需要排除的点的范围_最小值终点
                  withYMaxStartPointOfExceptPoint:(float)yMaxStartPoint              // Y轴需要排除的点的范围_最大值起点
                    withYMaxEndPointOfExceptPoint:(float)yMaxEndPoint                // Y轴需要排除的点的范围_最大值终点
{
    // Y轴步长
    float YStepLength = yStepLength;
    // X轴距离视图底部的约束长度
    CGFloat XAxisConstraintToBottom = xAxisConstraintToBottom;
    // Y轴距离视图左边的约束长度
    CGFloat YAxisConstraintToLeft = yAxisConstraintToLeft;

    // Y轴需要排除的点的范围(最大值/最小值两头都有需要排除的点,开始在前)
    // 最小值开始
    float YMinStartPoint = yMinStartPoint;
    // 最小值结束
    float YMinEndPoint = yMinEndPoint;
    // 最大值开始
    float YMaxStartPoint = yMaxStartPoint;
    // 最大值结束
    float YMaxEndPoint = yMaxEndPoint;

    //4.坐标轴设置
    //4.1 x轴
    //获取图纸对象的坐标系
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)_highBloodGraph.axisSet;
    //获取坐标轴的x轴
    CPTXYAxis *x = axisSet.xAxis;

    //4.1.1设置y轴与x轴交点(y坐标位置)
    //设置x坐标的原点（y轴将在此与x轴相交,即如果填2,则y轴2和x轴0点相交）
    //    x.orthogonalPosition = [NSNumber numberWithFloat:YAXISTOXAXISYPOINT];

    //图形空间和x/y轴交点不一定相关,只是这里让图形空间和坐标轴交点保持一致了

    //这里固定了x,y轴距离底边的距离,又设置了图形空间(即一屏显示的范围),那么x/y轴交点是可以推算的吗?
    //可以推算.所以不用单独设置原点坐标,只要设置好图形空间和x,y轴距离底边的距离即可.

    //4.1.2 固定X轴
    //距离底边距离
    //这里x,y轴距离的边,实际上就是图形空间的边
    x.axisConstraints = [CPTConstraints constraintWithLowerOffset:XAxisConstraintToBottom];

    //4.1.3 外观设置
    // 设置每个大刻度线之间分布几个小刻度线
    x.minorTicksPerInterval = 0;
    // 设定坐标轴刻度方向
    x.tickDirection = CPTSignNone; //上下都有突出


    //4.2 y轴
    CPTXYAxis *y = axisSet.yAxis;
    //4.2.1设置y轴与x轴交点(x坐标位置)
    //    y.orthogonalPosition = [NSNumber numberWithDouble:[_highBloodPoints[INDEXOFSTARTDATA][@"x"] doubleValue] - PLOTXSPACETOAXIS];
    //4.2.2 y轴步长(两个坐标间隔)
    y.majorIntervalLength = [NSNumber numberWithFloat:YStepLength];
    //4.2.3 设置每个大刻度线之间分布几个小刻度线
    y.minorTicksPerInterval = 0;
    //4.2.4 固定y轴
    //距离左边距离
    y.axisConstraints = [CPTConstraints constraintWithLowerOffset:YAxisConstraintToLeft];
    //4.2.5 y轴排除某些点
    NSArray * exclusionRanges = [NSArray arrayWithObjects:
                                 [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(YMinStartPoint) lengthDecimal:CPTDecimalFromFloat(YMinEndPoint - YMinStartPoint)],
                                 [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(YMaxStartPoint) lengthDecimal:CPTDecimalFromFloat(YMaxEndPoint - YMaxStartPoint)],nil];
    // 设置y轴排除的数据数组,类型是NSArray
    y.labelExclusionRanges = exclusionRanges;

    //4.3 设置坐标轴代理
     y.delegate = self;
    // 仅x轴设置了代理
    x.delegate = self;

}

#pragma mark -设置血压曲线自定义x轴坐标值
- (void)setupCustomXLocationOfHighBloodWithPointDataArray:(NSMutableArray *)pointDataArray // 折线图数据点数组
                                            withXStringName:(NSString *)xStringName          // 折线图X轴字段名称
                                            withYStringName:(NSString *)yStringName          // 折线图Y轴字段名称
{


    //将字符串数组转为NSNumber数组
    NSMutableArray *numberDataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < pointDataArray.count; i++)
    {
        NSNumber *x = [NSNumber numberWithDouble:[pointDataArray[i][xStringName] doubleValue]];
        NSNumber *y = [NSNumber numberWithDouble:[pointDataArray[i][yStringName] doubleValue]];
        [numberDataArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x,xStringName,y,yStringName,nil]];

    }


    //将x的数据单独拿出来(用于给x轴赋值)
    NSMutableArray *xLocationArray = [NSMutableArray array];
    NSUInteger j;
    for (j = 0; j < numberDataArray.count; j++)
    {
        NSMutableDictionary *dic = numberDataArray[j];
        NSNumber *xLocationNumber = dic[xStringName];
        [xLocationArray addObject:xLocationNumber];
    }


    //4.1 x轴
    //获取图纸对象的坐标系
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)_highBloodGraph.axisSet;
    //获取坐标轴的x轴
    CPTXYAxis *x = axisSet.xAxis;
    //4.1.4 根据提供的数据设置x轴坐标Label值
    //label设置为依据提供的位置坐标值显示
    [x setLabelingPolicy:CPTAxisLabelingPolicyLocationsProvided];

    // 设置x刻度坐标
    // x刻度坐标是一个集合
    // 需要判断是否为0
    NSSet *majorTickLocations = [NSSet setWithArray:xLocationArray];
    x.majorTickLocations = majorTickLocations;

    /**
     *  这里设置的Location会作为参数传给以下代理方法
     *  - (BOOL)axis:(CPTAxis *)axis shouldUpdateAxisLabelsAtLocations:
     *
     */
}

#pragma mark -设置血压曲线折线图
- (void)setupPlotViewOfHighBlood
{
    //5.散点图类

    //5.1 高压线条
    //5.1.1 外观
    CPTScatterPlot *highBloodPlot = [[CPTScatterPlot alloc] init];
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit = 1.0f;//尖角限制(线段拐点)

    lineStyle.lineWidth = 2.0f;
    lineStyle.lineColor = [CPTColor grayColor];
    highBloodPlot.dataLineStyle = lineStyle;//数据线样式

    //5.1.2 标识符
    highBloodPlot.identifier = @"HighBloodPlot";//标识符

    //5.1.3 代理
    highBloodPlot.dataSource = self;//设置代理

    //5.1.4 绘制节点小圆点
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor grayColor];
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    UIColor *fillColor = [UIColor redColor];
    plotSymbol.fill = [CPTFill fillWithColor:[CPTColor colorWithCGColor:fillColor.CGColor]];
    plotSymbol.lineStyle = symbolLineStyle;
    plotSymbol.size = CGSizeMake(5.0, 5.0);
    highBloodPlot.plotSymbol = plotSymbol;

    //5.1.5 将图添加到图纸上
    [_highBloodGraph addPlot:highBloodPlot];




    //5.2 低压线条
    //5.2.1 外观
    CPTScatterPlot *lowBloodPlot = [[CPTScatterPlot alloc] init];
    CPTMutableLineStyle *lowlineStyle = [CPTMutableLineStyle lineStyle];
    lowlineStyle.miterLimit = 1.0f;//尖角限制(线段拐点)

    lowlineStyle.lineWidth = 2.0f;
    lowlineStyle.lineColor = [CPTColor grayColor];
    lowBloodPlot.dataLineStyle = lowlineStyle;//数据线样式

    //5.2.2 标识符
    lowBloodPlot.identifier = @"LowBloodPlot";//标识符

    //5.2.3 代理
    lowBloodPlot.dataSource = self;//设置代理

    //5.2.4 绘制节点小圆点
    CPTMutableLineStyle *lowSymbolLineStyle = [CPTMutableLineStyle lineStyle];
    lowSymbolLineStyle.lineColor = [CPTColor grayColor];
    CPTPlotSymbol *lowPlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    UIColor *lowFillColor = [UIColor grayColor];
    lowPlotSymbol.fill = [CPTFill fillWithColor:[CPTColor colorWithCGColor:lowFillColor.CGColor]];
    lowPlotSymbol.lineStyle = lowSymbolLineStyle;
    lowPlotSymbol.size = CGSizeMake(5.0, 5.0);
    lowBloodPlot.plotSymbol = lowPlotSymbol;

    //5.2.5 将图添加到图纸上
    [_highBloodGraph addPlot:lowBloodPlot];

}

#pragma mark - CPTPlotDataSource(折线图数据代理)
/**返回散点的个数*/
- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    //低压线条
    if ([plot.identifier isEqual:@"LowBloodPlot"])
    {
        return [_lowBloodPoints count];
    }
    else if ([plot.identifier isEqual:@"HighBloodPlot"])
    {//高压线条
        return [_highBloodPoints count];
    }
    else
    {
        return 0;
    }
}

/**返回每个散点的坐标值*/
//新库这里是id,不是NSNumber
-(id)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx
{

    NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"smdate" : @"inputvalue");

    //低压线条
    if ([plot.identifier isEqual:@"LowBloodPlot"])
    {
        NSNumber *num = [[_lowBloodPoints objectAtIndex:idx] valueForKey:key];
        return num;
    }
    else if ([plot.identifier isEqual:@"HighBloodPlot"])
    {//高压线条
        //从数组里取出对应的数据,然后用KVC取x或者y
        //返回值是x或者y两者之一的数值
        NSNumber *num = [[_highBloodPoints objectAtIndex:idx] valueForKey:key];

        return num;
    }
    else
    {
        return 0;
    }
}

#pragma mark - CPTAxisDelegate(自定义坐标轴标签代理方法)
/**分别控制坐标轴样式*/
- (BOOL)axis:(CPTAxis *)axis shouldUpdateAxisLabelsAtLocations:(CPTNumberSet)locations
{
    /**
     *  这里的参数locations就是在方法setupCustomXLocation里设置的.
     *  例如:x.majorTickLocations = majorTickLocations;
     *
     */

    CPTXYAxisSet *xyAxisSet = (CPTXYAxisSet *)axis.axisSet;
    CPTXYAxis *x = xyAxisSet.xAxis;
    CPTXYAxis *y = xyAxisSet.yAxis;

    //判断是x轴还是y轴
    if ([axis isEqual:x])
    {
        //(2)设置刻度标签数据
        //"格式类"调用"任意数据转字符串"这个方法
        NSMutableSet *newLabels = [NSMutableSet set];
        for (NSDecimalNumber *tickLocation in locations)
        {

            /**数据*/
            //NSNumber转NSString
            NSString *labelIntervalString = [NSString stringWithFormat:@"%@",tickLocation];
            //Interval字符串转时间字符串
            NSString *labelString = [NSString dateStringFromTimeIntervalString:labelIntervalString withFormatString:@"    HH:mm  \nYYYY/MM/dd"];
            /**样式*/
            CPTMutableTextStyle *whiteTextStyle = [[CPTMutableTextStyle alloc] init];
            whiteTextStyle.color = [CPTColor grayColor];
            whiteTextStyle.fontSize = CPTFloat(10.0);

            //"视图文字类"
            CPTTextLayer *newLabelLayer = [[CPTTextLayer alloc] initWithText:labelString style:whiteTextStyle];
            //用上面的"视图文字类"初始化一个CPTAxisLabel
            CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithContentLayer:newLabelLayer];
            
            //数据设为和tickLoction数据一致
            newLabel.tickLocation = tickLocation;
            //偏移设为和tickLoction数据一致
            newLabel.offset = axis.labelOffset;
            
            //添加到新的"标签位置容器"里
            [newLabels addObject:newLabel];
            
            
        }
        
        //"坐标轴标签位置"指向新的容器
        axis.axisLabels = newLabels;
        
        
    }else if ([axis isEqual:y])
    {
        
        //在设置y.delegate = self;(给y轴设置代理)后,可以在这里分别定制y轴label样式
        NSMutableSet *newLabels = [NSMutableSet set];
        for (NSDecimalNumber *tickLocation in locations)
        {

            /**数据*/
            //NSNumber转NSString
            NSString *labelIntervalString = [NSString stringWithFormat:@"%@",tickLocation];
            /**样式*/
            CPTMutableTextStyle *whiteTextStyle = [[CPTMutableTextStyle alloc] init];
            whiteTextStyle.color = [CPTColor grayColor];
            whiteTextStyle.fontSize = CPTFloat(10.0);

            //"视图文字类"
            CPTTextLayer *newLabelLayer = [[CPTTextLayer alloc] initWithText:labelIntervalString style:whiteTextStyle];
            //用上面的"视图文字类"初始化一个CPTAxisLabel
            CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithContentLayer:newLabelLayer];

            //数据设为和tickLoction数据一致
            newLabel.tickLocation = tickLocation;
            //偏移设为和tickLoction数据一致
            newLabel.offset = axis.labelOffset;

            //添加到新的"标签位置容器"里
            [newLabels addObject:newLabel];


        }

        //"坐标轴标签位置"指向新的容器
        axis.axisLabels = newLabels;
        
    }
    
    //告诉系统不用添加系统标签,走这个方法自定义标签
    return NO;
    
    
}

@end
