//
//  JYRecordingView.m
//  减约
//
//  Created by 姬巧春 on 16/5/5.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import "JYRecordingView.h"
#import "UIColor+JYColor.h"
#import "JYHRrettyRuler.h"
#import "UIView+Extension.h"

#define kAlertHeight 469.0
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface JYRecordingView () <JYRrettyRulerDelegate>

@property (nonatomic, strong) UILabel *recTitleLabel;
@property (nonatomic, strong) UILabel *recContentLabel;
@property (nonatomic, strong) UILabel *showLabel;
@property (nonatomic, strong) UILabel *showUnitLable;
@property (nonatomic, strong) UILabel *sumLbl;
@property (nonatomic, strong) UIButton *dismisBtn;
@property (nonatomic, strong) UIButton *determineBtn;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) CGFloat fontNum;
@property(nonatomic,copy)NSString *unitHeat;
@property(nonatomic,copy)NSString *unitCount;
@property (nonatomic, strong) UIView *mengcengView;
@property(nonatomic, weak) UIViewController *vc;
@property(nonatomic, strong) UIImageView *deleteUp;//删除盖子
@end

@implementation JYRecordingView

#define kTitleYOffset 15.0f
#define kTitleHeight 24.0f

#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f

- (id)initWithTitle:(NSString *)title
         contentSub:(NSString *)subTitle
               unit:(NSString *)unit
        unitFontNum:(CGFloat)fontNum
            RulerScrollViewWithMaxValue:(NSUInteger)maxValue
            average:(NSNumber *)average
           MinValue:(NSUInteger)minValue
       currentValue:(CGFloat)currentValue
          smallMode:(BOOL)mode;
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        /**
         *  左上角的叉号按钮
         */
        UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [xButton setImage:[UIImage imageNamed:@"home_delete1"] forState:UIControlStateNormal];
        xButton.frame = CGRectMake(7,7,34,34);
        [self addSubview:xButton];
        [xButton addTarget:self action:@selector(dismissCLick) forControlEvents:UIControlEventTouchUpInside];
        
        // 标题
        self.recTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, kTitleYOffset, SCREEN_WIDTH - 100, kTitleHeight)];
        self.recTitleLabel.font = [UIFont systemFontOfSize:17];
        self.recTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.recTitleLabel.textColor = [UIColor colorWithHexString:@"#544C57"];
        [self addSubview:self.recTitleLabel];
        
        // 创建一个显示的数字标签
        self.showLabel = [[UILabel alloc] init];
        self.showLabel.font = [UIFont boldSystemFontOfSize:70.0];
        self.showLabel.textColor = [UIColor colorWithHexString:@"#544C57"];
        self.showLabel.frame = CGRectMake(20, (self.recTitleLabel.bottom + 65), SCREEN_WIDTH - 20 * 2, 98);
        self.showLabel.width = 200;
        self.showLabel.x = (SCREEN_WIDTH-200)*0.5;
        self.showLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.showLabel];
        
        self.showUnitLable = [[UILabel alloc] init];
        self.showUnitLable.font = [UIFont systemFontOfSize:17.7];
        self.showUnitLable.textColor = [UIColor colorWithHexString:@"#544C57"];
        self.showUnitLable.frame = CGRectMake(CGRectGetMaxX(self.showLabel.frame), (self.recTitleLabel.bottom + 120), 50, 25);
        self.showUnitLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.showUnitLable];
        
        // 建议文字
        CGFloat contentLabelWidth = SCREEN_WIDTH - 30;
        self.recContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (self.recTitleLabel.bottom + 150), contentLabelWidth, 20)];
        self.recContentLabel.numberOfLines = 0;
        self.recContentLabel.textAlignment = NSTextAlignmentCenter;
        self.recContentLabel.textColor = [UIColor colorWithHexString:@"#777777"];
        self.recContentLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.recContentLabel];
        
        // 创建 JYHRrettyRuler 对象 并设置代理对象
        JYHRrettyRuler *ruler = [[JYHRrettyRuler alloc] initWithFrame:CGRectMake(0, (self.showLabel.bottom + 55), SCREEN_WIDTH, 140)];
        ruler.rulerDeletate = self;
        [ruler showRulerScrollViewWithCount:maxValue average:average MinValue:minValue currentValue:currentValue smallMode:mode];
        [self addSubview:ruler];

        //  确定按钮
        UIButton *deteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deteButton.backgroundColor = [UIColor colorWithHexString:@"#FF7239"];
        [deteButton setTitle:@"确定" forState:UIControlStateNormal];
        deteButton.frame = CGRectMake(0,kAlertHeight-50,SCREEN_WIDTH,50);
        [self addSubview:deteButton];
        [deteButton addTarget:self action:@selector(determineClicked) forControlEvents:UIControlEventTouchUpInside];
        
        /**
         *  设置标题及提示信息的文字
         */
        self.recTitleLabel.text = title;
        self.recContentLabel.text = subTitle;
        self.unit = unit;
        self.fontNum = fontNum;
        
