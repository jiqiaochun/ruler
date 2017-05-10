//
//  JYRulerScrollView.h
//  减约
//
//  Created by 姬巧春 on 16/5/4.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DISTANCELEFTANDRIGHT 8.f // 标尺左右距离
#define DISTANCEVALUE 8.f // 每隔刻度实际长度8个点
#define DISTANCETOPANDBOTTOM 35.f // 标尺上下距离

@interface JYRulerScrollView : UIScrollView

@property (nonatomic,assign) int rulerCount; // 最大值
@property (nonatomic,assign) int rulerMinValue; // 最小值
@property (nonatomic,strong) NSNumber * rulerAverage; // 最小刻度
@property (nonatomic,assign) int rulerHeight;  //
@property (nonatomic,assign) int rulerWidth;
@property (nonatomic,assign) CGFloat rulerValue; // 当前值

@property (nonatomic,assign) BOOL mode;
@property (nonatomic,assign) BOOL cusMode;

- (void)drawRuler;

@end
