//
//  UIButton+CountDownBtn.h
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerManager.h"

typedef enum : NSUInteger {
    ShowTimeType_SS = 0,//秒
    ShowTimeType_MMSS,//分秒
    ShowTimeType_HHMMSS,//时分秒
} ShowTimeType;

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CountDownBtn)

@property(nonatomic,strong)NSTimerManager *nsTimerManager;
@property(nonatomic,strong)NSString *titleBeginStr;
@property(nonatomic,strong)NSString *titleRuningStr;//倒计时过程中显示的非时间文字
@property(nonatomic,strong)NSString *titleEndStr;
@property(nonatomic,strong)UIColor *titleColor;
//倒计时开始前的背景色直接对此控件进行赋值 backgroundColor
@property(nonatomic,strong)UIColor *bgCountDownColor;//倒计时的时候此btn的背景色
@property(nonatomic,strong)UIColor *bgEndColor;//倒计时完全结束后的背景色
@property(nonatomic,strong)UIColor *layerBorderColor;
@property(nonatomic,strong)UIFont *titleLabelFont;
@property(nonatomic,assign)CGFloat layerCornerRadius;
@property(nonatomic,assign)CGFloat layerBorderWidth;
@property(nonatomic,assign)ShowTimeType showTimeType;//时间显示风格
@property(nonatomic,assign)long count;// 倒计时
@property(nonatomic,copy)MKDataBlock countDownBlock;

-(void)actionCountDownBlock:(MKDataBlock)countDownBlock;//倒计时需要触发调用的方法
-(void)timeFailBeginFrom:(NSInteger)timeCount;//倒计时时间次数

@end

NS_ASSUME_NONNULL_END
