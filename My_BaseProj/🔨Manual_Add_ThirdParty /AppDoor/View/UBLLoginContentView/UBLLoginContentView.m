//
//  LoginContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLLoginContentView.h"

@interface UBLLoginContentView ()

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *storeCodeBtn;//记住密码
@property(nonatomic,strong)UIButton *forgetCodeBtn;//忘记密码
@property(nonatomic,strong)UIButton *toRegisterBtn;//去注册
@property(nonatomic,strong)UIButton *loginBtn;//登录
@property(nonatomic,strong)UIButton *giveUpLoginBtn;//随便看看
@property(nonatomic,strong)UIButton *userAgreementBtn;//用户协议

@property(nonatomic,copy)MKDataBlock loginContentViewBlock;
@property(nonatomic,copy)MKDataBlock loginContentViewKeyboardBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,strong)NSMutableArray *historyAccDataMutArr;//存放历史账户数据
@property(nonatomic,strong)NSMutableArray *historyPWDDataMutArr;//存放历史密码数据
@property(nonatomic,assign)BOOL isEdit;//本页面是否当下正处于编辑状态
@property(nonatomic,assign)CGRect initialContentViewRect;// 登录框 初始frame值

@property(nonatomic,assign)BOOL allowClickAccBtn;
@property(nonatomic,assign)BOOL allowClickPWDBtn;
@property(nonatomic,assign)BOOL allowClickUserAgreementBtn;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLLoginContentView

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        [UIView cornerCutToCircleWithView:self
                          AndCornerRadius:8];
        [self keyboard];
        self.backgroundColor = [kBlackColor colorWithAlphaComponent:0.3];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.bgView.alpha = 0.7;
        self.titleLab.alpha = 1;
        self.toRegisterBtn.alpha = 1;
        [self makeInputView];
        self.storeCodeBtn.alpha = 1;
        self.forgetCodeBtn.alpha = 1;
        self.loginBtn.alpha = 1;
        self.giveUpLoginBtn.alpha = 1;
        self.userAgreementBtn.alpha = 1;
        self.initialContentViewRect = self.frame;
        self.isOK = YES;
    }
}
//
-(BOOL)judgementAcc:(NSString *)string{
    if (string.length > 0) {
        return YES;
    }return NO;
}

-(BOOL)judgementCode:(NSString *)string{
    if (string.length > 0) {
        return YES;
    }return NO;
}
/// 需求：在用户名中输入满4位，同时在密码中输入满6位
/// @param placeholder 用于定位是哪个TF
/// @param judgementStr 需要判定的字符
-(void)tfPlaceholder:(NSString *)placeholder
        judgementStr:(NSString *)judgementStr{
    if ([placeholder isEqualToString:self.placeHolderMutArr[0]]) {//用户名
        self.allowClickAccBtn = [self judgementAcc:judgementStr];
    }else if ([placeholder isEqualToString:self.placeHolderMutArr[1]]){//密码
        self.allowClickPWDBtn = [self judgementCode:judgementStr];
    }else{}
    
    [self loginBtnEnabled];
}

-(void)loginBtnEnabled{
    _loginBtn.enabled = self.allowClickAccBtn && self.allowClickPWDBtn && self.allowClickUserAgreementBtn;
    
    if (_loginBtn.enabled) {
        _loginBtn.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"AppDoorBtnCanBeUse")];//可用
    }else{
        _loginBtn.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"AppDoorBtnCanNotBeUse")];//不可用
    }
}

