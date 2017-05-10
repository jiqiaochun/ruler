//
//  JYRulerScrollView.m
//  减约
//
//  Created by 姬巧春 on 16/5/4.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import "JYRulerScrollView.h"
#import "UIColor+JYColor.h"

@implementation JYRulerScrollView

- (void)setRulerValue:(CGFloat)rulerValue {
    _rulerValue = rulerValue;
}

- (void)drawRuler {
    
    if (self.cusMode) {
        CGMutablePathRef pathRef1 = CGPathCreateMutable();
        CGMutablePathRef pathRef2 = CGPathCreateMutable();
        CGMutablePathRef pathRef3 = CGPathCreateMutable();
        
        CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
        shapeLayer1.strokeColor = [UIColor colorWithHexString:@"#D9D9D9"].CGColor;
        shapeLayer1.fillColor = [UIColor clearColor].CGColor;
        shapeLayer1.lineWidth = 1.f;
        shapeLayer1.lineCap = kCALineCapButt;
        
        CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
        shapeLayer2.strokeColor = [UIColor colorWithHexString:@"#D9D9D9"].CGColor;
        shapeLayer2.fillColor = [UIColor clearColor].CGColor;
        shapeLayer2.lineWidth = 2.f;
        shapeLayer2.lineCap = kCALineCapButt;
        
        CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
        shapeLayer3.strokeColor = [UIColor colorWithHexString:@"#E2E2E2"].CGColor;
        shapeLayer3.fillColor = [UIColor clearColor].CGColor;
        shapeLayer3.lineWidth = 0.5f;
        shapeLayer3.lineCap = kCALineCapButt;
        
        for (NSUInteger i = self.rulerMinValue; i <= self.rulerCount; i++) {
            UILabel *rule = [[UILabel alloc] init];
            rule.textColor = [UIColor colorWithHexString:@"#B9B9B9"];
            rule.font = [UIFont boldSystemFontOfSize:15.0];
            //        rule.text = [NSString stringWithFormat:@"%.0f",i * [self.rulerAverage floatValue]+ self.rulerMinValue * [self.rulerAverage floatValue]];
            rule.text = [NSString stringWithFormat:@"%.0f",i * [self.rulerAverage floatValue]];
            
            CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font }];
            if (i % 10 == 0) {
                CGPathMoveToPoint(pathRef2, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue) , DISTANCETOPANDBOTTOM+5);
                CGPathAddLineToPoint(pathRef2, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue), self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 5);
                rule.frame = CGRectMake(DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue) - textSize.width / 2, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height, 0, 0);
                [rule sizeToFit];
                [self addSubview:rule];
                //        }else if (i % 5 == 0) {
                //            CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM + 10);
                //            CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 10);
            }else{
                CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue) , DISTANCETOPANDBOTTOM + 15);
                CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue), self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 15);
            }
            
            // 添加刻度尺中间的横线
            if (i < self.rulerCount) {
                CGPathMoveToPoint(pathRef3, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue) +DISTANCEVALUE, self.rulerHeight *0.5-11);
                CGPathAddLineToPoint(pathRef3, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue), self.rulerHeight *0.5-11);
            }
        }
        
        shapeLayer1.path = pathRef1;
        shapeLayer2.path = pathRef2;
        shapeLayer3.path = pathRef3;
        
        [self.layer addSublayer:shapeLayer1];
        [self.layer addSublayer:shapeLayer2];
        [self.layer addSublayer:shapeLayer3];
        
        self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);
        
        // 开启最小模式
        if (_mode) {
            UIEdgeInsets edge = UIEdgeInsetsMake(0, self.rulerWidth / 2.f - DISTANCELEFTANDRIGHT - (self.rulerMinValue == 0?8:0), 0, self.rulerWidth / 2.f - DISTANCELEFTANDRIGHT);
            self.contentInset = edge;
            self.contentOffset = CGPointMake(DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth + (self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT), 0);
        }else{
            self.contentOffset = CGPointMake(DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT, 0);
        }
        
        self.contentSize = CGSizeMake((self.rulerCount - self.rulerMinValue)* DISTANCEVALUE + DISTANCELEFTANDRIGHT * 2.f, self.rulerHeight);
    }else{
        
        CGMutablePathRef pathRef1 = CGPathCreateMutable();
        CGMutablePathRef pathRef2 = CGPathCreateMutable();
        CGMutablePathRef pathRef3 = CGPathCreateMutable();
        
        CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
        shapeLayer1.strokeColor = [UIColor colorWithHexString:@"#D9D9D9"].CGColor;
        shapeLayer1.fillColor = [UIColor clearColor].CGColor;
        shapeLayer1.lineWidth = 1.f;
        shapeLayer1.lineCap = kCALineCapButt;
        
        CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
        shapeLayer2.strokeColor = [UIColor colorWithHexString:@"#D9D9D9"].CGColor;
        shapeLayer2.fillColor = [UIColor clearColor].CGColor;
        shapeLayer2.lineWidth = 2.f;
        shapeLayer2.lineCap = kCALineCapButt;
        
        CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
        shapeLayer3.strokeColor = [UIColor colorWithHexString:@"#E2E2E2"].CGColor;
        shapeLayer3.fillColor = [UIColor clearColor].CGColor;
        shapeLayer3.lineWidth = 0.5f;
        shapeLayer3.lineCap = kCALineCapButt;
        
        for (NSUInteger i = self.rulerMinValue; i <= self.rulerCount; i++) {
            UILabel *rule = [[UILabel alloc] init];
            rule.textColor = [UIColor colorWithHexString:@"#B9B9B9"];
            rule.font = [UIFont boldSystemFontOfSize:15.0];
            
            rule.text = [NSString stringWithFormat:@"%.0f",i * [self.rulerAverage floatValue]];
            
            CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font }];
            if (i % 10 == 0) {
                CGPathMoveToPoint(pathRef2, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue) , DISTANCETOPANDBOTTOM+5);
                CGPathAddLineToPoint(pathRef2, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue), self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 5);
                rule.frame = CGRectMake(DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue) - textSize.width / 2, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height, 0, 0);
                [rule sizeToFit];
                [self addSubview:rule];
            }else if (i % 5 == 0) {
                
                CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue) , DISTANCETOPANDBOTTOM + 15);
                CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue), self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 15);
                
            }else{
//                CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue) , DISTANCETOPANDBOTTOM + 15);
//                CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue), self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 15);
            }
            
            // 添加刻度尺中间的横线
            if (i < self.rulerCount) {
                CGPathMoveToPoint(pathRef3, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue) +DISTANCEVALUE, self.rulerHeight *0.5-11);
                CGPathAddLineToPoint(pathRef3, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * (i-self.rulerMinValue), self.rulerHeight *0.5-11);
            }
        }
        
        shapeLayer1.path = pathRef1;
        shapeLayer2.path = pathRef2;
        shapeLayer3.path = pathRef3;
        
        [self.layer addSublayer:shapeLayer1];
        [self.layer addSublayer:shapeLayer2];
        [self.layer addSublayer:shapeLayer3];
        
        self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);
        
        // 开启最小模式
        if (_mode) {
            UIEdgeInsets edge = UIEdgeInsetsMake(0, self.rulerWidth / 2.f - DISTANCELEFTANDRIGHT - (self.rulerMinValue == 0?40:0), 0, self.rulerWidth / 2.f - DISTANCELEFTANDRIGHT);
            self.contentInset = edge;
            self.contentOffset = CGPointMake(DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth + (self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT), 0);
        }else{
            self.contentOffset = CGPointMake(DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT, 0);
        }
        
        self.contentSize = CGSizeMake((self.rulerCount - self.rulerMinValue)* DISTANCEVALUE + DISTANCELEFTANDRIGHT * 2.f, self.rulerHeight);
        
    }
}

@end
