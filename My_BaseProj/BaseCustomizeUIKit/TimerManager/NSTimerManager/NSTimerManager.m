//
//  NSTimerManager.m
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSTimerManager.h"

@interface NSTimerManager ()

@property(nonatomic,strong)NSDate *date;
@property(nonatomic,copy)MKDataBlock NSTimerManagerBlock;

@end

@implementation NSTimerManager

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    if (_nsTimer) {
        [NSTimerManager nsTimeDestroy:_nsTimer];
    }
}

- (instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)actionNSTimerManagerBlock:(MKDataBlock)NSTimerManagerBlock{
    _NSTimerManagerBlock = NSTimerManagerBlock;
}
///定时器启动 系统自动添加到RunLoop
-(NSTimer *)nsTimeStartSysAutoInRunLoop{
    switch (self.timerType) {
        case ScheduledTimerType_0:{
            self.nsTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                           repeats:self.repeats
                                                             block:^(NSTimer * _Nonnull timer) {
                if (self.NSTimerManagerBlock) {
                    self.NSTimerManagerBlock(timer);
                }
            }];
        }break;
        case ScheduledTimerType_1:{
            self.nsTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                        invocation:self.invocation
                                                           repeats:self.repeats];
        }break;
        case ScheduledTimerType_2:{
            self.nsTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                            target:self.target
                                                          selector:self.selector
                                                          userInfo:self.userInfo
                                                           repeats:self.repeats];
        }break;

        default:
            self.nsTimer = nil;
            break;
    }
    return self.nsTimer;
}
///定时器启动 手动添加定时器到RunLoop
+(void)nsTimeStart:(NSTimer *)nsTimer
       withRunLoop:(NSRunLoop *_Nullable)runLoop{
    if (!runLoop) {
        runLoop = NSRunLoop.mainRunLoop;
    }
    [runLoop addTimer:nsTimer
              forMode:NSDefaultRunLoopMode];
}
///定时器暂停
+(void)nsTimePause:(NSTimer *)nsTimer{
    if (nsTimer) {
        [nsTimer setFireDate:NSDate.distantFuture];
    }
}
///定时器继续
+(void)nsTimecontinue:(NSTimer *)nsTimer{
    if (nsTimer) {
        [nsTimer setFireDate:NSDate.date];
    }
}
///销毁定时器
+(void)nsTimeDestroy:(NSTimer *)nsTimer{
    if (nsTimer) {
        [nsTimer invalidate];//这个是唯一一个可以将计时器从runloop中移出的方法
        nsTimer = nil;
    }
}
#pragma mark —— lazyLoad
#pragma mark —— 系统Api暴露出来的未被废弃的 NSTimer 的初始化方法有如下几种:

//+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
//                                invocation:(NSInvocation *)invocation
//                                   repeats:(BOOL)yesOrNo;
//+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
//                                    target:(id)aTarget
//                                  selector:(SEL)aSelector
//                                  userInfo:(nullable id)userInfo//????
//                                   repeats:(BOOL)yesOrNo;
//+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
//                                   repeats:(BOOL)repeats
//                                     block:(void (^)(NSTimer *timer))block;

/*
*   scheduledTimerWithTimeInterval相比它的小伙伴们不仅仅是创建了NSTimer对象,
*   还把该对象加入到了当前的runloop中
*   runloop的模式为默认模式（NSDefaultRunLoopMode）!
*   NSTimer只有被加入到runloop, 才会生效, 即NSTimer才会被真正执行
*/

//+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti
//                       invocation:(NSInvocation *)invocation
//                          repeats:(BOOL)yesOrNo;

//+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti
//                           target:(id)aTarget
//                         selector:(SEL)aSelector
//                         userInfo:(nullable id)userInfo//????
//                          repeats:(BOOL)yesOrNo;

//+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
//                          repeats:(BOOL)repeats
//                            block:(void (^)(NSTimer *timer))block;

//-(instancetype)initWithFireDate:(NSDate *)date
//                       interval:(NSTimeInterval)interval
//                        repeats:(BOOL)repeats
//                          block:(void (^)(NSTimer *timer))block;

-(NSTimer *)nsTimer{
    if (!_nsTimer) {
        _nsTimer = [[NSTimer alloc] initWithFireDate:self.date
                                            interval:1//self.interval
                                             repeats:YES//self.repeats
                                               block:^(NSTimer * _Nonnull timer) {
            if (self.NSTimerManagerBlock) {
                self.NSTimerManagerBlock(timer);
            }
        }];
    }return _nsTimer;
}

-(NSDate *)date{
    if (!_date) {
        _date = [[NSDate alloc] initWithTimeIntervalSinceNow:self.timeSecIntervalSinceDate];
    }return _date;
}

-(NSTimeInterval)timeInterval{
    if (_timeInterval == 0) {
        _timeInterval = 1.0f;
    }return _timeInterval;
}

-(BOOL)repeats{
    if (!_repeats) {
        _repeats = YES;
    }return _repeats;
}

-(id)target{
    if (!_target) {
        _target = self;
    }return _target;
}

-(NSInvocation *)invocation{
    if (!_invocation) {
        //需要补充
    }return _invocation;
}

@end
