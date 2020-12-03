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

@interface JobsAppDoor ()

//
@property(nonatomic,strong)JobsAppDoorContentView *jobsAppDoorContentView;
@property(nonatomic,strong,nullable)UBLLogoContentView *logoContentView;

@end

@implementation JobsAppDoor

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlueColor;
//    self.setupNavigationBarHidden = YES;
    [UIView animationAlert:self.jobsAppDoorContentView];
    [UIView animationAlert:self.logoContentView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //无效？？？
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:true];
}
#pragma mark —— lazyLoad
-(JobsAppDoorContentView *)jobsAppDoorContentView{
    if (!_jobsAppDoorContentView) {
        _jobsAppDoorContentView = JobsAppDoorContentView.new;
        @weakify(self)
        [_jobsAppDoorContentView actionBlockJobsAppDoorContentView:^(UIButton *data) {
            @strongify(self)
            if (data.selected) {
                self->_jobsAppDoorContentView.frame = CGRectMake(20,
                                                                 MAINSCREEN_HEIGHT / 4,
                                                                 MAINSCREEN_WIDTH - 40,
                                                                 MAINSCREEN_HEIGHT / 3);
                
                data.frame = CGRectMake(0,
                                        0,
                                        64,
                                        self->_jobsAppDoorContentView.mj_h);
            }else{
                self->_jobsAppDoorContentView.frame = CGRectMake(20,
                                                                 MAINSCREEN_HEIGHT / 4,
                                                                 MAINSCREEN_WIDTH - 40,
                                                                 MAINSCREEN_HEIGHT / 2);
                data.frame = CGRectMake(self->_jobsAppDoorContentView.mj_w - 64,
                                        0,
                                        64,
                                        self->_jobsAppDoorContentView.mj_h);
            }
        }];
        [self.view addSubview:_jobsAppDoorContentView];
        _jobsAppDoorContentView.frame = CGRectMake(20,
                                                   MAINSCREEN_HEIGHT / 4,
                                                   MAINSCREEN_WIDTH - 40,
                                                   MAINSCREEN_HEIGHT / 2);
        [UIView cornerCutToCircleWithView:_jobsAppDoorContentView
                          AndCornerRadius:8];
    }return _jobsAppDoorContentView;
}

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

@end