-(void)makeInputView {
    if (GetUserDefaultValueForKey(@"Acc")) {
        [self.historyAccDataMutArr addObject:GetUserDefaultValueForKey(@"Acc")];
    }
    
    if (GetUserDefaultValueForKey(@"Password") && GetUserDefaultBoolForKey(@"RememberPassword")) {
        [self.historyPWDDataMutArr addObject:GetUserDefaultValueForKey(@"Password")];
    }
    
    for (int t = 0; t < self.headerImgMutArr.count; t++) {
        UBLDoorInputViewStyle_3 *inputView = UBLDoorInputViewStyle_3.new;
        @weakify(self)
        [inputView actionBlockDoorInputViewStyle_3:^(UBLDoorInputViewStyle_3 *data,
                                                     ZYTextField *data2,//目前受影响的TF
                                                     NSString *data3,//目前的终值
                                                     NSString *data4) {//调用方法名，决定是删除还是加字符
            @strongify(self)
            if ([data4 isEqualToString:@"textField:shouldChangeCharactersInRange:replacementString:"]){
                NSLog(@"data3 = %@",data3);
                
                [self tfPlaceholder:data2.placeholder
                       judgementStr:data3];
            }
        }];
        
        if (t == 1) {
            inputView.isShowSecurityMode = YES; // 控制是否显示密码可见按钮
        }
        
        UIImageView *imgv = UIImageView.new;
        imgv.image = self.headerImgMutArr[t];
        inputView.inputViewWidth = MAINSCREEN_WIDTH - 64 - 40 ;
        inputView.tf.leftView = imgv;
        inputView.tf.ZYtintColor = kWhiteColor;
        inputView.tf.leftViewMode = UITextFieldViewModeAlways;
        inputView.tf.placeholder = self.placeHolderMutArr[t];
        inputView.tf.attributedPlaceholder = [NSObject makeRichTextWithDataConfigMutArr:inputView.tf.richLabelDataStringsForPlaceHolderMutArr];

        inputView.btnSelectedIMG = self.btnSelectedImgMutArr[t];
        inputView.btnUnSelectedIMG = self.btnUnselectedImgMutArr[t];
        
        [self.inputViewMutArr addObject:inputView];
        
        if (t == 0) {
            inputView.limitLength = 11;
            if (self.historyAccDataMutArr.count) {
                inputView.tf.text = self.historyAccDataMutArr[0];
            }
        }else if (t == 1){
            inputView.limitLength = 12;
            if (self.historyPWDDataMutArr.count){
                inputView.tf.text = self.historyPWDDataMutArr[0];
            }
//            inputView.tf.rightViewMode = UITextFieldViewModeNever;
//            inputView.tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        }else{}

        //需求：在用户名中输入满4位，同时在密码中输入满6位
        [self tfPlaceholder:inputView.tf.placeholder
               judgementStr:inputView.tf.text];

        [_bgView addSubview:inputView];
        [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.toRegisterBtn.mas_left).offset(-30);
            make.height.mas_equalTo(40);
            make.left.equalTo(self).offset(10);
            if (t == 0) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(40);
            }else{
                UBLDoorInputViewStyle_3 *InputView = self.inputViewMutArr[t - 1];
                make.top.equalTo(InputView.mas_bottom).offset(15);
            }
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:inputView.tf
                          AndCornerRadius:inputView.tf.mj_h / 2];
    }
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
// 以下才是稳定值
-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
    NSLog(@"KeyboardOffsetY = %f",KeyboardOffsetY);//301.000000  -301.000000
    CGFloat offset = 80;
    
    UBLDoorInputViewStyle_3 *用户名 = self.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *密码 = self.inputViewMutArr[1];
    
    self.isEdit = 用户名.tf.editing | 密码.tf.editing;
    
    NSLog(@"AAA用户名.tf.editing = %d",用户名.tf.editing);
    NSLog(@"AAA密码.tf.editing = %d",密码.tf.editing);
    
//    NSLog(@"self.mj_y = %f",self.mj_y);
//    NSLog(@"self.initialContentViewRect.origin.y = %f",self.initialContentViewRect.origin.y);
    
    if (self.isEdit) {
        if (self.initialContentViewRect.origin.y == self.mj_y) {
            [self showLoginContentViewWithOffsetY:offset];
        }
    }else{
        if (self.initialContentViewRect.origin.y != self.mj_y) {
            [self showLoginContentViewWithOffsetY:-offset];
        }
    }
    
    if (self.loginContentViewKeyboardBlock) {
        self.loginContentViewKeyboardBlock(@(KeyboardOffsetY));
    }
}