//        self.showLabel.attributedText = [self StrcomposStr:[NSString stringWithFormat:@"%.1f",currentValue] WithUnit:self.unit WithFont:self.fontNum];
//        self.aimValue = [NSString stringWithFormat:@"%.1f",currentValue];
        
        if (ruler.rulerScrollView.rulerAverage < [NSNumber numberWithFloat:1] ) {
            self.aimValue = [NSString stringWithFormat:@"%.1f",ruler.rulerScrollView.rulerValue + ruler.rulerScrollView.rulerMinValue * [ruler.rulerScrollView.rulerAverage floatValue]];
            
//            self.showLabel.attributedText = [self StrcomposStr:[NSString stringWithFormat:@"%.1f",ruler.rulerScrollView.rulerValue + ruler.rulerScrollView.rulerMinValue * [ruler.rulerScrollView.rulerAverage floatValue]] WithUnit:self.unit WithFont:self.fontNum];
            NSString *strdata = [NSString stringWithFormat:@"%.1f",ruler.rulerScrollView.rulerValue + ruler.rulerScrollView.rulerMinValue * [ruler.rulerScrollView.rulerAverage floatValue]];
            self.showLabel.text = strdata;
            CGFloat widthHei = [self TextWidthWithFontSize:70.0 andString:strdata];
            if (widthHei > 146) {
                widthHei = 185;
            }else{
                widthHei = 154;
            }
            self.showLabel.width = widthHei;
            self.showLabel.x = (SCREEN_WIDTH-widthHei)*0.5;
            self.showUnitLable.text = self.unit;
            self.showUnitLable.font = [UIFont systemFontOfSize:self.fontNum];
            self.showUnitLable.x = CGRectGetMaxX(self.showLabel.frame);
        }else{
            self.aimValue = [NSString stringWithFormat:@"%.0f",ruler.rulerScrollView.rulerValue + ruler.rulerScrollView.rulerMinValue * [ruler.rulerScrollView.rulerAverage floatValue]];
            
//            self.showLabel.attributedText = [self StrcomposStr:[NSString stringWithFormat:@"%.0f",ruler.rulerScrollView.rulerValue + ruler.rulerScrollView.rulerMinValue * [ruler.rulerScrollView.rulerAverage floatValue]] WithUnit:self.unit WithFont:self.fontNum];
            
            NSString *strdata = [NSString stringWithFormat:@"%.0f",ruler.rulerScrollView.rulerValue + ruler.rulerScrollView.rulerMinValue * [ruler.rulerScrollView.rulerAverage floatValue]];
            self.showLabel.text = strdata;
            CGFloat widthHei = [self TextWidthWithFontSize:70.0 andString:strdata];
            if (widthHei > 85) {
                widthHei = 135;
            }else{
                widthHei = 95;
            }
            self.showLabel.width = widthHei;
            self.showLabel.x = (SCREEN_WIDTH-widthHei)*0.5;
            self.showUnitLable.text = self.unit;
            self.showUnitLable.font = [UIFont systemFontOfSize:self.fontNum];
            self.showUnitLable.x = CGRectGetMaxX(self.showLabel.frame);
        }
    }
    
    return self;
}

