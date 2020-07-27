//
//  TimeManager.m
//  My_BaseProj
//
//  Created by Kite on 2019/12/13.
//  Copyright © 2019 Corp. All rights reserved.
//

#import "TimeManager.h"

#pragma mark —— GCDTimerManager
@interface GCDTimerManager ()

@property(nonatomic,strong)dispatch_source_t GCDtimer;
@property(nonatomic,strong)dispatch_queue_t queue;
@property(nonatomic,assign)uint64_t startTime;
@property(nonatomic,assign)uint64_t intervalTime;
@property(nonatomic,copy)MKDataBlock block;

@end

@interface CADisplayLinkTimerManager ()

@property(nonatomic,strong)CADisplayLink *CADisplayLinkTimer;
@property(nonatomic,assign)CFTimeInterval beginTime;
@property(nonatomic,assign)SEL selector;

@end

@implementation GCDTimerManager

static GCDTimerManager *instance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = GCDTimerManager.new;
    });return instance;
}

-(void)makeGCDTimerWithStartTime:(uint64_t)startTime
                    intervalTime:(uint64_t)intervalTime{
    self.startTime = startTime;
    self.intervalTime = intervalTime;
    //开始包括设置和启动两个阶段
    [self setGCDTimer];
    [self startGCDTimer];
   //设置回调
    dispatch_source_set_event_handler(self.GCDtimer, ^{
        NSLog(@"----self.timer---");
        if (self.block) {
            self.block(self.GCDtimer);
        }
    });
}

-(void)actionBlock:(MKDataBlock)block{
    _block = block;
}

-(void)setGCDTimer{
    //设置Timer
    //start参数控制计时器第一次触发的时刻，延迟默认0s
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, self.startTime * NSEC_PER_SEC);//开始时间
    uint64_t interval = self.intervalTime * NSEC_PER_SEC;//间隔时间
    dispatch_source_set_timer(self.GCDtimer,
                              start,
                              interval,
                              0);
}
//开启定时器
-(void)startGCDTimer{
    dispatch_resume(self.GCDtimer);
}
//取消定时器
-(void)endGCDTimer{
    dispatch_cancel(self.GCDtimer);
    self.GCDtimer = nil;
}
//暂停定时器
-(void)suspendGCDTimer{
    dispatch_suspend(self.GCDtimer);
}
#pragma mark —— lazyLoad
-(dispatch_queue_t)queue{
    if (!_queue) {
        //获取队列，这里获取全局队列（tips：可以单独创建一个队列跑定时器）
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }return _queue;
}

-(dispatch_source_t)GCDtimer{
    if (!_GCDtimer) {
        _GCDtimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                           0,
                                           0,
                                           self.queue);
    }return _GCDtimer;
}

-(uint64_t)startTime{
    if (!_startTime) {
        _startTime = 0;
    }return _startTime;
}

-(uint64_t)intervalTime{
    if (!_intervalTime) {
        _intervalTime = 1;
    }return _intervalTime;
}

@end

#pragma mark —— CADisplayLink
@implementation CADisplayLinkTimerManager

-(void)sddWithSel:(SEL)selector{
    self.selector = selector;
    [self.CADisplayLinkTimer addToRunLoop:NSRunLoop.currentRunLoop
                                  forMode:NSRunLoopCommonModes];
}

-(void)startCADisplayLinkTimer{
  self.beginTime = CACurrentMediaTime();
  self.CADisplayLinkTimer.paused = NO;
}

/*
 移除计时器有两个方法:-(void)removeFromRunLoop:(NSRunLoop *)runloop forMode:(NSRunLoopMode)mode 和 -(void)invalidate.
 我们来分析一下他们的异同
 - removeFromRunLoop: forMode:会将接收者从给定的模式中移除,这个方法会对计时器进行隐式的release.在调用removeFromRunloop方法,需要做判断,如果当期计时器不在runloop的话,会出现野指针的crash.出现crash的原因是runloop多次调用了release方法,进行了over-release.
 
 - (void)invalidate是从runloop所有模式中移除计时器,并取消计时器和target的关联关系.多次调用这个方法,不会出现crash.
 */
-(void)stopCADisplayLinkTimer{
    self.CADisplayLinkTimer.paused = YES;
    [self.CADisplayLinkTimer invalidate];
    self.CADisplayLinkTimer = nil;
}

-(void)wantToDo{
    NSLog(@"GCDTimer");
}
#pragma mark —— lazyLoad
-(CADisplayLink *)CADisplayLinkTimer{
    if (!_CADisplayLinkTimer) {
        _CADisplayLinkTimer = [CADisplayLink displayLinkWithTarget:self
                                                          selector:self.selector];
        _CADisplayLinkTimer.paused = YES;
    }return _CADisplayLinkTimer;
}

@end



