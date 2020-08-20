//
//  CustomerAVPlayer.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/18.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CustomerAVPlayerView.h"
#import "CustomerAVPlayerView+UIGestureRecognizerDelegate.h"

@interface CustomerAVPlayerView ()<UIGestureRecognizerDelegate>{
    
}

@property(nonatomic,copy)TwoDataBlock customerActionAVPlayerBlock;
@property(nonatomic,copy)NoResultBlock customerErrorAVPlayerBlock;

@property(nonatomic,weak)UIViewController *vcer;//这个属性掌管悬浮效果，具体实现见  @interface UIView (SuspendView)
@property(nonatomic,strong)RepeatPlayer *repeatPlayer;
@property(nonatomic,strong)UITapGestureRecognizer *tapGR;
@property(nonatomic,strong)NSURL *movieURL;
@property(nonatomic,assign)BOOL isTap;

@end

@implementation CustomerAVPlayerView

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithURL:(NSURL *)movieURL
                 suspendVC:(UIViewController *)suspendVC{
    if (self = [super init]) {
        if ([NSString isNullString:movieURL.absoluteString]) {
            if (self.customerErrorAVPlayerBlock) {
                self.customerErrorAVPlayerBlock();
            }
        }else{
            self.movieURL = movieURL;
        }
        self.vcer = suspendVC;
        self.isSuspend = NO;//默认不开启悬浮效果
        [self addGestureRecognizer:self.tapGR];
        self.isTap = NO;
        self.backgroundColor = [UIColor redColor];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.isSuspend) {
        //开启悬浮效果
        self.vc = self.vcer;
        self.panRcognize.enabled = YES;
    }else{
        self.vc = nil;
    }
    [self.repeatPlayer play];
}

-(void)actionCustomerAVPlayerBlock:(TwoDataBlock)customerActionAVPlayerBlock{
    self.customerActionAVPlayerBlock = customerActionAVPlayerBlock;
}

-(void)errorCustomerAVPlayerBlock:(NoResultBlock)customerErrorAVPlayerBlock{
    self.customerErrorAVPlayerBlock = customerErrorAVPlayerBlock;
}

-(void)play{
    [self.repeatPlayer play];
}

-(void)pause{
    [self.repeatPlayer pause];
}

-(void)tapGRClickEvent:(UITapGestureRecognizer *)sender{
    if (self.customerActionAVPlayerBlock) {
        self.customerActionAVPlayerBlock(@(self.isTap),sender);
    }
    self.isTap = !self.isTap;
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    if (@available(iOS 11.0, *)) {
        [p seekToTime:kCMTimeZero
    completionHandler:^(BOOL finished) {
            
        }];
    }else{
        [p seekToTime:kCMTimeZero];
    }
}

-(void)setIsSuspend:(BOOL)isSuspend{
    _isSuspend = isSuspend;
    if (_isSuspend) {
        self.vc = self.vcer;//开启悬浮效果
    }else{
        self.vc = nil;
    }
}
#pragma mark —— lazyLoad
-(RepeatPlayer *)repeatPlayer{
    if (!_repeatPlayer) {
        _repeatPlayer = [[RepeatPlayer alloc] initWithSrc:self.movieURL];

        //self.repeatPlayer.autoPlay = true;
        [_repeatPlayer showInView:self];
    }return _repeatPlayer;
}

-(UITapGestureRecognizer *)tapGR{
    if (!_tapGR) {
        _tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                        action:@selector(tapGRClickEvent:)];
        _tapGR.numberOfTouchesRequired = 1;//手指数
        _tapGR.numberOfTapsRequired = 1;//tap次数
        _tapGR.delegate = self;
    }return _tapGR;
}



@end