/*
 *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
 *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
 *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
 *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
 *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
 *    dampingRatio 阻尼
 *    velocity 速度
 */
-(void)showLoginContentViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.centerX = MAINSCREEN_WIDTH / 2;
        self.centerY -= offsetY;
    } completion:^(BOOL finished) {
    }];
}

-(void)removeLoginContentViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.mj_x = -(self.mj_w + self.mj_x);
        self.mj_y = self.initialContentViewRect.origin.y;
    } completion:^(BOOL finished) {
    }];
}
///记住账户和密码：前提条件（登录成功以后）
-(void)storeAcc_Code{
    if (self.storeCodeBtn.selected) {
        UBLDoorInputViewStyle_3 *用户名 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[0];
        UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[1];
        if (![NSString isNullString:用户名.tf.text] && ![NSString isNullString:密码.tf.text]) {
            //存密码
            if (GetUserDefaultBoolForKey(@"RememberPassword")) {
                SetUserDefaultKeyWithValue(@"Acc", 用户名.tf.text);
                SetUserDefaultKeyWithValue(@"Password", 密码.tf.text);
                UserDefaultSynchronize;
            }
        }
    }
}

-(void)startToRegisterBtn{
    UBLDoorInputViewStyle_3 *用户名 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[1];

    if ([NSString isNullString:用户名.tf.text]) {
//        [MBProgressHUD showError:@"请填写用户名"];
    }
    if ([NSString isNullString:密码.tf.text]) {
//        [MBProgressHUD showError:@"请输入密码"];
    }
    
    if (![NSString isNullString:用户名.tf.text] &&
        ![NSString isNullString:密码.tf.text]) {
        //自定义的一些内层规则
        if (用户名.tf.text.length < 4 || 用户名.tf.text.length > 11) {
//            [MBProgressHUD showError:@"请输入4~11位字母或数字的用户名"];
        }else{
            if (密码.tf.text.length < 6 || 密码.tf.text.length > 12) {
//                [MBProgressHUD showError:@"请输入6~12位字母或数字的密码"];
            }else{
                //各种判断过滤在内层做处理，在外层就直接用最终结果
                if (self.loginContentViewBlock) {
                    self.loginContentViewBlock(self->_loginBtn);
                }
            }
        }
    }else{
//        [MBProgressHUD showError:@"请完善登录信息"];
    }
}
///各种按钮的点击事件回调
-(void)actionLoginContentViewBlock:(MKDataBlock)loginContentViewBlock{
    self.loginContentViewBlock = loginContentViewBlock;
}

-(void)actionLoginContentViewKeyboardBlock:(MKDataBlock)loginContentViewKeyboardBlock{
    self.loginContentViewKeyboardBlock = loginContentViewKeyboardBlock;
}
#pragma mark —— lazyLoad
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = KLightGrayColor;
        _bgView.frame = CGRectMake(0,
                                   0,
                                   self.width,
                                   self.height);
        [self addSubview:_bgView];
    }
    return _bgView;
}

-(UIButton *)toRegisterBtn{
    if (!_toRegisterBtn) {
        _toRegisterBtn = UIButton.new;
        _toRegisterBtn.titleLabel.numberOfLines = 0;
        _toRegisterBtn.backgroundColor = kBlackColor;
        _toRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        _toRegisterBtn.alpha = 0.7f;
        [_toRegisterBtn setTitle:@"新\n用\n户\n注\n册"
                        forState:UIControlStateNormal];
        [_toRegisterBtn setImage:KIMG(@"用户名称")
                        forState:UIControlStateNormal];
        @weakify(self)
        [[_toRegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
//            NSLog(@"新用户注册");
            @strongify(self)
            [self endEditing:YES];
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(x);
            }
        }];
        [_bgView addSubview:_toRegisterBtn];
        [_toRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.mas_equalTo(64);
        }];
        [_toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:8];
    }return _toRegisterBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"登录";
        _titleLab.textColor = RGBA_COLOR(255,
                                         255,
                                         255,
                                         1);
        _titleLab.font = [UIFont systemFontOfSize:19
                                           weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [_bgView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(-32);
            make.top.equalTo(self).offset(20);
        }];
    }return _titleLab;
}

