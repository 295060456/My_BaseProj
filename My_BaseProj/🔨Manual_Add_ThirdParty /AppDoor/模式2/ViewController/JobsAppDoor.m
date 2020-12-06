//
//  JobsAppDoor.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoor.h"

#define JobsAppDoorContentViewLeftHeight  MAINSCREEN_HEIGHT / 1.7 // 竖形按钮在左边
#define JobsAppDoorContentViewRightHeight  MAINSCREEN_HEIGHT / 3 // 竖形按钮在右边

@interface JobsAppDoor ()

@property(nonatomic,strong)UBLLogoContentView *logoContentView;
@property(nonatomic,strong)JobsAppDoorContentView *jobsAppDoorContentView;
@property(nonatomic,strong)UIButton *customerServiceBtn;
//只要有一个TF还在编辑那么就是在编辑
@property(nonatomic,assign)BOOL loginDoorInputEditing;
@property(nonatomic,assign)BOOL registerDoorInputEditing;
@property(nonatomic,assign)CGFloat logoContentViewY;//初始高度
@property(nonatomic,assign)CGFloat jobsAppDoorContentViewY;//初始高度
@property(nonatomic,assign)CGFloat customerServiceBtnY;//初始高度

@end

@implementation JobsAppDoor

- (void)viewDidLoad {
    [super viewDidLoad];
    [self keyboard];
    self.view.backgroundColor = kBlueColor;
//    self.setupNavigationBarHidden = YES;
    [UIView animationAlert:self.jobsAppDoorContentView];
    [UIView animationAlert:self.logoContentView];
    [UIView animationAlert:self.customerServiceBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //无效？？？
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:true];
}

-(void)keyboard{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}
//键盘 弹出 和 收回 走这个方法
-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
//    NSDictionary *userInfo = notification.userInfo;
//    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
    
    long index = 0;
    for (DoorInputViewBaseStyle_3 *inputView in self.jobsAppDoorContentView.loginDoorInputViewBaseStyleMutArr) {
        Ivar ivar = class_getInstanceVariable([DoorInputViewBaseStyle_3 class], "_tf");//必须是下划线接属性
        ZYTextField *tf = object_getIvar(inputView, ivar);
        self.loginDoorInputEditing |= tf.editing;
        if (tf.editing) {
            NSLog(@"FFF = %ld",index);
            self.jobsAppDoorContentView.mj_y -= 40 * (index + 1);
            self.logoContentView.mj_y -= 40 * (index + 1);
            self.customerServiceBtn.mj_y -= 40 * (index + 1);
        }
        index += 1;
    }
    
    if (!self.loginDoorInputEditing) {
        NSLog(@"");
        self.jobsAppDoorContentView.mj_y = self.jobsAppDoorContentViewY;
        self.logoContentView.mj_y = self.logoContentViewY;
        self.customerServiceBtn.mj_y = self.customerServiceBtnY;
    }
    
    self.loginDoorInputEditing = NO;//置空状态
}
#pragma mark —— lazyLoad
-(UBLLogoContentView *)logoContentView{
    if (!_logoContentView) {
        _logoContentView = UBLLogoContentView.new;
        [self.view addSubview:_logoContentView];
        [_logoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 50));
            make.bottom.equalTo(self.jobsAppDoorContentView.mas_top).offset(-50);
            make.centerX.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        self.logoContentViewY = self.logoContentView.mj_y;
    }return _logoContentView;
}

-(JobsAppDoorContentView *)jobsAppDoorContentView{
    if (!_jobsAppDoorContentView) {
        _jobsAppDoorContentView = JobsAppDoorContentView.new;
        
        JobsAppDoorContentViewModel *appDoorContentViewModel = JobsAppDoorContentViewModel.new;
        appDoorContentViewModel.contentViewLeftHeight = JobsAppDoorContentViewLeftHeight;
        appDoorContentViewModel.contentViewRightHeight = JobsAppDoorContentViewRightHeight;
        
        [_jobsAppDoorContentView richElementsInViewWithModel:appDoorContentViewModel];
        @weakify(self)
        [_jobsAppDoorContentView actionBlockJobsAppDoorContentView:^(UIButton *data) {
            @strongify(self)
            if (data.selected) {//竖形按钮在左边
                self->_jobsAppDoorContentView.frame = CGRectMake(20,
                                                                 MAINSCREEN_HEIGHT / 4,
                                                                 MAINSCREEN_WIDTH - 40,
                                                                 JobsAppDoorContentViewLeftHeight);
                
                data.frame = CGRectMake(0,
                                        0,
                                        64,
                                        self->_jobsAppDoorContentView.mj_h);
            }else{//竖形按钮在右边
                self->_jobsAppDoorContentView.frame = CGRectMake(20,
                                                                 MAINSCREEN_HEIGHT / 4,
                                                                 MAINSCREEN_WIDTH - 40,
                                                                 JobsAppDoorContentViewRightHeight);
                data.frame = CGRectMake(self->_jobsAppDoorContentView.mj_w - 64,
                                        0,
                                        64,
                                        self->_jobsAppDoorContentView.mj_h);
            }
            
            self.customerServiceBtn.top = self.jobsAppDoorContentView.top + self.jobsAppDoorContentView.height + 20;
        }];
        [self.view addSubview:_jobsAppDoorContentView];
        _jobsAppDoorContentView.frame = CGRectMake(20,
                                                   MAINSCREEN_HEIGHT / 4,
                                                   MAINSCREEN_WIDTH - 40,
                                                   JobsAppDoorContentViewRightHeight);
        self.jobsAppDoorContentViewY = _jobsAppDoorContentView.mj_y;
        [UIView cornerCutToCircleWithView:_jobsAppDoorContentView
                          AndCornerRadius:8];
    }return _jobsAppDoorContentView;
}

-(UIButton *)customerServiceBtn{
    if (!_customerServiceBtn) {
        _customerServiceBtn = UIButton.new;
        [_customerServiceBtn setTitle:@"人工客服"
                             forState:UIControlStateNormal];
        [_customerServiceBtn setImage:KIMG(@"客服")
                             forState:UIControlStateNormal];
        [self.view addSubview:_customerServiceBtn];
        _customerServiceBtn.size = CGSizeMake(MAINSCREEN_WIDTH / 3, MAINSCREEN_WIDTH / 9);
        _customerServiceBtn.centerX = self.view.centerX;
        _customerServiceBtn.top = self.jobsAppDoorContentView.top + self.jobsAppDoorContentView.height + 20;
        self.customerServiceBtnY = _customerServiceBtn.mj_y;
        @weakify(self)
        [[_customerServiceBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            //点击事件
            @strongify(self)
        }];
        [UIView cornerCutToCircleWithView:_customerServiceBtn
                          AndCornerRadius:_customerServiceBtn.mj_h / 2];
        [UIView colourToLayerOfView:_customerServiceBtn
                         WithColour:kWhiteColor
                     AndBorderWidth:2];
    }return _customerServiceBtn;
}

@end