// JYRrettyRulerDelegate
- (void)JYRrettyRuler:(JYRulerScrollView *)rulerScrollView {
    // 超过最大值，取最大值
    if ((rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue]) > rulerScrollView.rulerCount* [rulerScrollView.rulerAverage floatValue]) {
        rulerScrollView.rulerValue = (rulerScrollView.rulerCount-rulerScrollView.rulerMinValue) * [rulerScrollView.rulerAverage floatValue];
    }
    if (self.sumLbl) {
        if (rulerScrollView.rulerAverage < [NSNumber numberWithFloat:1] ) {
            self.aimValue = [NSString stringWithFormat:@"%.1f",rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue]];
            self.sumLbl.attributedText = [self StrcomposStr:self.aimValue WithUnit:self.unit WithFont:self.fontNum];
            
            self.showLabel.text = [NSString stringWithFormat:@"%.0f大卡",(rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue])*self.unitHeat.floatValue/self.unitCount.floatValue];
//            NSString *strdata = [NSString stringWithFormat:@"%.0f",(rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue])*self.unitHeat.floatValue/self.unitCount.floatValue];
//            self.showLabel.text = strdata;
//            CGFloat widthHei = [strdata TextWidthWithFontSize:70.0];
//            if (widthHei <= 43) {
//                widthHei = 45;
//            }else if (widthHei > 43 && widthHei < 103){
//                widthHei = 95;
//                if ([strdata isEqualToString:@"111"]) {
//                    widthHei = 110;
//                }
//            }else if (widthHei >= 103) {
//                widthHei = 135;
//            }
//            self.showLabel.width = widthHei;
//            self.showLabel.jy_x = (SCREEN_WIDTH-widthHei)*0.5;
//            self.showUnitLable.text = @"大卡";
//            self.showUnitLable.font = JYFont(self.fontNum);
//            self.showUnitLable.jy_x = CGRectGetMaxX(self.showLabel.frame);
        }else{
            self.aimValue = [NSString stringWithFormat:@"%.0f",rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue]];
            
            self.sumLbl.attributedText = [self StrcomposStr:self.aimValue WithUnit:self.unit WithFont:self.fontNum];
            self.showLabel.text = [NSString stringWithFormat:@"%.0f大卡",(rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue])*self.unitHeat.floatValue/self.unitCount.floatValue];
//            NSString *strdata = [NSString stringWithFormat:@"%.0f",(rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue])*self.unitHeat.floatValue/self.unitCount.floatValue];
//            self.showLabel.text = strdata;
//            CGFloat widthHei = [strdata TextWidthWithFontSize:70.0];
//            if (widthHei <= 43) {
//                widthHei = 45;
//            }else if (widthHei > 43 && widthHei < 93){
//                widthHei = 95;
//            }else if (widthHei >= 93 && widthHei <= 130) {
//                widthHei = 135;
//            }else if(widthHei > 130){
//                widthHei = 180;
//            }
//            self.showLabel.width = widthHei;
//            self.showLabel.jy_x = (SCREEN_WIDTH-widthHei)*0.5;
//            self.showUnitLable.text = @"大卡";
//            self.showUnitLable.font = JYFont(self.fontNum);
//            self.showUnitLable.jy_x = CGRectGetMaxX(self.showLabel.frame);
        }
    }else {
        if (rulerScrollView.rulerAverage < [NSNumber numberWithFloat:1] ) {
            self.aimValue = [NSString stringWithFormat:@"%.1f",rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue]];
            
//            self.showLabel.attributedText = [self StrcomposStr:[NSString stringWithFormat:@"%.1f",rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue]] WithUnit:self.unit WithFont:self.fontNum];
            NSString *strdata = [NSString stringWithFormat:@"%.1f",rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue]];
            self.showLabel.text = strdata;
            CGFloat widthHei = [self TextWidthWithFontSize:70.0 andString:strdata];
            if (widthHei > 146) {
                widthHei = 185;
            }else{
                widthHei = 154;
            }
            self.showLabel.width = widthHei;
            self.showLabel.x = (SCREEN_WIDTH-widthHei)*0.5;
            self.showLabel.textAlignment = NSTextAlignmentLeft;
            self.showUnitLable.text = self.unit;
            self.showUnitLable.font = [UIFont systemFontOfSize:self.fontNum];
            self.showUnitLable.x = CGRectGetMaxX(self.showLabel.frame);
            
        }else{
            self.aimValue = [NSString stringWithFormat:@"%.0f",rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue]];
            
