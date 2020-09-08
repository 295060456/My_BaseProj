//
//  StartOrPauseBtn.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "StartOrPauseBtn.h"

@interface StartOrPauseBtn ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UITapGestureRecognizer *tapGR;
@property(nonatomic,copy)MKDataBlock tapGRHandleSingleFingerActionBlock;
@property(nonatomic,copy)MKDataBlock startOrPauseBtnBlock;
@property(nonatomic,copy)MKDataBlock finishWorkBlock;

//@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;
//@property(nonatomic,copy)MKDataBlock longPressGRActionBlock;

@end

@implementation StartOrPauseBtn

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        [self addGestureRecognizer:self.tapGR];
//        [self addGestureRecognizer:self.longPressGR];
        
        self.userInteractionEnabled = YES;

        self.currentTime = 0.0f;
        self.isClickStartOrPauseBtn = NO;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.progressView.alpha = 1;
}

-(void)makeTimer{
    //创建方式——1
    [NSTimerManager nsTimeStart:self.nsTimerManager.nsTimer
                    withRunLoop:NSRunLoop.currentRunLoop];
    //创建方式——2
//    [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
}

-(void)mytimerAction{
    self.currentTime += 1;
    self.progressView.progressLabel.placeStr = @"录制中";
    NSLog(@"KKKS = %f",self.currentTime);
    self.progressView.progress = self.currentTime / self.time;
}

-(NSTimerManager *)nsTimerManager{
    if (!_nsTimerManager) {
        _nsTimerManager = NSTimerManager.new;
        _nsTimerManager.timerStyle = TimerStyle_anticlockwise;
        _nsTimerManager.anticlockwiseTime = self.time;
        @weakify(self)
        [_nsTimerManager actionNSTimerManagerRunningBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSTimerManager.class]) {
                [self mytimerAction];
            }
        }];
        [_nsTimerManager actionNSTimerManagerFinishBlock:^(id data) {
            @strongify(self)
            [MBProgressHUD wj_showPlainText:@"录制结束"
                                       view:getMainWindow()];
            if (self.finishWorkBlock) {
                self.finishWorkBlock(@1);
            }
            [self reset];
        }];
    }return _nsTimerManager;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    NSLog(@"");
//    @weakify(self)
    //点击放大再缩小，动效
    [UIView addViewAnimation:self
             completionBlock:^(id data) {
//        @strongify(self)
    }];
}

-(void)reset{
    
    self.progressView.progressLabel.placeStr = @"录制";
    
    self.backgroundColor = kBlueColor;
    
    self.currentTime = 0;
    self.progressView.increaseFromLast = NO;
    self.progressView.progress = 0;
    self.progressView.startAngle = 0.1;
    self.progressView.startAngle = 0;
    self.progressView.increaseFromLast = YES;
}

