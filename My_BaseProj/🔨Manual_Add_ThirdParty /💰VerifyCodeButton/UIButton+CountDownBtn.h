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

typedef enum : NSUInteger {
    CountDownBtnType_normal = 0,//普通模式
    CountDownBtnType_countDown//倒计时模式
} CountDownBtnType;

NS_ASSUME_NONNULL_BEGIN

/*
 *  倒计时期间，不接受任何的点击事件
 *
 */

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
@property(nonatomic,assign)long count;// 倒计时
@property(nonatomic,assign)ShowTimeType showTimeType;//时间显示风格
@property(nonatomic,assign)CountDownBtnType countDownBtnType;
@property(nonatomic,copy)MKDataBlock countDownBlock;
@property(nonatomic,copy)MKDataBlock countDownClickEventBlock;
@property(nonatomic,assign)BOOL isCountDownClockFinished;//倒计时是否结束
@property(nonatomic,assign)BOOL isCountDownClockOpen;//倒计时是否开始

-(void)actionCountDownBlock:(MKDataBlock)countDownBlock;//倒计时需要触发调用的方法：倒计时的时候外面同时干的事，随着定时器走，可以不实现
-(void)actionCountDownClickEventBlock:(MKDataBlock)countDownClickEventBlock;//点击事件回调，就不要用系统的addTarget/action/forControlEvents
-(void)timeFailBeginFrom:(NSInteger)timeCount;//倒计时时间次数
-(instancetype)initWithType:(CountDownBtnType)countDownBtnType;//用这个初始化方法

@end

NS_ASSUME_NONNULL_END
