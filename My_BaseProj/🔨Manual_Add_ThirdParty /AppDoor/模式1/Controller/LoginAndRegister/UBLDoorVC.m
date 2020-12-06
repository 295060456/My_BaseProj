//
//  DoorVC.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLDoorVC.h"

ZFPlayerController *ZFPlayer_DoorVC;

@interface UBLDoorVC ()

@property(nonatomic,strong)UIImageView *bgImgV;
@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;
@property(nonatomic,strong,nullable)UBLLoginContentView *loginContentView;//登录页面
@property(nonatomic,strong,nullable)UBLRegisterContentView *registerContentView;//注册页面
@property(nonatomic,strong,nullable)UBLLogoContentView *logoContentView;

@property(nonatomic,strong)NSString *captchaKey;

@end

@implementation UBLDoorVC

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    PrintRetainCount(self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupNavigationBarHidden = YES;
    
    if ([self.requestParams integerValue] == doorBgType_Image) {
        self.view = self.bgImgV;
    }else if ([self.requestParams integerValue] == doorBgType_video){
        [self.player.currentPlayerManager play];
    }else{}
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.loginContentView.alpha = 1;
    [UIView animationAlert:self.logoContentView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.loginContentView showLoginContentViewWithOffsetY:0];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.requestParams integerValue] == doorBgType_Image) {
        
    }else if ([self.requestParams integerValue] == doorBgType_video){
        if (self.player.currentPlayerManager.isPlaying) {
            [self.player.currentPlayerManager pause];
        }
    }else{}
    
    [self overUI];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)back:(UIButton *_Nullable)sender{
    if ([self.requestParams integerValue] == doorBgType_Image) {
        
    }else if ([self.requestParams integerValue] == doorBgType_video){
        if (self.player.currentPlayerManager.isPlaying) {
            [self.player.currentPlayerManager stop];
        }
    }else{}
    
    [self backBtnClickEvent:sender];
}

