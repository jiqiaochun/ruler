//
//  JYRecordingView.h
//  减约
//
//  Created by 姬巧春 on 16/5/5.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JYRecordingView : UIView

@property (nonatomic, copy) dispatch_block_t determineBlock; // 确定
@property (nonatomic, copy) dispatch_block_t dismissBlock;  // 取消
@property (nonatomic, copy) dispatch_block_t lookDetailBlock;  // 查看详情
@property (nonatomic, copy) dispatch_block_t deleteBlock;  // 删除

@property (nonatomic, copy) NSString *aimValue;

/**
 *  <#Description#>
 *
 *  @param title        标题
 *  @param subTitle     建议文字
 *  @param maxValue     标尺最大值 10个小刻度为一个大刻度，大刻度的数量
 *  @param average      每个小刻度的值，最小精度 0.1
 *  @param minValue     标尺最小值
 *  @param currentValue 当前刻度值
 *  @param mode         是否最小模式
 *
 *  @return <#return value description#>
 */
- (id)initWithTitle:(NSString *)title
         contentSub:(NSString *)subTitle
               unit:(NSString *)unit
        unitFontNum:(CGFloat)fontNum
            RulerScrollViewWithMaxValue:(NSUInteger)maxValue
            average:(NSNumber *)average
           MinValue:(NSUInteger)minValue
       currentValue:(CGFloat)currentValue
          smallMode:(BOOL)mode;

- (void)show;

- (id)initWithName:(NSString *)name
             photo:(NSString *)imageurl
          unitHeat:(NSString *)unitHeat
         unitCount:(NSString *)unitCount
              unit:(NSString *)unit
RulerScrollViewWithMaxValue:(NSUInteger)maxValue
           average:(NSNumber *)average
          MinValue:(NSUInteger)minValue
      currentValue:(CGFloat)currentValue
         smallMode:(BOOL)mode
     customizeMode:(BOOL)cusMode
       isCanDelete:(BOOL)isDelete
     isLookDeatial:(BOOL)isLookDetail
    viewController:(UIViewController*)vc;
@end
