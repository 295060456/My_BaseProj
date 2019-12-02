//
//  TimeManager.h
//  Feidegou
//
//  Created by Kite on 2019/12/2.
//  Copyright © 2019 朝花夕拾. All rights reserved.
// https://www.jianshu.com/p/b7fab0d6a388

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NSTimer_scheduledTimerWithTimeInterval = 0,
    NSTimer_timerWithTimeInterval
} NSTimerStyle;

NS_ASSUME_NONNULL_BEGIN

@interface TimeManager : NSObject

+ (instancetype)sharedInstance;
#pragma mark —— GCD
-(void)GCDTimer:(SEL)wantToDo
         caller:(id)caller
       interval:(uint64_t)intervalTime;
//暂停定时器
-(void)suspendGCDTimer;
//取消定时器
-(void)endGCDTimer;
//开启定时器
-(void)startGCDTimer;

#pragma mark —— CAD
-(void)CADTimer:(SEL)wantToDo
         caller:(id)caller
       interval:(uint64_t)intervalTime;
//开启定时器
-(void)startCADTimer;
//取消定时器
-(void)endCADTimer;
//暂停定时器
-(void)suspendCADTimer;

#pragma mark —— NSTimer
-(void)CADTimer:(SEL)wantToDo
     timerStyle:(NSTimerStyle)TimerStyle
         target:(id)aTarget
       userInfo:(nullable id)userInfo
       interval:(NSTimeInterval)interval
        repeats:(BOOL)repeats
         caller:(id)caller
     invocation:(NSInvocation *)invocation
          block:(void (^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END
