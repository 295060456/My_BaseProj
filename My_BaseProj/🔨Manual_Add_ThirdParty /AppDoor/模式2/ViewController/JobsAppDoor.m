//
//  JobsAppDoor.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoor.h"
#import "JobsAppDoorContentView.h"
#import "UBLLogoContentView.h"

#define JobsAppDoorContentViewLeftHeight  MAINSCREEN_HEIGHT / 2 // 竖形按钮在左边
#define JobsAppDoorContentViewRightHeight  MAINSCREEN_HEIGHT / 3 // 竖形按钮在右边

@interface JobsAppDoor ()

@property(nonatomic,strong)JobsAppDoorContentView *jobsAppDoorContentView;
@property(nonatomic,strong)UBLLogoContentView *logoContentView;
@property(nonatomic,strong)UIButton *customerServiceBtn;


@end

@implementation JobsAppDoor

- (void)viewDidLoad {
    [super viewDidLoad];
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
    }return _logoContentView;
}

-(JobsAppDoorContentView *)jobsAppDoorContentView{
    if (!_jobsAppDoorContentView) {
        _jobsAppDoorContentView = JobsAppDoorContentView.new;
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