-(UIButton *)storeCodeBtn{
    if (!_storeCodeBtn) {
        _storeCodeBtn = UIButton.new;
        _storeCodeBtn.titleLabel.textColor = KLightGrayColor;
        _storeCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12
                                                          weight:UIFontWeightRegular];
        _storeCodeBtn.selected = GetUserDefaultBoolForKey(@"RememberPassword");
        
        [_storeCodeBtn setTitle:@"记住密码"
                       forState:UIControlStateNormal];
        [_storeCodeBtn setImage:KIMG(@"记住密码")
                       forState:UIControlStateSelected];
        [_storeCodeBtn setImage:KIMG(@"没有记住密码")
                       forState:UIControlStateNormal];
        
        [_storeCodeBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                       imageTitleSpace:2];
        @weakify(self)
        [[_storeCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            NSLog(@"存储密码?");
            x.selected = !x.selected;
            SetUserBoolKeyWithObject(@"RememberPassword",x.selected);
            if (GetUserDefaultBoolForKey(@"RememberPassword")) {
                [self.historyPWDDataMutArr removeAllObjects];
                SetUserDefaultKeyWithValue(@"Password", @"");//本地化数据进行冲销
                UserDefaultSynchronize;
            }
            
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(x);
            }
        }];
        [_bgView addSubview:_storeCodeBtn];
        [_storeCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(25);
            make.top.equalTo(self.inputViewMutArr.lastObject.mas_bottom).offset(15);
        }];
    }return _storeCodeBtn;
}

-(UIButton *)forgetCodeBtn{
    if (!_forgetCodeBtn) {
        _forgetCodeBtn = UIButton.new;
        _forgetCodeBtn.titleLabel.textColor = KLightGrayColor;
        _forgetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12
                                                          weight:UIFontWeightRegular];
        [_forgetCodeBtn.titleLabel sizeToFit];
        _forgetCodeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_forgetCodeBtn setTitle:@"忘记密码"
                       forState:UIControlStateNormal];
        [_forgetCodeBtn setImage:KIMG(@"空白图")
                        forState:UIControlStateNormal];
        @weakify(self)
        [[_forgetCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(x);
            }
        }];
        [_bgView addSubview:_forgetCodeBtn];
        [_forgetCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.inputViewMutArr.lastObject.mas_right).offset(-10);
            make.top.equalTo(self.inputViewMutArr.lastObject.mas_bottom).offset(15);
        }];
        
    }return _forgetCodeBtn;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = UIButton.new;
        _loginBtn.enabled = NO;
        _loginBtn.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"AppDoorBtnCanNotBeUse")];//不可用
        [self addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(245,44));
            make.centerX.equalTo(self.titleLab.mas_centerX);
            make.top.equalTo(self.storeCodeBtn.mas_bottom).offset(18);
        }];
        
        [self layoutIfNeeded];

        [_loginBtn setTitle:@"登录"
                   forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kWhiteColor
                        forState:UIControlStateNormal];
        @weakify(self)
        [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSLog(@"登录");
            [self startToRegisterBtn];//加了判断的 不能删
            [self endEditing:YES];
        }];
        [UIView cornerCutToCircleWithView:_loginBtn.imageView
                          AndCornerRadius:20];
    }return _loginBtn;
}

-(UIButton *)giveUpLoginBtn{
    if (!_giveUpLoginBtn) {
        _giveUpLoginBtn = UIButton.new;
        _giveUpLoginBtn.titleLabel.font = [UIFont systemFontOfSize:12
                                                            weight:UIFontWeightRegular];
        _giveUpLoginBtn.titleLabel.textColor = KLightGrayColor;
        [_giveUpLoginBtn setTitle:@"随便看看"
                         forState:UIControlStateNormal];
        [_giveUpLoginBtn.titleLabel sizeToFit];
        _giveUpLoginBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        @weakify(self)
        [[_giveUpLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSLog(@"随便看看");
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(x);
            }
        }];
        [self addSubview:_giveUpLoginBtn];
        [_giveUpLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.loginBtn);
            make.size.mas_equalTo(CGSizeMake(48, 17));
            make.top.equalTo(self.loginBtn.mas_bottom).offset(16);
        }];
        
    }return _giveUpLoginBtn;
}

