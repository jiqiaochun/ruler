//
//  UIButton+JYCustom.h
//  减约
//
//  Created by Sunshine on 16/4/25.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JYCustom)

#pragma mark - 倒计时按钮
/*
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param subTitle  倒计时的子名字 如：时、分
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */
- (void)startWithTime:(NSInteger)timeLine
                title:(NSString *)title
       countDownTitle:(NSString *)subTitle
        mainBackColor:(UIColor *)mBackColor
       countBackColor:(UIColor *)countBackColor
            mainColor:(UIColor *)mColor
           countColor:(UIColor *)color
          borderWidth:(CGFloat)borderWidth
         cornerRadius:(CGFloat)cornerRadius
      mainBorderColor:(UIColor *)mainBorderColor
     countBorderColor:(UIColor *)countBorderColor;


#pragma mark -
#pragma mark 上下居中，图片在上，文字在下
/**
 *  上下居中，图片在上，文字在下
 *
 *  @param spacing 上下间距
 */
- (void)verticalCenterImageAndTitle:(CGFloat)spacing;

/**
 *  上下居中，图片在上，文字在下(上下默认间距为5.0)
 */
- (void)verticalCenterImageAndTitle;

#pragma mark 左右居中，文字在左，图片在右
/**
 *  左右居中，文字在左，图片在右
 *
 *  @param spacing 左右间距
 */
- (void)horizontalCenterTitleAndImage:(CGFloat)spacing;

/**
 *  左右居中，文字在左，图片在右(默认间距5.0)
 */
- (void)horizontalCenterTitleAndImage;

#pragma mark 左右居中，图片在左，文字在右
/**
 *  左右居中，图片在左，文字在右
 *
 *  @param spacing 左右间距
 */
- (void)horizontalCenterImageAndTitle:(CGFloat)spacing;

/**
 *  左右居中，图片在左，文字在右(默认间距5.0)
 */
- (void)horizontalCenterImageAndTitle;

#pragma mark 文字居中，图片在左边
/**
 *  文字居中，图片在左边
 *
 *  @param spacing 左右间距
 */
- (void)horizontalCenterTitleAndImageLeft:(CGFloat)spacing;

/**
 *  文字居中，图片在左边(默认间距5.0)
 */
- (void)horizontalCenterTitleAndImageLeft;

#pragma mark 文字居中，图片在右边
/**
 *  文字居中，图片在右边
 *
 *  @param spacing 左右间距
 */
- (void)horizontalCenterTitleAndImageRight:(CGFloat)spacing;

/**
 *  文字居中，图片在右边(默认间距5.0)
 */
- (void)horizontalCenterTitleAndImageRight;

/**
 *  设置不同状态下的按钮的背景色
 *
 *  @param backgroundColor 按钮的背景色
 *  @param state           按钮的状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor
                  forState:(UIControlState)state;


/**
 *  设置按钮的缩小和放大倍数
 *
 *  @param toValue           倍数
 */


-(void)btnAnimatetoScaleValue:(float)toValue;

/**
 *  设置按钮的缩小和放大倍数
 *
 *  @param toValue           倍数
 */
-(void)btnImageViewAnimatetoScaleValue:(float)toValue;


@end
