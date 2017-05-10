//
//  UIButton+JYCustom.m
//  减约
//
//  Created by Sunshine on 16/4/25.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import "UIButton+JYCustom.h"

@implementation UIButton (JYCustom)

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainBackColor:(UIColor *)mBackColor countBackColor:(UIColor *)countBackColor mainColor:(UIColor *)mColor countColor:(UIColor *)color borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius mainBorderColor:(UIColor *)mainBorderColor countBorderColor:(UIColor *)countBorderColor {

    
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue    = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.backgroundColor = mBackColor;
                self.userInteractionEnabled = YES;
                self.layer.cornerRadius     = cornerRadius;
                self.layer.borderWidth      = borderWidth;
                self.layer.borderColor      = mainBorderColor.CGColor;
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitleColor:mColor forState:UIControlStateNormal];
                
            });
            
        }else{
            
            //            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2ld",(long)timeOut];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = countBackColor;
                self.userInteractionEnabled = NO;
                self.layer.cornerRadius     = cornerRadius;
                self.layer.borderWidth      = borderWidth;
                self.layer.borderColor      = countBorderColor.CGColor;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                [self setTitleColor:color forState:UIControlStateNormal];
                
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
    
}


- (void)verticalCenterImageAndTitle:(CGFloat)spacing {

    CGSize imageSize     = self.imageView.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width-5, -(imageSize.height + spacing*0.5), -5.0);
    
    CGSize titleSize     = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing*0.5), 0.0, 0.0, -titleSize.width);
}

- (void)verticalCenterImageAndTitle {
    
    const int DEFAULT_SPACING = 5.0f;
    [self verticalCenterImageAndTitle:DEFAULT_SPACING];
}


- (void)horizontalCenterTitleAndImage:(CGFloat)spacing {
    
    CGSize imageSize     = self.imageView.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, 0.0, imageSize.width + spacing*0.5);

    CGSize titleSize     = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing*0.5, 0.0, -titleSize.width);
}

- (void)horizontalCenterTitleAndImage {
    
    const int DEFAULT_SPACING = 5.0f;
    [self horizontalCenterTitleAndImage:DEFAULT_SPACING];
}


- (void)horizontalCenterImageAndTitle:(CGFloat)spacing; {
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0,  0.0, 0.0,  -spacing*0.5);
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -spacing*0.5, 0.0, 0.0);
}

- (void)horizontalCenterImageAndTitle;
{
    const int DEFAULT_SPACING = 5.0f;
    [self horizontalCenterImageAndTitle:DEFAULT_SPACING];
}


- (void)horizontalCenterTitleAndImageLeft:(CGFloat)spacing {
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, - spacing, 0.0, 0.0);
}

- (void)horizontalCenterTitleAndImageLeft {
    
    const int DEFAULT_SPACING = 5.0f;
    [self horizontalCenterTitleAndImageLeft:DEFAULT_SPACING];
}


- (void)horizontalCenterTitleAndImageRight:(CGFloat)spacing {

    CGSize imageSize     = self.imageView.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, 0.0);

    CGSize titleSize     = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + imageSize.width + spacing, 0.0, - titleSize.width);
}

- (void)horizontalCenterTitleAndImageRight {
    
    const int DEFAULT_SPACING = 5.0f;
    [self horizontalCenterTitleAndImageRight:DEFAULT_SPACING];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)btnAnimatetoScaleValue:(float)toValue{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.duration = 0.2;
    animation.repeatCount = 1;
    animation.autoreverses = YES;
    
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    [self.layer addAnimation:animation forKey:@"scale-layer"];
    
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

-(void)btnImageViewAnimatetoScaleValue:(float)toValue{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.duration = 0.2;
    animation.repeatCount = 1;
    animation.autoreverses = YES;
    
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    [self.imageView.layer addAnimation:animation forKey:@"scale-layer"];
}


@end
