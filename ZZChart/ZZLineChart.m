//
//  ZZLineChart.m
//  ZZChart
//
//  Created by JZZ on 2017/2/15.
//  Copyright © 2017年 JZZ. All rights reserved.
//

#import "ZZLineChart.h"
#define kXandYSpaceForSuperView 20.0

@interface ZZLineChart ()<CAAnimationDelegate>

@property (nonatomic, assign)   CGFloat  xLength;   //x轴的长度
@property (nonatomic, assign)   CGFloat  yLength;   //y轴的长度
@property (nonatomic, assign)   CGFloat  perXLen;   //x轴每个刻度之间的距离
@property (nonatomic, assign)   CGFloat  perYlen;   //y轴每个刻度之间的距离
@property (nonatomic, assign)   CGFloat  perValue;  //
@property (nonatomic, strong)   NSMutableArray *drawDataArr;   //点数组 用来存放转化过的需要绘制的点坐标
@property (nonatomic, strong)   CAShapeLayer *shapeLayer;      //
@property (nonatomic, assign)   BOOL  isEndAnimation;          //是否结束绘制动画
@property (nonatomic, strong)   NSMutableArray *layerArr;      //存放layer的数组，用于清除layer
@property (nonatomic, strong)   CALayer *aboveLayer;
@property (nonatomic, assign)   BOOL needUpdate;
@property (nonatomic, assign)   NSInteger number;
@end




@implementation ZZLineChart

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _number = 0;
        self.backgroundColor = [UIColor whiteColor];
        _lineWidth = 0.5;
        _yLineDataArr  = @[@"0.2", @"0.4", @"0.6", @"0.8", @"1.0"];
        _xLineDataArr  = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
        _showMaxNumber = 6;
        _pointNumberColorArr = @[[UIColor redColor]];
        _positionLineColorArr = @[[UIColor darkGrayColor]];
        _pointColorArr = @[[UIColor orangeColor]];
        _xAndYNumberColor = [UIColor darkGrayColor];
        _valueLineColorArr = @[[UIColor redColor]];
        _layerArr = [NSMutableArray array];
        _showYLine = YES;
        _showYLevelLine = NO;
        _contentFillColorArr = @[[UIColor lightGrayColor]];
        _showValueLeadingLine = YES;
        _valueFontSize = 8.0;
        _animationDuration = 2.0;
        [self calculateChartXAndYAxisLength];
        [self calculateChartOriginPoint];
    }
    return self;
}

/**
 *  清除图表内容
 */
-(void)clear{
    _number = 0;
    _valueArr = nil;
    _drawDataArr = nil;
    for (CALayer *layer in _layerArr) {
        [layer removeFromSuperlayer];
    }
    [_layerArr removeAllObjects];
    [self showAnimation];
}

/**
 *  动画展示路径
 */
-(void)showAnimation{
    [self calculatePerXAndYLength];
    [self configValueDataArray];
    [self drawAnimation];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawXAndYLineWithContext:context];
    
    if (_drawDataArr.count) {
        [self drawPositionLineWithContext:context];
    }
}

/**
 *  绘制x与y轴
 */
