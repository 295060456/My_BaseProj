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
@property(nonatomic,strong)NSTimerManager *nsTimerManager_color;//主管线条颜色的翻滚
@property(nonatomic,strong)NSTimerManager *nsTimerManager_length;//主管线条长度的递增
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
    [NSTimerManager nsTimeStart:self.nsTimerManager_color.nsTimer
                    withRunLoop:NSRunLoop.currentRunLoop];
    
    [self simulateProgress];
}

-(void)hide{
    [NSTimerManager nsTimePause:self.nsTimerManager_color.nsTimer];
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
    self.progress += self.increment;
    [self makeTimer2];
    [NSTimerManager nsTimeStart:self.nsTimerManager_length.nsTimer
                    withRunLoop:NSRunLoop.currentRunLoop];
}

-(void)makeTimer{
    //创建方式——1
        [NSTimerManager nsTimeStart:self.nsTimerManager_color.nsTimer
                        withRunLoop:nil];
    //创建方式——2
//    [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
}

-(void)makeTimer2{
    //创建方式——1
        [NSTimerManager nsTimeStart:self.nsTimerManager_length.nsTimer
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
-(CGFloat)increment{
    if (_increment == 0) {
        _increment = 0.1;
    }return _increment;
}

-(NSTimeInterval)color_timeInterval{
    if (_color_timeInterval == 0) {
        _color_timeInterval = 0.03;
    }return _color_timeInterval;
}

-(NSTimeInterval)length_timeInterval{
    if (_length_timeInterval == 0) {
        _length_timeInterval = 1;
    }return _length_timeInterval;
}

-(NSTimeInterval)length_timeSecIntervalSinceDate{
    if (_length_timeSecIntervalSinceDate == 0) {
        _length_timeSecIntervalSinceDate = 2;
    }return _length_timeSecIntervalSinceDate;
}

-(NSTimerManager *)nsTimerManager_color{
    if (!_nsTimerManager_color) {
        _nsTimerManager_color = NSTimerManager.new;
        _nsTimerManager_color.timeInterval = self.color_timeInterval;
        _nsTimerManager_color.timerStyle = TimerStyle_clockwise;
        @weakify(self)
        [_nsTimerManager_color actionNSTimerManagerRunningBlock:^(id data) {
            NSLog(@"你好");
            @strongify(self)
            if ([data isKindOfClass:NSTimerManager.class]) {
//                NSTimerManager *timerManager = (NSTimerManager *)data;
//                timerManager.anticlockwiseTime;
                [self timerFunc];
            }
        }];
        [_nsTimerManager_color actionNSTimerManagerFinishBlock:^(id data) {
            NSLog(@"我死球了");
        }];
    }return _nsTimerManager_color;
}

-(NSTimerManager *)nsTimerManager_length{
    if (!_nsTimerManager_length) {
        _nsTimerManager_length = NSTimerManager.new;
        _nsTimerManager_length.timeInterval = self.length_timeInterval;
        _nsTimerManager_length.timeSecIntervalSinceDate = self.length_timeSecIntervalSinceDate;
        _nsTimerManager_length.timerStyle = TimerStyle_clockwise;
        @weakify(self)
        [_nsTimerManager_length actionNSTimerManagerRunningBlock:^(id data) {
            NSLog(@"你好");
            @strongify(self)
            if ([data isKindOfClass:NSTimerManager.class]) {
//                NSTimerManager *timerManager = (NSTimerManager *)data;
//                timerManager.anticlockwiseTime;
                [self simulateProgress];
            }
        }];
        [_nsTimerManager_length actionNSTimerManagerFinishBlock:^(id data) {
            NSLog(@"我死球了");
        }];
    }return _nsTimerManager_length;
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
