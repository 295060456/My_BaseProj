//
//  TimeManager.h
//  My_BaseProj
//
//  Created by Kite on 2019/12/13.
//  Copyright © 2019 Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN
/*
NSTimer受runloop的影响,由于runloop需要处理很多任务,导致NSTimer的精度降低.
在日常开发中，如果我们需要对定时器的精度要求很高的话,可以考虑dispatch_source_t去实现.
dispatch_source_t精度很高,系统自动触发,系统级别的源.
 */
#pragma mark —— GCDTimerManager
@interface GCDTimerManager : NSObject

-(void)makeGCDTimerWithStartTime:(uint64_t)startTime
                    intervalTime:(uint64_t)intervalTime;


//timer回调方法
-(void)actionBlock:(MKDataBlock)block;

//开启定时器
-(void)startGCDTimer;
//取消定时器
-(void)endGCDTimer;
//暂停定时器
-(void)suspendGCDTimer;

@end

/*
 *  什么是CADisplayLink
 CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。我们在应用中创建一个新的 CADisplayLink 对象，把它添加到一个runloop中，并给它提供一个 target 和selector 在屏幕刷新的时候调用。

 一但 CADisplayLink 以特定的模式注册到runloop之后，每当屏幕需要刷新的时候，runloop就会调用CADisplayLink绑定的target上的selector，这时target可以读到 CADisplayLink 的每次调用的时间戳，用来准备下一帧显示需要的数据。例如一个视频应用使用时间戳来计算下一帧要显示的视频数据。在UI做动画的过程中，需要通过时间戳来计算UI对象在动画的下一帧要更新的大小等等。
 在添加进runloop的时候我们应该选用高一些的优先级，来保证动画的平滑。可以设想一下，我们在动画的过程中，runloop被添加进来了一个高优先级的任务，那么，下一次的调用就会被暂停转而先去执行高优先级的任务，然后在接着执行CADisplayLink的调用，从而造成动画过程的卡顿，使动画不流畅。

 duration属性提供了每帧之间的时间，也就是屏幕每次刷新之间的的时间。我们可以使用这个时间来计算出下一帧要显示的UI的数值。但是 duration只是个大概的时间，如果CPU忙于其它计算，就没法保证以相同的频率执行屏幕的绘制操作，这样会跳过几次调用回调方法的机会。
 frameInterval属性是可读可写的NSInteger型值，标识间隔多少帧调用一次selector 方法，默认值是1，即每帧都调用一次。如果每帧都调用一次的话，对于iOS设备来说那刷新频率就是60HZ也就是每秒60次，如果将 frameInterval 设为2 那么就会两帧调用一次，也就是变成了每秒刷新30次。
 我们通过pause属性开控制CADisplayLink的运行。当我们想结束一个CADisplayLink的时候，应该调用-(void)invalidate
 从runloop中删除并删除之前绑定的 target跟selector
 另外CADisplayLink 不能被继承。

 *  CADisplayLink 与 NSTimer 有什么不同
 iOS设备的屏幕刷新频率是固定的，CADisplayLink在正常情况下会在每次刷新结束都被调用，精确度相当高。
 NSTimer的精确度就显得低了点，比如NSTimer的触发时间到的时候，runloop如果在阻塞状态，触发时间就会推迟到下一个runloop周期。并且 NSTimer新增了tolerance属性，让用户可以设置可以容忍的触发的时间的延迟范围。
 CADisplayLink使用场合相对专一，适合做UI的不停重绘，比如自定义动画引擎或者视频播放的渲染。NSTimer的使用范围要广泛的多，各种需要单次或者循环定时处理的任务都可以使用。在UI相关的动画或者显示内容使用 CADisplayLink比起用NSTimer的好处就是我们不需要在格外关心屏幕的刷新频率了，因为它本身就是跟屏幕刷新同步的。
 
 给非UI对象添加动画效果
 我们知道动画效果就是一个属性的线性变化，比如UIView 动画的 EasyIn EasyOut 。通过数值按照不同速率的变化我们能生成更接近真实世界的动画效果。我们也可以利用这个特性来使一些其他属性按照我们期望的曲线变化。比如当播放视频时关掉视频的声音我可以通过CADisplayLink来实现一个 EasyOut的渐出效果：先快速的降低音量，在慢慢的渐变到静音。
 
 通常来讲：iOS设备的刷新频率事60HZ也就是每秒60次。那么每一次刷新的时间就是1/60秒 大概16.7毫秒。当我们的frameInterval值为1的时候我们需要保证的是 CADisplayLink调用的｀target｀的函数计算时间不应该大于 16.7否则就会出现严重的丢帧现象。
 在mac应用中我们使用的不是CADisplayLink而是 CVDisplayLink它是基于C接口的用起来配置有些麻烦但是用起来还是很简单的。
 
 */

#pragma mark —— CADisplayLinkTimerManager
@interface CADisplayLinkTimerManager : NSObject

@end


NS_ASSUME_NONNULL_END