-(UIButton *)userAgreementBtn{
    if (!_userAgreementBtn) {
        _userAgreementBtn = UIButton.new;
        _userAgreementBtn.selected = NO;
        [_userAgreementBtn setTitle:@"已阅读并同意《用户协议》"
                           forState:UIControlStateNormal];
        [_userAgreementBtn setImage:KIMG(@"记住密码")
                           forState:UIControlStateSelected];
        [_userAgreementBtn setImage:KIMG(@"没有记住密码")
                           forState:UIControlStateNormal];
        _userAgreementBtn.titleLabel.font = [UIFont systemFontOfSize:11
                                                              weight:UIFontWeightMedium];
        [_userAgreementBtn setTitleColor:RGBCOLOR(255, 255, 255) forState:UIControlStateNormal];
        [_userAgreementBtn.titleLabel sizeToFit];
        @weakify(self)
        [[_userAgreementBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            NSLog(@"已阅读并同意《用户协议》");
            x.selected = !x.selected;
            self.allowClickUserAgreementBtn = x.selected;
            [self loginBtnEnabled];
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(x);
            }
        }];
        
        [self addSubview:_userAgreementBtn];
        [_userAgreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.loginBtn);
            make.bottom.equalTo(self).offset(-6);
        }];
        
        [_userAgreementBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                           imageTitleSpace:5];
        
    }return _userAgreementBtn;
}

-(NSMutableArray *)historyAccDataMutArr{
    if (!_historyAccDataMutArr) {
        _historyAccDataMutArr = NSMutableArray.array;
    }return _historyAccDataMutArr;
}

-(NSMutableArray *)historyPWDDataMutArr{
    if (!_historyPWDDataMutArr) {
        _historyPWDDataMutArr = NSMutableArray.array;
    }return _historyPWDDataMutArr;
}

-(NSMutableArray<UBLDoorInputViewStyle_3 *> *)inputViewMutArr{
    if (!_inputViewMutArr) {
        _inputViewMutArr = NSMutableArray.array;
    }return _inputViewMutArr;
}

-(NSMutableArray<UIImage *> *)headerImgMutArr{
    if (!_headerImgMutArr) {
        _headerImgMutArr = NSMutableArray.array;
        [_headerImgMutArr addObject:KIMG(@"用户名称")];
        [_headerImgMutArr addObject:KIMG(@"Lock")];
    }return _headerImgMutArr;
}

-(NSMutableArray<NSString *> *)placeHolderMutArr{
    if (!_placeHolderMutArr) {
        _placeHolderMutArr = NSMutableArray.array;
        [_placeHolderMutArr addObject:@"4-11位字母或数字的用户名"];
        [_placeHolderMutArr addObject:@"6-12位字母或数字的密码"];
    }return _placeHolderMutArr;
}

-(NSMutableArray<UIImage *> *)btnSelectedImgMutArr{
    if (!_btnSelectedImgMutArr) {
        _btnSelectedImgMutArr = NSMutableArray.array;
        [_btnSelectedImgMutArr addObject:KIMG(@"空白图")];
        [_btnSelectedImgMutArr addObject:KIMG(@"codeDecode")];
    }return _btnSelectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)btnUnselectedImgMutArr{
    if (!_btnUnselectedImgMutArr) {
        _btnUnselectedImgMutArr = NSMutableArray.array;
        [_btnUnselectedImgMutArr addObject:KIMG(@"closeCircle")];
        [_btnUnselectedImgMutArr addObject:KIMG(@"codeEncode")];
    }return _btnUnselectedImgMutArr;
}

@end
