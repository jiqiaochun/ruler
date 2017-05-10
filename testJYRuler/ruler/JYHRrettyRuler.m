//
//  JYHRrettyRuler.m
//  减约
//
//  Created by 姬巧春 on 16/5/4.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import "JYHRrettyRuler.h"
#import "UIColor+JYColor.h"

#define INDICATORCOLOR [UIColor redColor].CGColor // 中间指示器颜色
#define DISTANCETOPANDBOTTOMINDICATOR 20.f // 标尺上下距离

@interface JYHRrettyRuler ()

@end

@implementation JYHRrettyRuler

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        JYRulerScrollView * rScrollView = [JYRulerScrollView new];
        rScrollView.delegate = self;
        rScrollView.showsHorizontalScrollIndicator = NO;
        self.rulerScrollView = rScrollView;
        self.rulerScrollView.rulerHeight = frame.size.height;
        self.rulerScrollView.rulerWidth = frame.size.width;
    }
    return self;
}

- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSNumber *)average
                            MinValue:(NSUInteger)minValue
                        currentValue:(CGFloat)currentValue
                           smallMode:(BOOL)mode {
    NSAssert(self.rulerScrollView != nil, @"***** 调用此方法前，请先调用 initWithFrame:(CGRect)frame 方法初始化对象 rulerScrollView\n");
    NSAssert(currentValue < [average floatValue] * count, @"***** currentValue 不能大于直尺最大值（count * average）\n");
    if (currentValue > [average floatValue] * count) {
        currentValue = [average floatValue] * count;
    }
    self.rulerScrollView.rulerAverage = average;
    self.rulerScrollView.rulerCount = count;
    self.rulerScrollView.rulerMinValue = minValue;
    self.rulerScrollView.rulerValue = currentValue;
    self.rulerScrollView.mode = mode;
    self.rulerScrollView.cusMode = YES;
    [self.rulerScrollView drawRuler];
    [self addSubview:self.rulerScrollView];
    [self drawRacAndLine];
}

- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSNumber *)average
                            MinValue:(NSUInteger)minValue
                        currentValue:(CGFloat)currentValue
                           smallMode:(BOOL)mode
                       customizeMode:(BOOL)cusMode{
    NSAssert(self.rulerScrollView != nil, @"***** 调用此方法前，请先调用 initWithFrame:(CGRect)frame 方法初始化对象 rulerScrollView\n");
//    NSAssert(currentValue < [average floatValue] * count, @"***** currentValue 不能大于直尺最大值（count * average）\n");
    if (currentValue > [average floatValue] * count) {
        currentValue = [average floatValue] * count;
    }
    self.rulerScrollView.rulerAverage = average;
    self.rulerScrollView.rulerCount = count;
    self.rulerScrollView.rulerMinValue = minValue;
    self.rulerScrollView.rulerValue = currentValue;
    self.rulerScrollView.mode = mode;
    self.rulerScrollView.cusMode = cusMode;
    [self.rulerScrollView drawRuler];
    [self addSubview:self.rulerScrollView];
    [self drawRacAndLine];
    
}

//- (JYRulerScrollView *)rulerScrollView {
//
//    return rScrollView;
//}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(JYRulerScrollView *)scrollView {
    if (scrollView.cusMode) {
        CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
        CGFloat ruleValue = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue];
            if (ruleValue < (scrollView.rulerMinValue == 0?0.5:0)) {
                return;
            }