-(void)overUI{
    [_logoContentView removeFromSuperview];
    [_loginContentView removeFromSuperview];
    [_registerContentView removeFromSuperview];
    
    _logoContentView = nil;
    _loginContentView = nil;
    _registerContentView = nil;
    
    [_customPlayerControlView removeFromSuperview];
    _customPlayerControlView = nil;
    [_player.currentPlayerManager stop];
    _playerManager = nil;
    _player = nil;
}
#pragma mark —— LazyLoad
-(UBLLoginContentView *)loginContentView{
    if (!_loginContentView) {
        _loginContentView = UBLLoginContentView.new;
        @weakify(self)
        [_loginContentView actionLoginContentViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:@"新\n用\n户\n注\n册"]) {
                    [self.registerContentView showRegisterContentViewWithOffsetY:0];
                    [self.loginContentView removeLoginContentViewWithOffsetY:0];
                }else if ([btn.titleLabel.text isEqualToString:@"记住密码"]){
                    SetUserBoolKeyWithObject(@"RememberPassword", btn.selected);
                }else if ([btn.titleLabel.text isEqualToString:@"忘记密码"]){
                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                                             style:UIBarButtonItemStylePlain
                                                                                            target:nil
                                                                                            action:nil];
                    [UIViewController comingFromVC:self
                                              toVC:UBLRetrievePasswordVC.new
                                       comingStyle:ComingStyle_PUSH
                                 presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                                     requestParams:@""
                          hidesBottomBarWhenPushed:YES
                                          animated:YES
                                           success:^(id data) {
                        
                    }];
                }else if ([btn.titleLabel.text isEqualToString:@"登录"]){
                    [self.view endEditing:YES];
//                    UBLDoorInputViewStyle_3 *用户名 = (UBLDoorInputViewStyle_3 *)self.loginContentView.inputViewMutArr[0];
//                    UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.loginContentView.inputViewMutArr[1];
//                    @weakify(self)
//                    [UBLNetWorkManager postRequestWithUrlPath:UBLUrlUserLogin
//                                                   parameters:@{
//                                                       @"account":用户名.tf.text,
//                                                       @"password":[UBLTools md5:密码.tf.text]
//                                                   } finished:^(UBLNetWorkResult * _Nonnull result) {
//                        @strongify(self)
//                        if (!result.error) {
//                            self.userInfoModel = [UBLUserInfoModel mj_objectWithKeyValues:result.resultData];
//                            NSLog(@"result.resultData:%@",result.resultData);
//                            if (![NSString isNullString:用户名.tf.text] && ![NSString isNullString:密码.tf.text]) {
//                                //存密码
//                                if (GetUserDefaultBoolForKey(@"RememberPassword")) {
//                                    SetUserDefaultKeyWithValue(@"Acc", 用户名.tf.text);
//                                    SetUserDefaultKeyWithValue(@"Password", 密码.tf.text);
//                                    UserDefaultSynchronize;
//                                }
//                            }
//
//                            [self back:nil];
//                        }
//                    }];
                }else if ([btn.titleLabel.text isEqualToString:@"随便看看"]){
                    [self overUI];
                    [self backBtnClickEvent:nil];
                }else if ([btn.titleLabel.text isEqualToString:@"已阅读并同意《用户协议》"]){
                    NSLog(@"已阅读并同意《用户协议》");
                }else{}
            }
        }];
        
        [_loginContentView actionLoginContentViewKeyboardBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *b = (NSNumber *)data;
//                NSLog(@"%@",b);
                if (b.floatValue > 0) {
//                    NSLog(@"开始编辑");
                    self.logoContentView.alpha = 0;
                }else if(b.floatValue < -100){
//                    NSLog(@"正常模式");
                    self.logoContentView.alpha = 1;
                }else{}
            }
        }];
        [self.view addSubview:_loginContentView];
        _loginContentView.frame = CGRectMake(MAINSCREEN_WIDTH,
                                             225,
                                             MAINSCREEN_WIDTH - 21 * 2,
                                             349);
    }return _loginContentView;
}

