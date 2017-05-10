//
//  JYHRrettyRuler.h
//  减约
//
//  Created by 姬巧春 on 16/5/4.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYRulerScrollView.h"

@protocol JYRrettyRulerDelegate <NSObject>

- (void)JYRrettyRuler:(JYRulerScrollView *)rulerScrollView;

@end

@interface JYHRrettyRuler : UIView <UIScrollViewDelegate>

@property (nonatomic,strong) JYRulerScrollView * rulerScrollView;

@property (nonatomic, assign) id <JYRrettyRulerDelegate> rulerDeletate;

/*
 *  count * average = 刻度最大值
 *  @param count        10个小刻度为一个大刻度，大刻度的数量
 *  @param average      每个小刻度的值，最小精度 0.1
 *  @param currentValue 直尺初始化的刻度值
 *  @param mode         是否最小模式
 */
- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSNumber *)average
                            MinValue:(NSUInteger)minValue
                        currentValue:(CGFloat)currentValue
                           smallMode:(BOOL)mode;

- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSNumber *)average
                            MinValue:(NSUInteger)minValue
                        currentValue:(CGFloat)currentValue
                           smallMode:(BOOL)mode
                       customizeMode:(BOOL)cusMode;

@end