//            else if (ruleValue > (scrollView.rulerCount-scrollView.rulerMinValue) * [scrollView.rulerAverage floatValue]) {
        //        return;
        //    }
        
        if (self.rulerDeletate) {
            if (!scrollView.mode) {
                scrollView.rulerValue = ruleValue;
            }
            scrollView.mode = NO;
            [self.rulerDeletate JYRrettyRuler:scrollView];
        }
    }else{
        CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
        CGFloat ruleValue = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue];
        if (ruleValue < (scrollView.rulerMinValue == 0?0.5:0)) {
            return;
        }
        if (self.rulerDeletate) {
            if (!scrollView.mode) {
                scrollView.rulerValue = ruleValue;
            }
            scrollView.mode = NO;
            if ((int)(ruleValue *100) % 50 == 0) {
                [self.rulerDeletate JYRrettyRuler:scrollView];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(JYRulerScrollView *)scrollView {
    [self animationRebound:scrollView];
}

- (void)scrollViewDidEndDragging:(JYRulerScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animationRebound:scrollView];
}

- (void)animationRebound:(JYRulerScrollView *)scrollView {
    if (scrollView.cusMode) {
        
        CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
        CGFloat oX = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue];
        if (oX < (scrollView.rulerMinValue == 0?1:0)) {
            return;
        }
#ifdef DEBUG
        NSLog(@"ago*****************ago:oX:%f",oX);
#endif
        if ([self valueIsInteger:scrollView.rulerAverage]) {
            oX = [self notRounding:oX afterPoint:0];
        }
        else {
            oX = [self notRounding:oX afterPoint:1];
        }
#ifdef DEBUG
        NSLog(@"after*****************after:oX:%.1f",oX);
#endif
        CGFloat offX = (oX / ([scrollView.rulerAverage floatValue])) * DISTANCEVALUE + DISTANCELEFTANDRIGHT - self.frame.size.width / 2;
//        if (oX > scrollView.rulerCount * [scrollView.rulerAverage floatValue]) {
//            oX = scrollView.rulerCount * [scrollView.rulerAverage floatValue];
//        }else if (oX < 0){
//            oX = 0;
//        }
        [UIView animateWithDuration:.2f animations:^{
            scrollView.contentOffset = CGPointMake(offX, 0);
            
            if (self.rulerDeletate) {
                if (!scrollView.mode) {
                    scrollView.rulerValue = oX;
                }
                scrollView.mode = NO;
                [self.rulerDeletate JYRrettyRuler:scrollView];
            }
            
        }];
        
    }else{
        
        CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
        CGFloat oX = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue];
        if (oX < (scrollView.rulerMinValue == 0?0.5:0)) {
            return;
        }
#ifdef DEBUG
        NSLog(@"ago*****************ago:oX:%f",oX);
#endif
        if ([self valueIsInteger:scrollView.rulerAverage]) {
            oX = [self notRounding:oX afterPoint:0];
        }
        else {
            oX = [self notRounding:oX afterPoint:1];
            oX = (int)((oX * 10 + 2) / 5.0) * 0.5;
        }
#ifdef DEBUG
        NSLog(@"after*****************after:oX:%.1f",oX);
#endif
        CGFloat offX = (oX / ([scrollView.rulerAverage floatValue])) * DISTANCEVALUE + DISTANCELEFTANDRIGHT - self.frame.size.width / 2;
//        if (oX > scrollView.rulerCount * [scrollView.rulerAverage floatValue]) {
//            oX = scrollView.rulerCount * [scrollView.rulerAverage floatValue];
//        }else if (oX < 0){
//            oX = 0;
//        }
        
        [UIView animateWithDuration:.2f animations:^{
            scrollView.contentOffset = CGPointMake(offX, 0);
            
            if (self.rulerDeletate) {
                if (!scrollView.mode) {
                    scrollView.rulerValue = oX;
                }
                scrollView.mode = NO;
                if ((int)(oX *100) % 50 == 0) {
                    [self.rulerDeletate JYRrettyRuler:scrollView];
                }
                
            }
            
        }];
        
    }
}

- (void)drawRacAndLine {
    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.rulerScrollView.rulerHeight *0.5-11, self.rulerScrollView.rulerWidth, 0.5)];
//    lineView.backgroundColor = [UIColor colorWithHexString:@"#D9D9D9"];
//    [self addSubview:lineView];
    
    // 红色指示器
    CAShapeLayer *shapeLayerLine = [CAShapeLayer layer];
    shapeLayerLine.strokeColor = [UIColor colorWithHexString:@"#FFC462"].CGColor;
    shapeLayerLine.fillColor = INDICATORCOLOR;
    shapeLayerLine.lineWidth = 2.f;
    shapeLayerLine.lineCap = kCALineCapRound;
    
    NSUInteger ruleHeight = 20; // 文字高度
    CGMutablePathRef pathLine = CGPathCreateMutable();
    CGPathMoveToPoint(pathLine, NULL, self.frame.size.width / 2, self.frame.size.height - DISTANCETOPANDBOTTOMINDICATOR - ruleHeight);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2, DISTANCETOPANDBOTTOMINDICATOR);
    
    shapeLayerLine.path = pathLine;
    [self.layer addSublayer:shapeLayerLine];
    
    
    // 贝塞尔曲线(创建一个圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(10 / 2.f, 10 / 2.f)
                                                        radius:12 / 2.f
                                                    startAngle:0
                                                      endAngle:M_PI * 2
                                                     clockwise:YES];
    // 创建一个shapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame         = CGRectMake(self.frame.size.width * 0.5 - 5, self.frame.size.height * 0.5 - 16, 12, 12);
    layer.strokeColor   = [UIColor colorWithHexString:@"#FF8135"].CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor colorWithHexString:@"#F5A623"].CGColor;   // 闭环填充的颜色
    layer.lineCap       = kCALineCapSquare;               // 边缘线的类型
    layer.path          = path.CGPath;                    // 从贝塞尔曲线获取到形状
    layer.lineWidth     = 4.0f;                           // 线条宽度
    layer.strokeStart   = 0.0f;
    layer.strokeEnd     = 1.0f;
    
    // 将layer添加进图层
    [self.layer addSublayer:layer];
}

#pragma mark - tool method

- (CGFloat)notRounding:(CGFloat)price afterPoint:(NSInteger)position {
    NSDecimalNumberHandler*roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber*ouncesDecimal;
    NSDecimalNumber*roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc]initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [roundedOunces floatValue];
}

- (BOOL)valueIsInteger:(NSNumber *)number {
    NSString *value = [NSString stringWithFormat:@"%f",[number floatValue]];
    if (value != nil) {
        NSString *valueEnd = [[value componentsSeparatedByString:@"."] objectAtIndex:1];
        NSString *temp = nil;
        for(int i =0; i < [valueEnd length]; i++)
        {
            temp = [valueEnd substringWithRange:NSMakeRange(i, 1)];
            if (![temp isEqualToString:@"0"]) {
                return NO;
            }
        }
    }
    return YES;
}
@end