- (void)drawXAndYLineWithContext:(CGContextRef)context{
    
    //绘制x轴
    [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(self.contextInsets.left + _xLength, self.chartOrigin.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
    //是否绘制y轴
    if (_showYLine) {
        [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(self.chartOrigin.x, self.chartOrigin.y - _yLength) andIsDottedLine:NO andColor:self.xAndYLineColor];
    }
    if (_xLineDataArr.count) {
        CGFloat xSpace = (_xLength - kXandYSpaceForSuperView) / (_xLineDataArr.count - 1);
        for (NSInteger i = 0; i < _xLineDataArr.count; i++) {
            CGPoint p = P_M(self.chartOrigin.x + xSpace * i, self.chartOrigin.y);
            CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.xDescTextFontSize aimString:_xLineDataArr[i]].width;
            [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y - 2) andIsDottedLine:NO andColor:self.xAndYLineColor];
            [self drawText:[NSString stringWithFormat:@"%@", _xLineDataArr[i]] andContext:context atPoint:P_M(p.x-len / 2.0, p.y + 2) WithColor:self.xAndYLineColor andFontSize:self.xDescTextFontSize];
        }
    }
    
    if (_yLineDataArr.count>0) {
        CGFloat yPace = (_yLength - kXandYSpaceForSuperView)/(_yLineDataArr.count);
        for (NSInteger i = 0; i < _yLineDataArr.count; i++) {
            CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i + 1) * yPace);
            
            CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:_yLineDataArr[i]].width;
            CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:_yLineDataArr[i]].height;
            if (_showYLevelLine) {
                [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(self.contextInsets.left - kXandYSpaceForSuperView / 5.0 + _xLength, p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
            }else{
                [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x + 3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            [self drawText:[NSString stringWithFormat:@"%@",_yLineDataArr[i]] andContext:context atPoint:P_M(p.x - len - 3, p.y - hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
        }
    }
}

/**
 *  设置点的引导虚线
 *
 *  @param context 图形面板上下文
 */
- (void)drawPositionLineWithContext:(CGContextRef)context{
}

/**
 *  计算X和Y轴的长度，用于接下来计算刻度
 */
- (void)calculateChartXAndYAxisLength {
    _xLength = CGRectGetWidth(self.frame)- self.contextInsets.left - self.contextInsets.right;
    _yLength = CGRectGetHeight(self.frame) - self.contextInsets.top - self.contextInsets.bottom;
}

/**
 *  计算绘制图表的原点
 */
- (void)calculateChartOriginPoint {
    self.chartOrigin = CGPointMake(self.contextInsets.left, self.frame.size.height-self.contextInsets.bottom);
}

/**
 *  计算x和y轴每一个刻度的距离
 */
- (void)calculatePerXAndYLength {
    _perXLen = (_xLength - kXandYSpaceForSuperView) / (_xLineDataArr.count - 1);
    _perYlen = (_yLength - kXandYSpaceForSuperView) / _yLineDataArr.count;
}

/**
 *  重写点数据数据的set方法  用于重新计算y轴的刻度大小
 */
- (void)setValueArr:(NSArray *)valueArr{
    
    _valueArr = valueArr;
    if (!_needUpdate) {
        [self updateYScale];
    }
}

/**
 *  重新赋值动画持续时间
 */
- (void)setAnimationDuration: (CGFloat)animationDuration {
    _animationDuration = animationDuration;
}

- (void)setShowMaxNumber:(NSInteger)showMaxNumber {

    _showMaxNumber = showMaxNumber;
}

/**
 *  根据数据源  去动态计算Y轴刻度
 */
- (void)updateYScale {
    NSArray *arr = @[@"0.2", @"0.4", @"0.6", @"0.8", @"1.0"];
    _yLineDataArr = [arr copy];
    [self setNeedsDisplay];
    _needUpdate = false;
}

/**
 *  转值数组为点数组
 */
- (void)configValueDataArray {
    _drawDataArr = [NSMutableArray array];
    
    if (_valueArr.count==0) {
        return;
    }
    _perValue = _perYlen / [[_yLineDataArr firstObject] floatValue];
    for (NSArray *arr in _valueArr) { //遍历数组  @[@[], @[]] 用来绘制多条线
        NSMutableArray *pointArr = [NSMutableArray array];
        for (NSInteger i = 0; i < arr.count; i++) {
            // 利用原点坐标 也就是参考点的坐标  计算出所有点的y坐标点
            CGPoint p = P_M((_showMaxNumber - i) * _perXLen + self.chartOrigin.x, self.contextInsets.top + _yLength - [arr[i] floatValue] * _perValue);
            NSValue *value = [NSValue valueWithCGPoint:p];
            [pointArr addObject:value];
        }
        [_drawDataArr addObject:[pointArr copy]];
    }
}

/**
 *  执行绘制动画
 */
- (void)drawAnimation {

    [_shapeLayer removeFromSuperlayer];
    _shapeLayer = [CAShapeLayer layer];
    if (_drawDataArr.count == 0) {
        return;
    }
    self.aboveLayer = [CALayer layer];
    self.aboveLayer.bounds = CGRectMake(0, 0, self.xLength, self.yLength);
    self.aboveLayer.position = CGPointMake(self.chartOrigin.x + self.xLength / 2.0, self.chartOrigin.y - self.yLength / 2.0);
    self.aboveLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:self.aboveLayer];
    self.aboveLayer.masksToBounds = YES;
    
    //第一、UIBezierPath绘制线段
    [self calculatePerXAndYLength];
    
    for (NSInteger i = 0; i < _drawDataArr.count; i++) {
        NSArray * dataArr = _drawDataArr[i];
        [self drawPathWithDataArr:dataArr andIndex:i];
    }
}

- (void)drawPathWithDataArr:(NSArray *)dataArr andIndex:(NSInteger)colorIndex {
    
    //需要绘制的曲线路径
    UIBezierPath *firstPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 0, 0)];
    //需要填充的路径 其实和firstPath一样 只是这里是绘制的是闭合路径的内部
    UIBezierPath *secondPath = [UIBezierPath bezierPath];
    
    for (NSInteger i = 0; i < dataArr.count; i++) {
        NSValue *value = dataArr[i];
        CGPoint p = value.CGPointValue;
        if (_pathCurve) {
            if (i == 0) {
                if (_contentFill) {
                    [secondPath moveToPoint:P_M(p.x, self.chartOrigin.y)];
                    [secondPath addLineToPoint:p];
                }
                [firstPath moveToPoint:p];
            } else {
                CGPoint theLastP = [dataArr[i - 1] CGPointValue];
                CGPoint control1 = P_M(p.x + (theLastP.x - p.x) / 2.0, theLastP.y);
                CGPoint control2 = P_M(p.x + (theLastP.x - p.x) / 2.0, p.y);
                [secondPath addCurveToPoint:p controlPoint1:control1 controlPoint2:control2];
                [firstPath addCurveToPoint:p controlPoint1:control1 controlPoint2:control2];
            }
        } else {
            if (i == 0) {
                if (_contentFill) {
                    [secondPath moveToPoint:P_M(p.x, self.chartOrigin.y)];
                    [secondPath addLineToPoint:p];
                }
                [firstPath moveToPoint:p];
            } else {
                [firstPath addLineToPoint:p];
                [secondPath addLineToPoint:p];
            }
        }
        if (i == (dataArr.count - 1)) {
            [secondPath addLineToPoint:P_M(p.x, self.chartOrigin.y)];
        }
        //第二、UIBezierPath和CAShapeLayer关联
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.path = firstPath.CGPath;
        shapeLayer.strokeColor = _valueLineColorArr.count == _drawDataArr.count ? [_valueLineColorArr[colorIndex] CGColor] : [[UIColor orangeColor] CGColor];
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = _animationPathWidth <= 0 ? 2 : _animationPathWidth;
        // 第三 把CAShapeLayer和CABasicAnimation关联  组成动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
        animation.fromValue = @1;
        animation.toValue = @1;
        animation.duration = 0;
        [shapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
        
        // 平移动画
        CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
        animation1.fromValue = [NSValue valueWithCGPoint: shapeLayer.position];
        CGPoint point1 = shapeLayer.position;
        point1.x = point1.x - _perXLen;
        animation1.toValue = [NSValue valueWithCGPoint: point1];
        animation1.duration = _animationDuration;
        animation1.removedOnCompletion = NO;
        animation1.fillMode = kCAFillModeForwards;
        [shapeLayer addAnimation:animation1 forKey:@"position"];
        
        [self.aboveLayer addSublayer:shapeLayer];
        [_layerArr addObject:shapeLayer];
        [_layerArr addObject:_aboveLayer];
    }
}



@end
