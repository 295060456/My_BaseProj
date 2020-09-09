//
//  WGradientProgress.m
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import "WGradientProgress.h"

@interface WGradientProgress ()

@property(nonatomic,strong)CALayer *roadLayer;//跑道 即将运行的轨迹
@property(nonatomic,strong)CALayer *fenceLayer;//栅栏
@property(nonatomic,strong)CAGradientLayer *gradLayer;//通过改变layer的宽度来实现进度 运动员
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
    if (self.isShowRoad) {
        self.roadLayer.hidden = NO;
    }
    
    self.gradLayer.hidden = NO;
    
    if (self.isShowFence) {
        self.fenceLayer.hidden = NO;
    }
    
    [NSTimerManager nsTimeStart:self.nsTimerManager_color.nsTimer
                    withRunLoop:NSRunLoop.currentRunLoop];
    
    [self simulateProgress];
}

-(void)hide{
    [NSTimerManager nsTimePause:self.nsTimerManager_color.nsTimer];
    if ([self superview]) {
        [self removeFromSuperview];
    }
}

-(void)setProgress:(CGFloat)progress{
    if (progress < 0) {
        progress = 0;
    }
    if (progress > 1) {
        progress = 1;
    }
    _progress = progress;
    self.gradLayer.frame = CGRectMake(0,
                                      0,
                                      progress * self.width,
                                      self.mj_h);
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
    self.gradLayer.colors = copyArray;
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
            UIColor *color = [UIColor colorWithHue:1.0 * deg / 360.0
                                        saturation:1.0
                                        brightness:1.0
                                             alpha:1.0];
            [_colors addObject:(id)color.CGColor];
        }
    }return _colors;;
}

-(CAGradientLayer *)gradLayer{
    if (!_gradLayer) {
        _gradLayer = CAGradientLayer.layer;
        _gradLayer.frame = CGRectZero;
        _gradLayer.borderWidth = 1;
        _gradLayer.startPoint = CGPointMake(0, 0);
        _gradLayer.endPoint = CGPointMake(1, 1);
        _gradLayer.colors = [NSArray arrayWithArray:self.colors];
        [self.layer addSublayer:_gradLayer];
    }return _gradLayer;
}

-(CALayer *)roadLayer{
    if (!_roadLayer) {
        _roadLayer = CALayer.layer;
        _roadLayer.frame = self.bounds;
        _roadLayer.backgroundColor = KLightGrayColor.CGColor;
        [self.layer addSublayer:_roadLayer];
    }return _roadLayer;
}

-(CALayer *)fenceLayer{
    if (!_fenceLayer) {
        _fenceLayer = CALayer.layer;
        _fenceLayer.frame = CGRectMake(self.fenceLayer_x,
                                       0,
                                       self.fenceLayer_width,
                                       self.mj_h);
        _fenceLayer.backgroundColor = self.fenceLayerColor.CGColor;
        [self.gradLayer addSublayer:_fenceLayer];
    }return _fenceLayer;;
}

-(CGFloat)fenceLayer_x{
    if (_fenceLayer_x == 0) {
        _fenceLayer_x = self.mj_w * 0.3;
    }return _fenceLayer_x;
}

-(CGFloat)fenceLayer_width{
    if (_fenceLayer_width == 0) {
        _fenceLayer_width = 5;
    }return _fenceLayer_width;
}

-(UIColor *)fenceLayerColor{
    if (!_fenceLayerColor) {
        _fenceLayerColor = RandomColor;
    }return _fenceLayerColor;
}

@end
