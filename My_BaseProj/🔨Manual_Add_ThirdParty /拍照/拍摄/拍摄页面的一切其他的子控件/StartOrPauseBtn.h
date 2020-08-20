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

@interface StartOrPauseBtn : UIView

@property(nonatomic,strong)NSTimer *mytimer;
@property(nonatomic,assign)ShottingStatus shottingStatus;

@property(nonatomic,assign)CGFloat time;//录制时间
@property(nonatomic,assign)CGFloat currentTime;//已经录了多少秒
@property(nonatomic,assign)CGFloat safetyTime;//小于等于这个时间点的录制的视频不允许被保存，而是应该被遗弃

-(void)actionTapGRHandleSingleFingerBlock:(MKDataBlock)tapGRHandleSingleFingerActionBlock;
//-(void)actionLongPressGRBlock:(MKDataBlock)longPressGRActionBlock;
-(void)actionStartOrPauseBtnBlock:(MKDataBlock)startOrPauseBtnBlock;

@end

NS_ASSUME_NONNULL_END
