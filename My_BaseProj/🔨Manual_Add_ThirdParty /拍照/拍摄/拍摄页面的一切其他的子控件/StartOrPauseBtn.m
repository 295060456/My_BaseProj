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
//@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;
@property(nonatomic,strong)ZZCircleProgress *progressView;

@property(nonatomic,copy)MKDataBlock tapGRHandleSingleFingerActionBlock;
//@property(nonatomic,copy)MKDataBlock longPressGRActionBlock;
@property(nonatomic,assign)BOOL isClickStartOrPauseBtn;
@property(nonatomic,copy)MKDataBlock startOrPauseBtnBlock;

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
    [UIView addViewAnimation:self
             completionBlock:^(id data) {
//        @strongify(self)
        
    }];
}
#pragma mark —— UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
#pragma mark —— 点击事件
-(void)tapGRHandleSingleFingerAction:(UITapGestureRecognizer *)sender{
    self.isClickStartOrPauseBtn = !self.isClickStartOrPauseBtn;
    if (self.isClickStartOrPauseBtn) {
        if (!_mytimer) {
            //启动 开始录制
            self.shottingStatus = ShottingStatus_on;
            [self.mytimer fire];
            self.backgroundColor = kRedColor;
            [MBProgressHUD wj_showPlainText:@"开始录制"
                                       view:nil];
        }else{
            //继续录制
            self.shottingStatus = ShottingStatus_continue;
            [MBProgressHUD wj_showPlainText:@"继续录制"
                                       view:nil];
            [self.mytimer setFireDate:[NSDate date]];
            self.backgroundColor = kRedColor;
        }
    }else{
        //暂停录制
        self.shottingStatus = ShottingStatus_suspend;
#warning 这里有一个明显的UI Bug
        [self.mytimer setFireDate:[NSDate distantFuture]];
        self.progressView.progressLabel.text = @"暂停";
        self.backgroundColor = kBlueColor;
    }
    if (self.startOrPauseBtnBlock) {
        self.startOrPauseBtnBlock(@(self.shottingStatus));
    }
}

//-(void)longPressGRAction:(UILongPressGestureRecognizer *)sender{
//    NSLog(@"1234");
//}
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

//-(UILongPressGestureRecognizer *)longPressGR{//长按
//    if (!_longPressGR) {
//        _longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self
//                                                                     action:@selector(longPressGRAction:)];
//        _longPressGR.minimumPressDuration = 2;//最小长按时间
//    }return _longPressGR;
//}

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

@end