//            self.showLabel.attributedText = [self StrcomposStr:[NSString stringWithFormat:@"%.0f",rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue]] WithUnit:self.unit WithFont:self.fontNum];
            NSString *strdata = [NSString stringWithFormat:@"%.0f",rulerScrollView.rulerValue + rulerScrollView.rulerMinValue * [rulerScrollView.rulerAverage floatValue]];
            self.showLabel.text = strdata;
            CGFloat widthHei = [self TextWidthWithFontSize:70.0 andString:strdata];
            if (widthHei > 85) {
                widthHei = 135;
            }else{
                widthHei = 95;
            }
            self.showLabel.width = widthHei;
            self.showLabel.textAlignment = NSTextAlignmentLeft;
            self.showLabel.x = (SCREEN_WIDTH-widthHei)*0.5;
            self.showUnitLable.text = self.unit;
            self.showUnitLable.font = [UIFont systemFontOfSize:self.fontNum];
            self.showUnitLable.x = CGRectGetMaxX(self.showLabel.frame);
        }
    }
}

- (void)determineClicked
{
    if (self.determineBlock) {
        self.determineBlock();
    }
    [self dismissCLick];
}

- (void)lookDetailClicked
{
    if (self.lookDetailBlock) {
        self.lookDetailBlock();
    }
}

- (void)deleteClicked
{
    CATransform3D rotationTransform = CATransform3DMakeRotation(1, 0, 0, 45*180.0/M_PI);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration  =  1;
    
    animation.autoreverses = NO;
    
    animation.cumulative = NO;
    
//    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount = 4;
    [self.deleteUp.layer addAnimation:animation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.deleteBlock) {
            self.deleteBlock();
        }
        [self dismissCLick];
    });
    
    
}

- (void)show
{
    UIViewController *topVC = self.vc;
    if (!topVC) {
        topVC = [self appRootViewController];
    }
    
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
     // 添加蒙层
//    UIView *mengcengView = [[UIView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIView *mengcengView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mengcengView.backgroundColor = [UIColor blackColor];
    mengcengView.alpha = 0.5;
    [topVC.view addSubview:mengcengView];
    self.mengcengView = mengcengView;
    self.mengcengView.hidden = NO;
    
    UITapGestureRecognizer *mengcengTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mengcengViewTap:)];
    [self.mengcengView addGestureRecognizer:mengcengTap];
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kAlertHeight);
    [UIView animateWithDuration:0.35 animations:^{
       
        self.mengcengView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        self.frame = CGRectMake(0, CGRectGetHeight(topVC.view.bounds) -kAlertHeight, SCREEN_WIDTH, kAlertHeight);
    }];
    
    [topVC.view addSubview:self];
}

- (void)mengcengViewTap:(UIGestureRecognizer *)ges{
    [self dismissCLick];
}

- (void)dismissCLick{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    
//    self.mengcengView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [UIView animateWithDuration:0.35 animations:^{
//        self.mengcengView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.mengcengView.hidden = YES;
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kAlertHeight);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        [self.mengcengView removeFromSuperview];
    });
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    [super removeFromSuperview];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    CGRect afterFrame = CGRectMake(0, (CGRectGetHeight(topVC.view.bounds) - kAlertHeight), SCREEN_WIDTH, kAlertHeight);
    
    self.frame = afterFrame;

    [super willMoveToSuperview:newSuperview];
}

- (void)tap: (UITapGestureRecognizer *)tap {
    
    [self removeFromSuperview];
}

// 拼接字符串
- (NSMutableAttributedString *)StrcomposStr:(NSString *)strcompos WithUnit:(NSString *)unit WithFont:(CGFloat)kgsize{
    NSString *str = [NSString stringWithFormat:@"%@%@", strcompos,unit];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:kgsize]
                          range:NSMakeRange(str.length-unit.length, unit.length)];
    
    return AttributedStr;
}

- (CGFloat)TextWidthWithFontSize:(CGFloat)fontSize andString:(NSString *)str
{
    CGSize sizeToFit = [str sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 20) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.width;
}

@end
