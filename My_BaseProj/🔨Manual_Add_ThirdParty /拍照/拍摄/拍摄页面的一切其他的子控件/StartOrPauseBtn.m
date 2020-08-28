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
@property(nonatomic,assign)BOOL isClickStartOrPauseBtn;
@property(nonatomic,copy)MKDataBlock tapGRHandleSingleFingerActionBlock;
@property(nonatomic,copy)MKDataBlock startOrPauseBtnBlock;

//@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;
//@property(nonatomic,copy)MKDataBlock longPressGRActionBlock;

@end

@implementation StartOrPauseBtn

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [_mytimer invalidate];
    //别忘了把定时器置为nil,否则定时器依然没有释放掉的
    _mytimer = nil;
}

-(instancetype)init{
    if (self = [super init]) {
        [self addGestureRecognizer:self.tapGR];
//        [self addGestureRecognizer:self.longPressGR];
        
        self.userInteractionEnabled = YES;
        self.progressView.alpha = 1;
        self.currentTime = 0.0f;
        self.isClickStartOrPauseBtn = NO;
    }return self;
}

-(void)mytimerAction{
    self.currentTime += 1;
    NSLog(@"KKK = %f",self.currentTime);
    self.progressView.progress = self.currentTime / self.time;
    if (self.progressView.progress == 1.0) {
        [self.mytimer setFireDate:[NSDate distantFuture]];
        [MBProgressHUD wj_showPlainText:@"录制结束" view:getMainWindow()];
    }
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
    [_mytimer invalidate];
    _mytimer = nil;
    self.progressView.startAngle = 0;
}

-(void)tapGRUI:(BOOL)isClick{
    if (isClick) {
        if (!_mytimer) {
            //启动 开始录制
            self.shottingStatus = ShottingStatus_on;
            self.progressView.progressLabel.placeStr = @"录制中";
            [self.mytimer fire];
            self.backgroundColor = kRedColor;
            [MBProgressHUD wj_showPlainText:@"开始录制"
                                       view:nil];
        }else{
            //继续录制
            self.shottingStatus = ShottingStatus_continue;
            self.progressView.progressLabel.placeStr = @"录制中";
            [MBProgressHUD wj_showPlainText:@"继续录制"
                                       view:nil];
            [self.mytimer setFireDate:[NSDate date]];
            self.backgroundColor = kRedColor;
        }
    }else{
        //暂停录制
        self.shottingStatus = ShottingStatus_suspend;
        [self.mytimer setFireDate:[NSDate distantFuture]];
        self.progressView.progressLabel.placeStr = @"已暂停";
        self.backgroundColor = kBlueColor;
    }
}

-(void)actionTapGRHandleSingleFingerBlock:(MKDataBlock)tapGRHandleSingleFingerActionBlock{
    if (self.tapGRHandleSingleFingerActionBlock) {
        self.tapGRHandleSingleFingerActionBlock(@1);
    }
}

//-(void)actionLongPressGRBlock:(MKDataBlock)longPressGRActionBlock{
//    if (self.longPressGRActionBlock) {
//        self.longPressGRActionBlock(@1);
//    }
//}

-(void)actionStartOrPauseBtnBlock:(MKDataBlock)startOrPauseBtnBlock{
    self.startOrPauseBtnBlock = startOrPauseBtnBlock;
}
#pragma mark —— UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
#pragma mark —— 点击事件
-(void)tapGRHandleSingleFingerAction:(UITapGestureRecognizer *)sender{
    self.isClickStartOrPauseBtn = !self.isClickStartOrPauseBtn;
    //UI部分
    [self tapGRUI:self.isClickStartOrPauseBtn];
    //外面启用GPUImage事件
    if (self.startOrPauseBtnBlock) {
        self.startOrPauseBtnBlock(@(self.shottingStatus));
    }
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
                                                  pathBackColor:[UIColor grayColor]
                                                  pathFillColor:[UIColor greenColor]
                                                     startAngle:0
                                                    strokeWidth:3];
        _progressView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        _progressView.userInteractionEnabled = YES;
        _progressView.pathFillColor = [UIColor redColor];
        _progressView.increaseFromLast = YES;//是否从头开始
        _progressView.progressLabel.text = @"录制";
        _progressView.showProgressText = YES;
        [self addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _progressView;
}

-(NSTimer *)mytimer{
    if (!_mytimer) {
        _mytimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(mytimerAction)
                                                  userInfo:nil
                                                   repeats:YES];
        
    }return _mytimer;
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

@end
