//
//  WGradientProgress.m
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import "WGradientProgress.h"

@interface WGradientProgress ()

@property(nonatomic,strong)CAGradientLayer *gradLayer;
@property(nonatomic,strong)CALayer *mask;
@property(nonatomic,strong)UIView *parentView;
@property(nonatomic,strong)NSTimerManager *nsTimerManager;
@property(nonatomic,strong)NSMutableArray *colors;

@end

@implementation WGradientProgress

-(instancetype)init{
    if (self = [super init]) {
        [self makeTimer];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }return self;
}
///旋转 以适应不同方向的直线型进度条
-(void)setTransformRadians:(CGFloat)transformRadians{
    [UIView setTransform:transformRadians
                 forView:self];
}

-(void)showOnParent:(UIView *)parentView{
    self.parentView = parentView;
    self.frame = CGRectMake(parentView.mj_x,
                            parentView.mj_y,
                            parentView.mj_w,
                            1);
    [parentView addSubview:self];
     self.gradLayer.hidden = NO;
    [NSTimerManager nsTimeStart:self.nsTimerManager.nsTimer
                    withRunLoop:NSRunLoop.currentRunLoop];
    
    [self simulateProgress];
}

-(void)hide{
    [NSTimerManager nsTimePause:self.nsTimerManager.nsTimer];
    if ([self superview]) {
        [self removeFromSuperview];
    }
    self.parentView = nil;
}

-(void)setProgress:(CGFloat)progress{
    if (progress < 0) {
        progress = 0;
    }
    if (progress > 1) {
        progress = 1;
    }
    _progress = progress;
    CGFloat maskWidth = progress * self.width;
    self.mask.frame = CGRectMake(0,
                                 0,
                                 maskWidth,
                                 self.height);
}

-(void)simulateProgress{
    if (self.progress == 0) {
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = [self progress] + increment;
        [self setProgress:progress];
    }
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    @weakify(self)
    dispatch_after(popTime,
                   dispatch_get_main_queue(),
                   ^(void){
        @strongify(self)
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = self.progress + increment;
        NSLog(@"progress:%@", @(progress));
        self.progress = progress;
        if (progress < 1.0) {
            [self simulateProgress];
        }
    });
}

-(void)makeTimer{
    //创建方式——1
        [NSTimerManager nsTimeStart:self.nsTimerManager.nsTimer
                        withRunLoop:nil];
    //创建方式——2
//    [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
}

-(void)timerFunc{
    CAGradientLayer *gradLayer = self.gradLayer;
    NSMutableArray *copyArray = [NSMutableArray arrayWithArray:[gradLayer colors]];
    UIColor *lastColor = [copyArray lastObject];
    [copyArray removeLastObject];
    if (lastColor) {
        [copyArray insertObject:lastColor
                        atIndex:0];
    }
    [self.gradLayer setColors:copyArray];
}
#pragma mark —— lazyLoad
-(NSTimerManager *)nsTimerManager{
    if (!_nsTimerManager) {
        _nsTimerManager = NSTimerManager.new;
        _nsTimerManager.timeInterval = 0.03;
        _nsTimerManager.timerStyle = TimerStyle_clockwise;
        @weakify(self)
        [_nsTimerManager actionNSTimerManagerRunningBlock:^(id data) {
            NSLog(@"你好");
            @strongify(self)
            if ([data isKindOfClass:NSTimerManager.class]) {
//                NSTimerManager *timerManager = (NSTimerManager *)data;
//                timerManager.anticlockwiseTime;
                [self timerFunc];
            }
        }];
        [_nsTimerManager actionNSTimerManagerFinishBlock:^(id data) {
            NSLog(@"我死球了");
        }];
    }return _nsTimerManager;
}

-(NSMutableArray *)colors{
    if (!_colors) {
        _colors = NSMutableArray.array;
        for (NSInteger deg = 0; deg <= 360; deg += 5) {
            UIColor *color;
            color = [UIColor colorWithHue:1.0 * deg / 360.0
                               saturation:1.0
                               brightness:1.0
                                    alpha:1.0];
            [_colors addObject:(id)[color
                                    CGColor]];
        }
    }return _colors;;
}

-(CAGradientLayer *)gradLayer{
    if (!_gradLayer) {
        _gradLayer = CAGradientLayer.layer;
        _gradLayer.frame = self.bounds;
        _gradLayer.startPoint = CGPointMake(0, 0.5);
        _gradLayer.endPoint = CGPointMake(1, 0.5);
        [_gradLayer setColors:[NSArray arrayWithArray:self.colors]];
        [self.layer addSublayer:_gradLayer];
        [_gradLayer setMask:self.mask];
    }return _gradLayer;
}
//
-(CALayer *)mask{
    if (!_mask) {
        _mask = CALayer.layer;
        [_mask setFrame:CGRectMake(self.gradLayer.frame.origin.x,
                                   self.gradLayer.frame.origin.y,
                                   self.progress * self.width,
                                   self.height)];
        _mask.borderColor = [[UIColor blueColor] CGColor];
        _mask.borderWidth = 2;
        
    }return _mask;
}

@end
