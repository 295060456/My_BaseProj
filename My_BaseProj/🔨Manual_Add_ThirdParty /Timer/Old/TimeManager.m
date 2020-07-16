//
//  TimeManager.m
//  Feidegou
//
//  Created by Kite on 2019/12/2.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "TimeManager.h"

@interface TimeManager ()

@property(nonatomic,strong)dispatch_source_t GCDtimer;
@property(nonatomic,strong)CADisplayLink *CADtimer;
@property(nonatomic,strong)NSTimer *nsTimer;

@end

@implementation TimeManager

static TimeManager *instance = nil;
static dispatch_once_t onceToken;
+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        instance = TimeManager.new;
    });return instance;
}
#pragma mark —— GCD
-(void)GCDTimer:(SEL)wantToDo
         caller:(id)caller
       interval:(uint64_t)intervalTime{
    //获取队列，这里获取全局队列（tips：可以单独创建一个队列跑定时器）
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建定时器（dispatch_source_t本质还是个OC对象）
    self.GCDtimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //start参数控制计时器第一次触发的时刻，延迟0s
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    //    dispatch_time_t start = dispatch_walltime(NULL, 0);
    //每隔几秒执行一次
    uint64_t interval;
    if (intervalTime == 0) {
        interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    }else{
        interval = (uint64_t)(intervalTime * NSEC_PER_SEC);
    }
    if (!caller) {
        caller = self;
    }
    dispatch_source_set_timer(self.GCDtimer, start, interval, 0);
    @weakify(caller)
    dispatch_source_set_event_handler(self.GCDtimer, ^{
        //要执行的任务
        @strongify(caller)
        if (wantToDo) {
            [caller performSelector:wantToDo
                         withObject:Nil];
        }else{
            [caller performSelector:@selector(wantToDo)
                         withObject:Nil];
        }
    });
    //开始执行定时器
    dispatch_resume(self.GCDtimer);
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
#pragma mark —— CAD
-(void)CADTimer:(SEL)wantToDo
         caller:(id)caller
       interval:(uint64_t)intervalTime{
    uint64_t interval;
    if (intervalTime == 0) {
        interval = 1;
    }else{
        interval = intervalTime;
    }
    
    if (!caller) {
        caller = self;
    }
    /**  < 创建CADisplayLink >  */
    self.CADtimer = [CADisplayLink displayLinkWithTarget:caller
                                                selector:@selector(wantToDo)];
    //刷新频率
    if (@available(iOS 10.0, *)) {
        self.CADtimer.preferredFramesPerSecond = interval;
    } else {
        // Fallback on earlier versions
        self.CADtimer.frameInterval = interval;
    }
    /**  < 注册到RunLoop中 NSDefaultRunLoopMode >  */
    [self.CADtimer addToRunLoop:NSRunLoop.currentRunLoop
                        forMode:NSDefaultRunLoopMode];
}
//开启定时器
-(void)startCADTimer{
    self.CADtimer.paused = NO;
}
//取消定时器
-(void)endCADTimer{
    [self.CADtimer invalidate];
    self.CADtimer = nil;
}
//暂停定时器
-(void)suspendCADTimer{
    self.CADtimer.paused = YES;
}
#pragma mark —— NSTimer
-(void)CADTimer:(SEL)wantToDo
     timerStyle:(NSTimerStyle)TimerStyle
         target:(id)aTarget
       userInfo:(nullable id)userInfo
       interval:(NSTimeInterval)interval
        repeats:(BOOL)repeats
         caller:(id)caller
     invocation:(NSInvocation *)invocation
          block:(void (^)(NSTimer *timer))block{
    
    if (TimerStyle == NSTimer_scheduledTimerWithTimeInterval) {
        if (@available(iOS 10.0, *)) {
            self.nsTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                           repeats:repeats
                                                             block:block];
        }else{
//            创建一个timer并把它指定到一个默认的runloop模式中，并且在 TimeInterval时间后 启动定时器
            self.nsTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                        invocation:invocation
                                                           repeats:repeats];
            //创建一个timer并把它指定到一个默认的runloop模式中，并且在 TimeInterval时间后 启动定时器
            self.nsTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                            target:aTarget
                                                          selector:wantToDo
                                                          userInfo:userInfo
                                                           repeats:repeats];
        }
    }else if (TimerStyle == NSTimer_timerWithTimeInterval){
        if (@available(iOS 10.0, *)) {
            self.nsTimer = [NSTimer timerWithTimeInterval:interval
                                                  repeats:repeats
                                                    block:block];
        } else {
//             创建一个定时器，但是么有添加到运行循环，我们需要在创建定时器后手动的调用 NSRunLoop 对象的 addTimer:forMode: 方法。
            self.nsTimer = [NSTimer timerWithTimeInterval:interval
                                                   target:aTarget
                                                 selector:wantToDo
                                                 userInfo:userInfo
                                                  repeats:repeats];
        }
    }else{}
    
    // 创建一个定时器，但是么有添加到运行循环，我们需要在创建定时器后手动的调用 NSRunLoop 对象的 addTimer:forMode: 方法。
//    + (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;

    
//    1、参数repeats是指定是否循环执行，YES将循环，NO将只执行一次。
//    2、timerWithTimeInterval  这两个类方法创建出来的对象如果不用 addTimer: forMode方法手动加入主循环池中，将不会循环执行。
//    3、scheduledTimerWithTimeInterval  这两个方法会将定时器添加到当前的运行循环，运行循环的模式为默认模式。
//    4、init方法需要手动加入循环池，它会在设定的启动时间启动。
}

#pragma mark —— 公共方法
-(void)wantToDo{
    NSLog(@"GCDTimer");
}

@end