-(UBLRegisterContentView *)registerContentView{
    if (!_registerContentView) {
        _registerContentView = UBLRegisterContentView.new;
        @weakify(self)
        //主要是按钮点击事件的回调
        [_registerContentView actionRegisterContentViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:@"返\n回\n登\n录"]) {
                    [self.loginContentView showLoginContentViewWithOffsetY:0];
                    [self.registerContentView removeRegisterContentViewWithOffsetY:0];
                }else if ([btn.titleLabel.text isEqualToString:@"注册"]) {
                    [self.view endEditing:YES];
                    //注册成功即登录
                    UBLDoorInputViewStyle_3 *用户名 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[0];
                    UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[1];
                    UBLDoorInputViewStyle_3 *确认密码 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[2];
                    UBLDoorInputViewStyle_2 *填写验证码 = (UBLDoorInputViewStyle_2 *)self.registerContentView.inputViewMutArr[3];
                    if ([NSString isNullString:填写验证码.imageCodeView.captchaKey]) {
                        NSLog(@"异常");
                    }else{
//                        [UBLNetWorkManager postRequestWithUrlPath:UBLUrlUserRegister
//                                                       parameters:@{
//                                                           @"account":用户名.tf.text,//账号
//                                                           @"captchaKey":填写验证码.imageCodeView.captchaKey,//验证码唯一标识
//                                                           @"confirmPassword":[UBLTools md5:确认密码.tf.text],//确认密码，MD5加密
//                                                           @"imgCode":填写验证码.tf.text,//图片验证码
//                                                           @"password":[UBLTools md5:密码.tf.text]
//                                                       }
//                                                         finished:^(UBLNetWorkResult * _Nonnull result) {
//                            if (result.error) {
//                                [MBProgressHUD showError:result.error.localizedDescription];
//                            }else{
//                                self.userInfoModel = [UBLUserInfoModel mj_objectWithKeyValues:result.resultData];
//                                NSLog(@"result.resultData:%@",result.resultData);
//                                if (![NSString isNullString:用户名.tf.text] && ![NSString isNullString:密码.tf.text]) {
//                                    //存密码
//                                    if ((GetUserDefaultBoolForKey(@"RememberPassword"))) {
//                                        SetUserDefaultKeyWithValue(@"Acc", 用户名.tf.text);
//                                        SetUserDefaultKeyWithValue(@"Password", 密码.tf.text);
//                                        UserDefaultSynchronize;
//                                    }
//                                }
//                                [self.loginContentView showLoginContentViewWithOffsetY:0];
//                                [self.registerContentView removeRegisterContentViewWithOffsetY:0];
//                            }
//                        }];
                    }
                }else{}
            }
        }];
        //键盘响应事件的回调
        [_registerContentView actionRegisterContentViewKeyboardBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *b = (NSNumber *)data;
//                NSLog(@"%@",b);
                if (b.floatValue > 0) {
//                    NSLog(@"开始编辑");
                    self.logoContentView.alpha = 0;
                }else if(b.floatValue < -100){
//                    NSLog(@"正常模式");
                    self.logoContentView.alpha = 1;
                }else{}
            }
        }];
        //输入框内容回调
        [_registerContentView actionRegisterContentViewTFBlock:^(id data) {
            @strongify(self)
//            UBLDoorInputViewStyle_3 *用户名 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[0];
//            UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[1];
//            UBLDoorInputViewStyle_3 *确认密码 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[2];
//            UBLDoorInputViewStyle_2 *填写验证码 = (UBLDoorInputViewStyle_2 *)self.registerContentView.inputViewMutArr[3];
        }];
        
        [self.view addSubview:_registerContentView];
        _registerContentView.frame = CGRectMake(MAINSCREEN_WIDTH,
                                                225,
                                                MAINSCREEN_WIDTH - 21 * 2,
                                                349);
    }return _registerContentView;
}

-(void)reInputCode{
    UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[1];
    UBLDoorInputViewStyle_3 *确认密码 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[2];
    密码.tf.text = @"";
    确认密码.tf.text = @"";
}

-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
        _playerManager.shouldAutoPlay = YES;

        if (isiPhoneX_series()) {
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"welcome_video"
                                                                                             ofType:@"mp4"]];
        }else{
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"welcome_video"
                                                                                             ofType:@"mp4"]];
        }
    }return _playerManager;
}

-(ZFPlayerController *)player{
    if (!_player) {
        @weakify(self)
        _player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager
                                                      containerView:self.view];
        _player.controlView = self.customPlayerControlView;
        ZFPlayer_DoorVC = _player;
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}

-(CustomZFPlayerControlView *)customPlayerControlView{
    if (!_customPlayerControlView) {
        _customPlayerControlView = CustomZFPlayerControlView.new;
        @weakify(self)
        [_customPlayerControlView actionCustomZFPlayerControlViewBlock:^(id data, id data2) {
            @strongify(self)
            [self.view endEditing:YES];
        }];
    }return _customPlayerControlView;
}

-(UBLLogoContentView *)logoContentView{
    if (!_logoContentView) {
        _logoContentView = UBLLogoContentView.new;
        [self.view addSubview:_logoContentView];
        [_logoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 50));
            make.bottom.equalTo(self.loginContentView.mas_top).offset(-50);
            make.centerX.equalTo(self.view);
        }];
    }return _logoContentView;
}

-(UIImageView *)bgImgV{
    if (!_bgImgV) {
        _bgImgV = UIImageView.new;
        _bgImgV.image = KIMG(@"AppDoorBgImage");
        _bgImgV.userInteractionEnabled = YES;
    }return _bgImgV;
}

@end