#pragma mark —— 开始录制
-(void)vedioShoottingOn{
    [self makeTimer];
    [MBProgressHUD wj_showPlainText:@"开始录制"
                               view:getMainWindow()];
    self.progressView.progressLabel.placeStr = @"录制中";
    self.backgroundColor = kRedColor;
    _progressView.pathFillColor = kBlueColor;
}
#pragma mark —— 结束录制
-(void)vedioShoottingEnd{}
#pragma mark —— 暂停录制
-(void)vedioShoottingSuspend{
    [NSTimerManager nsTimePause:self.nsTimerManager.nsTimer];
    
    self.progressView.progressLabel.placeStr = @"已暂停";
    self.backgroundColor = KGreenColor;
    _progressView.pathFillColor = kRedColor;
}
#pragma mark —— 继续录制
-(void)vedioShoottingContinue{
    [MBProgressHUD wj_showPlainText:@"继续录制"
                               view:getMainWindow()];
    [NSTimerManager nsTimecontinue:self.nsTimerManager.nsTimer];
    self.progressView.progressLabel.placeStr = @"录制中";
    self.backgroundColor = kRedColor;
    _progressView.pathFillColor = kBlueColor;
}
#pragma mark —— 取消录制
-(void)vedioShoottingOff{}
//只管状态
-(void)tapGRUI:(BOOL)isClick{
    self.isClickStartOrPauseBtn = isClick;//外界调用的时候，会不一致，这里进行补齐
    if (isClick) {
        if (!_nsTimerManager.nsTimer) {
            //启动 开始录制
            self.shottingStatus = ShottingStatus_on;
            if (!self.isCountDown) {
                [self vedioShoottingOn];
            }
        }else{
            //继续录制
            self.shottingStatus = ShottingStatus_continue;
            if (!self.isCountDown) {
                [self vedioShoottingContinue];
            }
        }
    }else{
        //暂停录制
        self.shottingStatus = ShottingStatus_suspend;
        [self vedioShoottingSuspend];
    }
}
#pragma mark —— UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
#pragma mark —— 点击事件
-(void)tapGRHandleSingleFingerAction:(UITapGestureRecognizer *_Nullable)sender{
    self.isClickStartOrPauseBtn = !self.isClickStartOrPauseBtn;
    [self tapGRUI:self.isClickStartOrPauseBtn];
    //在外面启用GPUImage事件
    if (self.startOrPauseBtnBlock) {
        self.startOrPauseBtnBlock(self);
    }
}

-(void)actionTapGRHandleSingleFingerBlock:(MKDataBlock)tapGRHandleSingleFingerActionBlock{
    if (self.tapGRHandleSingleFingerActionBlock) {
        self.tapGRHandleSingleFingerActionBlock(@1);
    }
}

-(void)actionFinishWorkBlock:(MKDataBlock)finishWorkBlock{
    self.finishWorkBlock = finishWorkBlock;
}

-(void)actionStartOrPauseBtnBlock:(MKDataBlock)startOrPauseBtnBlock{
    self.startOrPauseBtnBlock = startOrPauseBtnBlock;
}
#pragma mark —— lazyLoad
-(UITapGestureRecognizer *)tapGR{//单击一下
    if (!_tapGR) {
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(tapGRHandleSingleFingerAction:)];
        _tapGR.numberOfTouchesRequired = 1; //手指数
        _tapGR.numberOfTapsRequired = 1; //tap次数
        _tapGR.delegate = self;
    }return _tapGR;
}

-(ZZCircleProgress *)progressView{
    if (!_progressView) {
        _progressView = [[ZZCircleProgress alloc] initWithFrame:CGRectZero
                                                  pathBackColor:KYellowColor//原本的色彩
                                                  pathFillColor:kBlueColor//进度条略过的色彩
                                                     startAngle:0
                                                    strokeWidth:3
                                                      cycleTime:self.time
                                                     safetyTime:self.safetyTime];
        _progressView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        _progressView.userInteractionEnabled = YES;
        _progressView.increaseFromLast = YES;//是否从头开始
        _progressView.progressLabel.text = @"录制";
        _progressView.showProgressText = YES;
        [self addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _progressView;
}

-(CGFloat)time{
    if (_time == 0.0f) {
        _time = 100.0f;//默认值
    }return _time;
}

-(CGFloat)safetyTime{
    if (_safetyTime == 0.0f) {
        _safetyTime = 30.0f;
    }return _safetyTime;
}

-(void)setIsCountDown:(BOOL)isCountDown{
    _isCountDown = isCountDown;
}

//-(UILongPressGestureRecognizer *)longPressGR{//长按
//    if (!_longPressGR) {
//        _longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self
//                                                                     action:@selector(longPressGRAction:)];
//        _longPressGR.minimumPressDuration = 2;//最小长按时间
//    }return _longPressGR;
//}

//-(void)longPressGRAction:(UILongPressGestureRecognizer *)sender{
//    NSLog(@"1234");
//}

//-(void)actionLongPressGRBlock:(MKDataBlock)longPressGRActionBlock{
//    if (self.longPressGRActionBlock) {
//        self.longPressGRActionBlock(@1);
//    }
//}


@end
