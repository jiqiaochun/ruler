//
//  ViewController.m
//  testJYRuler
//
//  Created by 姬巧春 on 16/6/13.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "ViewController.h"

#import "JYRecordingView.h"
#import "UIButton+JYCustom.h"

@interface ViewController ()

@property (nonatomic,copy) NSString *maxWeight;
@property (nonatomic,strong) NSString *minWeight;
@property ( nonatomic,strong) NSString *targetWeight;

@property ( nonatomic,strong) UIButton *needBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maxWeight = @"80";
    self.minWeight = @"50";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, self.view.frame.size.width /3.0, 100)];
    [btn setTitle:@"60" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"home_weight_edit"] forState:UIControlStateNormal];
    [btn horizontalCenterTitleAndImage:5];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *needBtn = [[UIButton alloc] initWithFrame:CGRectMake(100,100, self.view.frame.size.width /3.0, 50)];
    self.needBtn = needBtn;
    [needBtn setTitle:@"60" forState:UIControlStateNormal];
    [needBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [needBtn setImage:[UIImage imageNamed:@"home_weight_edit"] forState:UIControlStateNormal];
    [needBtn horizontalCenterTitleAndImage:5];
    needBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:needBtn];
    
}

- (void)btnClick:(UIButton *)btn{
    // 判断最后一位小数点是不是0
    NSString *maxWeightS = [self strCurWeight:self.maxWeight withTargetWeight:@"0"];
    NSString *minWeightS = [self strCurWeight:self.minWeight withTargetWeight:@"0"];
    JYRecordingView *rec = [[JYRecordingView alloc] initWithTitle:@"目标体重" contentSub:[NSString stringWithFormat:@"你的最佳体重范围：%@-%@kg",minWeightS,maxWeightS] unit:@"kg" unitFontNum:17.7 RulerScrollViewWithMaxValue:1990 average:[NSNumber numberWithFloat:0.1] MinValue:250 currentValue:55-25 smallMode:YES];
    [rec show];
    
    __weak typeof(rec) weakRec = rec;
    rec.determineBlock = ^{
        self.targetWeight = weakRec.aimValue;
        // 判断最后一位小数点是不是0
        NSString *needWeightStr = [self strCurWeight:@"70" withTargetWeight:self.targetWeight];
        if ([needWeightStr floatValue] < 0) {
            needWeightStr = @"0";
        }
        // 还需减重 needWeightStr
        [btn setTitle:weakRec.aimValue forState:UIControlStateNormal];
        [btn horizontalCenterTitleAndImage:5];
        
        [self.needBtn setTitle:needWeightStr forState:UIControlStateNormal];
        [self.needBtn horizontalCenterTitleAndImage:5];
    };
    rec.dismissBlock = ^{
        
    };
}

- (NSString *)strCurWeight:(NSString *)weight withTargetWeight:(NSString *)targetWeight{
    // 判断最后一位小数点是不是0
    CGFloat needWeightF = [weight doubleValue] - [targetWeight doubleValue];
    NSString *needWeightStr = [NSString stringWithFormat:@"%lf",needWeightF];
    
    NSUInteger needloc = [needWeightStr rangeOfString:@"."].location;
    NSString *needlast = [needWeightStr substringWithRange:NSMakeRange(needloc+1, 1)];
    if ([needlast isEqualToString:@"0"]) {
        needWeightStr = [needWeightStr substringToIndex:needloc];
    }else{
        needWeightStr = [needWeightStr substringToIndex:needloc+2];
    }
    return needWeightStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
