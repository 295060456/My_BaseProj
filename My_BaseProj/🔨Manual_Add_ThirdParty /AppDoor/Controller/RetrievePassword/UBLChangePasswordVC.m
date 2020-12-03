//
//  UBLChangePasswordVC.m
//  UBLLive
//
//  Created by Jobs on 2020/11/26.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "UBLChangePasswordVC.h"

@interface UBLChangePasswordVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UBLScheduleView *scheduleView;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)UIButton *changePasswordSuccessTipBtn;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,assign)NSInteger schedule;
//data
@property(nonatomic,strong)__block NSString *messageAuthenticationCodeStr;//验证码
@property(nonatomic,strong)__block NSString *freshCode;//新密码
@property(nonatomic,strong)__block NSString *confreshCode;//确认新密码

@end

@implementation UBLChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    self.schedule = 2;
    self.scheduleView.alpha = 1;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.alpha = 1;
    self.nextBtn.alpha = 1;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UBLRetrievePasswordTBVCell cellHeightWithModel:nil];;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.titleMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UBLRetrievePasswordTBVCell *cell = [UBLRetrievePasswordTBVCell cellWithTableView:tableView];
    [cell richElementsInCellWithModel:@{@"title":self.titleMutArr[indexPath.row],
                                        @"placeHolder":self.placeHolderMutArr[indexPath.row]}];
    @weakify(self)
    [cell actionBlockRetrievePasswordTBVCell:^(id data) {
        @strongify(self)
        NSDictionary *dic = (NSDictionary *)data;
        if ([dic[@"TextLabelContentText"] isEqualToString:self.titleMutArr[0]]) {
            self.messageAuthenticationCodeStr = dic[@"ResString"];
        }else if ([dic[@"TextLabelContentText"] isEqualToString:self.titleMutArr[1]]){
            self.freshCode = dic[@"ResString"];
        }else if ([dic[@"TextLabelContentText"] isEqualToString:self.titleMutArr[2]]){
            self.confreshCode = dic[@"ResString"];
        }else{}
    }];
    return cell;
}
#pragma mark —— lazyLoad
-(UBLScheduleView *)scheduleView{
    if (!_scheduleView) {
        _scheduleView = UBLScheduleView.new;
        _scheduleView.schedule = self.schedule;
        _scheduleView.backgroundColor = RGBCOLOR(255, 255, 255);
        [self.view addSubview:_scheduleView];
        [_scheduleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(10);
            make.height.mas_equalTo(147);
        }];
    }return _scheduleView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = RGBCOLOR(246, 246, 246);
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = UIView.new;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scheduleView.mas_bottom).offset(10);
            make.left.right.bottom.equalTo(self.view);
        }];
    }return _tableView;
}

-(BOOL)checkInput{
    if ([NSString isNullString:self.messageAuthenticationCodeStr]) {
//        [MBProgressHUD showError:@"请填写验证码"];
        return NO;
    }
    
    if ([NSString isNullString:self.freshCode]) {
//        [MBProgressHUD showError:@"请填写新密码"];
        return NO;
    }
    
    if ([NSString isNullString:self.confreshCode]) {
//        [MBProgressHUD showError:@"请确认新密码"];
        return NO;
    }
    
    if (![self.confreshCode isEqualToString:self.freshCode]) {
//        [MBProgressHUD showError:@"两次密码输入不一致"];
        return NO;
    }
    
    if (![NSString isNullString:self.messageAuthenticationCodeStr] &&
        ![NSString isNullString:self.freshCode] &&
        ![NSString isNullString:self.confreshCode] &&
        [self.confreshCode isEqualToString:self.freshCode]) {
        return YES;
    }return NO;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = UIButton.new;
        _nextBtn.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"退出登录渐变色底图")];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [self.view addSubview:_nextBtn];
        @weakify(self)
        [[_nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            NSLog(@"点击下一步");//requestParams
            if ([self checkInput]) {
                
//                NSDictionary *parameterDic = @{
//                    @"account":self.requestParams[@"account"],//账号
//                    @"confirmPassword":[UBLTools md5:self.confreshCode],//确认密码，MD5加密
//                    @"mobilePhone":self.requestParams[@"mobilePhone"],//手机号码
//                    @"password":[UBLTools md5:self.freshCode],//密码，MD5加密
//                    @"smsCode":[NSString ensureNonnullString:self.messageAuthenticationCodeStr ReplaceStr:@""]//手机验证码
//                };
                
//                [UBLNetWorkManager postRequestWithUrlPath:UBLUrlRetrievePassword
//                                               parameters:parameterDic
//                                                 finished:^(UBLNetWorkResult * _Nonnull result) {
//                    NSLog(@"result = %@",result);
//                    if ([result.resultObject[@"code"] intValue] == 200) {
//                        
//                        self.schedule = 3;
//                        [self.scheduleView removeFromSuperview];
//                        self->_scheduleView = nil;
//                        self.scheduleView.alpha = 1;
//                        self.changePasswordSuccessTipBtn.alpha = 1;
//                        x.alpha = 0;
//                        //                        [MBProgressHUD showSuccess:result.resultObject[@"msg"]];
//                                                [MBProgressHUD showSuccess:@"密码修改成功"];
//                    }
//                }];
            }
        }];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-213);
            make.size.mas_equalTo(CGSizeMake(347, 43));
        }];
        [UIView cornerCutToCircleWithView:_nextBtn AndCornerRadius:3];
    }return _nextBtn;
}

-(UIButton *)changePasswordSuccessTipBtn{
    if (!_changePasswordSuccessTipBtn) {
        _changePasswordSuccessTipBtn = UIButton.new;
        _changePasswordSuccessTipBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        [_changePasswordSuccessTipBtn setTitleColor:kBlackColor
                                           forState:UIControlStateNormal];
        [_changePasswordSuccessTipBtn setImage:KIMG(@"ChangePasswordSuccessTip") forState:UIControlStateNormal];
        [_changePasswordSuccessTipBtn setTitle:@"修改完成，自动登录" forState:UIControlStateNormal];
        [_changePasswordSuccessTipBtn.titleLabel sizeToFit];
        [self.view addSubview:_changePasswordSuccessTipBtn];
        [_changePasswordSuccessTipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.scheduleView.mas_bottom).offset(69);
            make.height.mas_equalTo(60 + 11.7 + 21);
        }];
        [_changePasswordSuccessTipBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:11.7];
    }return _changePasswordSuccessTipBtn;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"输入验证码"];
        [_titleMutArr addObject:@"设置新密码"];
        [_titleMutArr addObject:@"确认新密码"];
    }return _titleMutArr;
}

-(NSMutableArray<NSString *> *)placeHolderMutArr{
    if (!_placeHolderMutArr) {
        _placeHolderMutArr = NSMutableArray.array;
        [_placeHolderMutArr addObject:@"请输入图像验证码"];
        [_placeHolderMutArr addObject:@"请输入6-12位字母或数字的密码"];
        [_placeHolderMutArr addObject:@"两次输入请保持一致"];
    }return _placeHolderMutArr;
}

@end
