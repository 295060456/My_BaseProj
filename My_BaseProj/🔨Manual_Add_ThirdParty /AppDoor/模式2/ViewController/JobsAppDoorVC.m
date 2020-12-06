//
//  JobsAppDoor.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorVC.h"

#define JobsAppDoorContentViewLeftHeight  MAINSCREEN_HEIGHT / 1.7 // 竖形按钮在左边
#define JobsAppDoorContentViewRightHeight  MAINSCREEN_HEIGHT / 3 // 竖形按钮在右边

typedef NS_ENUM(NSInteger, CurrentPage) {
    CurrentPage_login = 0,
    CurrentPage_register
};

@interface JobsAppDoorVC ()

@property(nonatomic,strong)UBLLogoContentView *logoContentView;
@property(nonatomic,strong)JobsAppDoorContentView *jobsAppDoorContentView;
@property(nonatomic,strong)UIButton *customerServiceBtn;
//只要有一个TF还在编辑那么就是在编辑
@property(nonatomic,assign)BOOL loginDoorInputEditing;
@property(nonatomic,assign)BOOL registerDoorInputEditing;
@property(nonatomic,assign)CGFloat logoContentViewY;//初始高度
@property(nonatomic,assign)CGFloat jobsAppDoorContentViewY;//初始高度
@property(nonatomic,assign)CGFloat customerServiceBtnY;//初始高度
@property(nonatomic,assign)CurrentPage currentPage;//当前的页面位置
@property(nonatomic,assign)NSInteger currentActivateTFIndex;//当前被激活的输入框的序列号
@property(nonatomic,assign)NSInteger lastTimeActivateTFIndex;//上一时刻被激活的输入框的序列号

@end

@implementation JobsAppDoorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = CurrentPage_login;//默认页面是登录
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

    NSMutableArray * (^currentPageDataMutArr)(CurrentPage currentPage) = ^(CurrentPage currentPage){
        if (currentPage == CurrentPage_login) {
            return self.jobsAppDoorContentView.loginDoorInputViewBaseStyleMutArr;
        }else{
            return self.jobsAppDoorContentView.registerDoorInputViewBaseStyleMutArr;
        }
    };
    
    NSInteger index = 0;
    for (DoorInputViewBaseStyle_3 *inputView in currentPageDataMutArr(self.currentPage)) {
        Ivar ivar = class_getInstanceVariable([DoorInputViewBaseStyle_3 class], "_tf");//必须是下划线接属性
        ZYTextField *tf = object_getIvar(inputView, ivar);
        self.loginDoorInputEditing |= tf.editing;
        if (tf.editing) {
            NSLog(@"FFF = %ld",index);//当前被激活的idx
            self.lastTimeActivateTFIndex = self.currentActivateTFIndex;
            self.currentActivateTFIndex = index;//赋予新值。因为同一时刻，textField有且只有一个被激活
        }
        index += 1;
    }
    
    if (!self.loginDoorInputEditing) {
        NSLog(@"没有在编辑");
        self.jobsAppDoorContentView.mj_y = self.jobsAppDoorContentViewY;
        self.logoContentView.mj_y = self.logoContentViewY;
        self.customerServiceBtn.mj_y = self.customerServiceBtnY;
    }else{
        NSLog(@"在编辑");
        NSInteger offsetIdx = self.currentActivateTFIndex - self.lastTimeActivateTFIndex;
        self.jobsAppDoorContentView.mj_y -= 40 * (offsetIdx + 0);
        self.logoContentView.mj_y -= 40 * (offsetIdx + 0);
        self.customerServiceBtn.mj_y -= 40 * (offsetIdx + 0);
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
        //监测输入字符回调 和 激活的textField 和 toRegisterBtn点击事件
        [_jobsAppDoorContentView actionBlockJobsAppDoorContentView:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if (btn.selected) {//竖形按钮在左边
                    self.currentPage = CurrentPage_register;//注册页面
                    self->_jobsAppDoorContentView.frame = CGRectMake(20,
                                                                     MAINSCREEN_HEIGHT / 4,
                                                                     MAINSCREEN_WIDTH - 40,
                                                                     JobsAppDoorContentViewLeftHeight);
                    
                    btn.frame = CGRectMake(0,
                                            0,
                                            64,
                                            self->_jobsAppDoorContentView.mj_h);
                }else{//竖形按钮在右边
                    self.currentPage = CurrentPage_login;//登录页面
                    self->_jobsAppDoorContentView.frame = CGRectMake(20,
                                                                     MAINSCREEN_HEIGHT / 4,
                                                                     MAINSCREEN_WIDTH - 40,
                                                                     JobsAppDoorContentViewRightHeight);
                    btn.frame = CGRectMake(self->_jobsAppDoorContentView.mj_w - 64,
                                            0,
                                            64,
                                            self->_jobsAppDoorContentView.mj_h);
                }
                self.customerServiceBtn.top = self.jobsAppDoorContentView.top + self.jobsAppDoorContentView.height + 20;
                self.customerServiceBtnY =  self.customerServiceBtn.mj_y;
            }else if ([data isKindOfClass:ZYTextField.class]){
                
            }else if ([data isKindOfClass:NSString.class]){
                
            }else{}
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
