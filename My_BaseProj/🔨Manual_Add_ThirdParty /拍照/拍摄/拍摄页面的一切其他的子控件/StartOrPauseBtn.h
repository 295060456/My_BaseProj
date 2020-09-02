//
//  StartOrPauseBtn.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZCircleProgress.h"

typedef enum : NSUInteger {
    ShottingStatus_on = 0,//开始录制
    ShottingStatus_suspend,//暂停录制
    ShottingStatus_continue,//继续录制
    ShottingStatus_off//取消录制
} ShottingStatus;

NS_ASSUME_NONNULL_BEGIN

//说是一个button，实际上是一个View
@interface StartOrPauseBtn : UIView

@property(nonatomic,assign)ShottingStatus shottingStatus;
@property(nonatomic,strong)ZZCircleProgress *progressView;
@property(nonatomic,strong)NSTimerManager *nsTimerManager;
@property(nonatomic,assign)CGFloat time;//录制时间
@property(nonatomic,assign)CGFloat currentTime;//已经录了多少秒
@property(nonatomic,assign)CGFloat safetyTime;//小于等于这个时间点的录制的视频不允许被保存，而是应该被遗弃
@property(nonatomic,assign)BOOL isClickStartOrPauseBtn;
@property(nonatomic,assign)BOOL isCountDown;

#pragma mark —— 链接性质的Block方法
-(void)actionFinishWorkBlock:(MKDataBlock)finishWorkBlock;
-(void)actionTapGRHandleSingleFingerBlock:(MKDataBlock)tapGRHandleSingleFingerActionBlock;
-(void)actionStartOrPauseBtnBlock:(MKDataBlock)startOrPauseBtnBlock;
//-(void)actionLongPressGRBlock:(MKDataBlock)longPressGRActionBlock;//长按事件
#pragma mark —— 功能性的方法
-(void)tapGRHandleSingleFingerAction:(UITapGestureRecognizer *_Nullable)sender;//点击事件
-(void)tapGRUI:(BOOL)isClick;
-(void)reset;

#pragma mark —— 开始录制
-(void)vedioShoottingOn;
#pragma mark —— 结束录制
-(void)vedioShoottingEnd;
#pragma mark —— 暂停录制
-(void)vedioShoottingSuspend;
#pragma mark —— 继续录制
-(void)vedioShoottingContinue;
#pragma mark —— 取消录制
-(void)vedioShoottingOff;

@end

NS_ASSUME_NONNULL_END
