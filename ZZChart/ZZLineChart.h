//
//  ZZLineChart.h
//  ZZChart
//
//  Created by JZZ on 2017/2/15.
//  Copyright © 2017年 JZZ. All rights reserved.
//

#import "ZZChart.h"

typedef NS_ENUM(NSInteger,LineChartQuadrantType){

    LineChartQuadrantTypeFirstQuardrant = 0,      // 第一象限
    LineChartQuadrantTypeFirstAndSecondQuardrant, // 第一二象限
    LineChartQuadrantTypeFirstAndFouthQuardrant,  // 第一四象限
    LineChartQuadrantTypeAllQuardrant             //全象限
};

@interface ZZLineChart : ZZChart

@property (nonatomic, strong) NSArray *xLineDataArr;            //x轴上刻度数据
@property (nonatomic, strong) NSArray *yLineDataArr;            //y轴上刻度数据
@property (nonatomic, strong) NSArray *valueArr;                //需要绘制的点数据
@property (nonatomic, assign) CGFloat lineWidth;                //x y轴线的宽度
@property (nonatomic, strong) NSArray *valueLineColorArr;       //绘制线条颜色数组
@property (nonatomic, strong) NSArray *pointColorArr;           //绘制点颜色数组
@property (nonatomic, strong) UIColor *xAndYNumberColor;        //x y轴上数值颜色
@property (nonatomic, strong) NSArray *positionLineColorArr;    //绘制虚线的颜色
@property (nonatomic, strong) NSArray *pointNumberColorArr;     //绘制点描述文字的颜色
@property (nonatomic, assign) BOOL hasPoint;                    //是否需要绘制点
@property (nonatomic, assign) CGFloat animationPathWidth;       //绘制路径的线条宽度
@property (nonatomic, assign) BOOL pathCurve;                   //绘制路径是否为曲线  默认为NO
@property (nonatomic, assign) BOOL contentFill;                 //是否填充绘制路径内的内容
@property (nonatomic, strong) NSArray *contentFillColorArr;     //填充颜色的数组  默认是gray
@property (nonatomic, assign) BOOL showYLine;                   //是否绘制Y轴 默认YES
@property (nonatomic, assign) BOOL showYLevelLine;              //是否绘制Y轴的水平线 默认NO
@property (nonatomic, assign) BOOL showValueLeadingLine;        //是否绘制引导线  默认YES
@property (nonatomic, assign) CGFloat valueFontSize;            //点坐标描述文字的大小
@property (nonatomic, assign) CGFloat animationDuration;        //单次动画执行时间
@property (nonatomic, assign) NSInteger showMaxNumber;          //坐标轴最多展示的数据

-(instancetype)initWithFrame:(CGRect)frame;

@end
