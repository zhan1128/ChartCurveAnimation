//
//  ZZChart.h
//  ZZChart
//
//  Created by JZZ on 2017/2/14.
//  Copyright © 2017年 JZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define P_M(x,y) CGPointMake(x, y)
#define weakSelf(weakSelf)  __weak typeof(self) weakself = self;
#define XORYLINEMAXSIZE CGSizeMake(CGFLOAT_MAX,30)

@interface ZZChart : UIView

/**
 *  图表的内边距
 */
@property (nonatomic, assign) UIEdgeInsets contextInsets;

/**
 *  图表的原点值
 */
@property (nonatomic, assign) CGPoint chartOrigin;

/**
 *  图表的标题
 */
@property (nonatomic, copy) NSString *chartTitle;

/**
 *  图表y轴上的描述文字的字体大小
 */
@property (nonatomic,assign) CGFloat yDescTextFontSize;

/**
 *  图表x轴上的描述文字的字体大小
 */
@property (nonatomic,assign) CGFloat xDescTextFontSize;

/**
 *  X, Y 轴线条颜色
 */
@property (nonatomic, strong) UIColor *xAndYLineColor;

/**
 *  开始绘制图表
 */
- (void)showAnimation;

/**
 *  当刷新的时候先清除当前的图表
 */
- (void)clear;

/**
 *  绘制线段
 *
 *  @param context  图形绘制上下文
 *  @param start    起点
 *  @param end      终点
 *  @param isDotted 是否是虚线
 *  @param color    线段颜色
 */
- (void)drawLineWithContext:(CGContextRef)context
               andStarPoint:(CGPoint )start
                andEndPoint:(CGPoint)end
            andIsDottedLine:(BOOL)isDotted
                   andColor:(UIColor *)color;

/**
 *  绘制文字
 *
 *  @param text     文字内容
 *  @param context  图形绘制上下文
 *  @param point    绘制点
 *  @param color    绘制颜色
 *  @param fontSize 绘制字体大小
 */
- (void)drawText:(NSString *)text
      andContext:(CGContextRef )context
         atPoint:(CGPoint )point
       WithColor:(UIColor *)color
     andFontSize:(CGFloat)fontSize;

- (void)drawText:(NSString *)text
         context:(CGContextRef )context
         atPoint:(CGRect )rect
       WithColor:(UIColor *)color
            font:(UIFont*)font;

/**
 *  判断文本宽度
 *
 *  @param text 文本内容
 *
 *  @return 文本宽度
 */
- (CGFloat)getTextWithWhenDrawWithText:(NSString *)text;

/**
 *  绘制长方形
 *
 *  @param color  填充颜色
 *  @param p      开始点
 *  @param contex 图形上下文
 */
- (void)drawQuartWithColor:(UIColor *)color
             andBeginPoint:(CGPoint)p
                andContext:(CGContextRef)contex;

/**
 *  绘制一个原点
 *  @param redius 圆角大小
 *  @param color  绘制点颜色
 *  @param p      绘制点坐标
 *  @param contex 图形上下文
 *
 */
- (void)drawPointWithRedius:(CGFloat)redius
                   andColor:(UIColor *)color
                   andPoint:(CGPoint)p
                 andContext:(CGContextRef)contex;

/**
 *  返回字符串的占用尺寸
 *
 *  @param maxSize   最大尺寸
 *  @param fontSize  字号大小
 *  @param aimString 目标字符串
 *
 *  @return 占用尺寸
 */
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize
                         textFont:(CGFloat)fontSize
                        aimString:(NSString *)aimString;



@end
