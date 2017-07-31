//
//  ZZChart.m
//  ZZChart
//
//  Created by JZZ on 2017/2/14.
//  Copyright © 2017年 JZZ. All rights reserved.
//

#import "ZZChart.h"


@implementation ZZChart

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _xDescTextFontSize = _yDescTextFontSize = 8.0;
        self.xAndYLineColor = [UIColor darkGrayColor];
        self.contextInsets = UIEdgeInsetsMake(10, 20, 10, 10);
        self.chartOrigin = P_M(self.contextInsets.left, CGRectGetHeight(self.frame) - self.contextInsets.bottom);
    }
    return self;
}

/**
 *  开始绘制图表
 */
- (void)showAnimation {

}

/**
 *  当刷新的时候先清除当前的图表
 */
- (void)clear {

}

- (void)drawLineWithContext:(CGContextRef )context
               andStarPoint:(CGPoint )start
                andEndPoint:(CGPoint)end
            andIsDottedLine:(BOOL)isDotted
                   andColor:(UIColor *)color {
    
    CGContextMoveToPoint(context, start.x, start.y);
    CGContextAddLineToPoint(context, end.x, end.y);
    CGContextSetLineWidth(context, 0.5);
    [color setStroke];
    
    //绘制虚线
    if (isDotted) {
        CGFloat ss[] = {1.5, 2.0};
        CGContextSetLineDash(context, 0, ss, 2);
    }
    
    CGContextMoveToPoint(context, end.x, end.y);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)drawText:(NSString *)text
      andContext:(CGContextRef)context atPoint:(CGPoint)point
       WithColor:(UIColor *)color
     andFontSize:(CGFloat)fontSize {
    
    [[NSString stringWithFormat:@"%@", text] drawAtPoint:point withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName: color}];
    [color setFill];
    CGContextDrawPath(context, kCGPathFill);
}

- (void)drawText:(NSString *)text
         context:(CGContextRef)context
         atPoint:(CGRect)rect
       WithColor:(UIColor *)color
            font:(UIFont *)font {
    
    [[NSString stringWithFormat:@"%@", text] drawInRect:rect withAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: color}];
    [color setFill];
    CGContextDrawPath(context, kCGPathFill);
}


- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize
                         textFont:(CGFloat)fontSize
                        aimString:(NSString *)aimString{
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
}

- (CGFloat)getTextWithWhenDrawWithText:(NSString *)text {
   
    return 1.0;
}

- (void)drawPointWithRedius:(CGFloat)redius
                   andColor:(UIColor *)color
                   andPoint:(CGPoint)p
                 andContext:(CGContextRef)contex {
}

- (void)drawQuartWithColor:(UIColor *)color
             andBeginPoint:(CGPoint)p
                andContext:(CGContextRef)contex {
}
@end
