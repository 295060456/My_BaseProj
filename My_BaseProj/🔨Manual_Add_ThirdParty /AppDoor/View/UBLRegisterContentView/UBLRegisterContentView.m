//
//  RegisterContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLRegisterContentView.h"

@class UBLDoorInputViewBaseStyle;

@interface UBLRegisterContentView ()

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *backToLoginBtn;//返回登录
@property(nonatomic,strong)UIButton *toRegisterBtn;//去注册
@property(nonatomic,copy)MKDataBlock registerContentViewBlock;
@property(nonatomic,copy)MKDataBlock registerContentViewKeyboardBlock;
@property(nonatomic,copy)MKDataBlock registerContentViewTFBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;

@property(nonatomic,assign)BOOL isEdit;//本页面是否当下正处于编辑状态
@property(nonatomic,assign)BOOL allowClickAccBtn;
@property(nonatomic,assign)BOOL allowClickPWDBtn;
@property(nonatomic,assign)BOOL allowClickConfirmPWDBtn;
@property(nonatomic,assign)BOOL allowClickVerificationCodeBtn;
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,assign)CGRect initRegisterContentViewRect;

@end

@implementation UBLRegisterContentView
- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        [UIView cornerCutToCircleWithView:self
                          AndCornerRadius:8];
        self.backgroundColor = [kBlackColor colorWithAlphaComponent:0.3];
        [self keyboard];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.bgView.alpha = 0.7;
        self.titleLab.alpha = 1;
        self.backToLoginBtn.alpha = 1;
        [self makeInputView];
        self.toRegisterBtn.alpha = 1;
        self.initRegisterContentViewRect = self.frame;
        self.isOK = YES;
    }
}

-(BOOL)judgementAcc:(NSString *)judgementStr{
    if (judgementStr.length > 0){
        return YES;
    }return NO;
}

-(BOOL)judgementCode:(NSString *)judgementStr{
    if (judgementStr.length > 0) {
        return YES;
    }return NO;
}

-(BOOL)verificationCode:(NSString *)judgementStr{
    if (judgementStr.length > 0) {
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
    }else if ([placeholder isEqualToString:self.placeHolderMutArr[2]]){//确认密码
        self.allowClickConfirmPWDBtn = [self judgementCode:judgementStr];
    }else if ([placeholder isEqualToString:self.placeHolderMutArr[3]]){//验证码
        self.allowClickVerificationCodeBtn = [self verificationCode:judgementStr];
    }else{}
    
    _toRegisterBtn.enabled = self.allowClickAccBtn &&
                             self.allowClickPWDBtn &&
                             self.allowClickConfirmPWDBtn &&
                             self.allowClickVerificationCodeBtn;
    
    if (_toRegisterBtn.enabled) {
        _toRegisterBtn.alpha = 1;
        _toRegisterBtn.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"AppDoorBtnCanBeUse")];//可用
    }else{
        _toRegisterBtn.alpha = .7;
        _toRegisterBtn.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"AppDoorBtnCanNotBeUse")];//不可用
    }
}

-(void)makeInputView{
    
    for (int t = 0; t < self.headerImgMutArr.count - 1; t++) {
        UBLDoorInputViewStyle_3 *inputView = UBLDoorInputViewStyle_3.new;

        //奇怪 打开下面就会崩
//        if (t == 1 || t == 2) {
//            inputView.isShowSecurityMode = YES;
//            inputView.limitLength = 12;
//        }else{
//            inputView.isShowSecurityMode = NO;
//        }
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
                
                if (self.registerContentViewTFBlock) {
                    self.registerContentViewTFBlock(data3);
                }
            }
        }];
        
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
        
        //需求：在用户名中输入满4位，同时在密码中输入满6位
        [self tfPlaceholder:inputView.tf.placeholder
               judgementStr:inputView.tf.text];

        [_bgView addSubview:inputView];
        [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (t == 0) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(10);
            }else{
                inputView.tf.rightViewMode = UITextFieldViewModeNever;
                inputView.tf.clearButtonMode = UITextFieldViewModeNever;
                UBLDoorInputViewStyle_3 *InputView = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[t - 1];
                make.top.equalTo(InputView.mas_bottom).offset(10);
            }
            make.left.equalTo(self.backToLoginBtn.mas_right).offset(10);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(40);
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:inputView.tf
                          AndCornerRadius:inputView.tf.mj_h / 2];
    }
    
    //验证码输入框
    UBLDoorInputViewStyle_2 *inputView = UBLDoorInputViewStyle_2.new;
    @weakify(self)
    // 验证码 的输入回调
    [inputView actionBlockDoorInputViewStyle_2:^(id data,
                                                 ZYTextField *data2,
                                                 NSString *resString,
                                                 NSString *selectorName) {
        @strongify(self)
        [self tfPlaceholder:self.placeHolderMutArr[3]
               judgementStr:resString];

        if (self.registerContentViewTFBlock) {
            self.registerContentViewTFBlock(resString);
        }
    }];
    UIImageView *imgv = UIImageView.new;
    imgv.image = self.headerImgMutArr.lastObject;
    UBLDoorInputViewStyle_3 *InputView = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr.lastObject;
    inputView.inputViewWidth = InputView.mj_w;
    inputView.inputViewHeight = InputView.mj_h;
    inputView.tf.leftView = imgv;
    inputView.tf.ZYtintColor = kWhiteColor;
    inputView.tf.leftViewMode = UITextFieldViewModeAlways;
    inputView.tf.placeholder = self.placeHolderMutArr.lastObject;

    [self addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(InputView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(inputView.inputViewWidth + 10, inputView.inputViewHeight));
        make.centerX.equalTo(InputView).offset(10);
    }];
    [self.inputViewMutArr addObject:inputView];
    [self layoutIfNeeded];
    [UIView cornerCutToCircleWithView:inputView
                      AndCornerRadius:inputView.mj_h / 2];
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
-(void)showRegisterContentViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.centerX = MAINSCREEN_WIDTH / 2;
        self.centerY -= offsetY;
    } completion:^(BOOL finished) {}];
}

-(void)removeRegisterContentViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.mj_x = -(self.mj_w + self.mj_x);
        self.mj_y = self.initRegisterContentViewRect.origin.y;
    } completion:^(BOOL finished) {}];
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
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
    
    CGFloat offset = 100;
    
    UBLDoorInputViewStyle_3 *用户名 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[1];
    UBLDoorInputViewStyle_3 *确认密码 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[2];
    UBLDoorInputViewStyle_2 *填写验证码 = (UBLDoorInputViewStyle_2 *)self.inputViewMutArr[3];

    self.isEdit = 用户名.tf.editing | 密码.tf.editing | 确认密码.tf.editing | 填写验证码.tf.editing;
    
    if (self.isEdit) {
        if (self.initRegisterContentViewRect.origin.y == self.mj_y) {
            [self showRegisterContentViewWithOffsetY:offset];
        }
    }else{
        if (self.initRegisterContentViewRect.origin.y != self.mj_y) {
            [self showRegisterContentViewWithOffsetY:-offset];
        }
    }
    if (self.registerContentViewKeyboardBlock) {
        self.registerContentViewKeyboardBlock(@(KeyboardOffsetY));
    }
}

-(void)startToRegisterBtn{
    UBLDoorInputViewStyle_3 *用户名 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[1];
    UBLDoorInputViewStyle_3 *确认密码 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[2];
    UBLDoorInputViewStyle_2 *填写验证码 = (UBLDoorInputViewStyle_2 *)self.inputViewMutArr[3];

    if ([NSString isNullString:用户名.tf.text]) {
//        [MBProgressHUD showError:@"请输入用户名"];
    }
    if ([NSString isNullString:密码.tf.text]) {
//        [MBProgressHUD showError:@"请输入密码"];
    }
    if ([NSString isNullString:确认密码.tf.text]) {
//        [MBProgressHUD showError:@"请输入确认密码"];
    }
    if ([NSString isNullString:填写验证码.tf.text]) {
//        [MBProgressHUD showError:@"请输入图像验证码"];
    }
    if (![NSString isNullString:用户名.tf.text] &&
        ![NSString isNullString:密码.tf.text] &&
        ![NSString isNullString:确认密码.tf.text] &&
        ![NSString isNullString:填写验证码.tf.text]) {

        if ([密码.tf.text isEqualToString:确认密码.tf.text]) {
            if ([填写验证码.tf.text isEqualToString:填写验证码.imageCodeView.CodeStr]) {
                //自定义的一些内层规则
                if (用户名.tf.text.length < 4 || 用户名.tf.text.length > 11) {
//                    [MBProgressHUD showError:@"请输入4~11位字母或数字的用户名"];
                }else{
                    if (密码.tf.text.length < 6 || 密码.tf.text.length > 12) {
//                        [MBProgressHUD showError:@"请输入6~12位字母或数字的密码"];
                    }else{
                        if (确认密码.tf.text.length < 6 || 确认密码.tf.text.length > 12) {
//                            [MBProgressHUD showError:@"请输入6~12位字母或数字的确认密码"];
                        }else{
                            //各种判断过滤在内层做处理，在外层就直接用最终结果
                            if (self.registerContentViewBlock) {
                                self.registerContentViewBlock(self->_toRegisterBtn);
                            }
                        }
                    }
                }
            }else{
//                [MBProgressHUD showError:@"验证码不正确"];
            }
        }else{
//            [MBProgressHUD showError:@"两次密码输入不一致"];
        }
    }
    else{
//        [MBProgressHUD showError:@"请完善注册信息"];
    }
}

-(void)actionRegisterContentViewBlock:(MKDataBlock)registerContentViewBlock{
    self.registerContentViewBlock = registerContentViewBlock;
}

-(void)actionRegisterContentViewKeyboardBlock:(MKDataBlock)registerContentViewKeyboardBlock{
    self.registerContentViewKeyboardBlock = registerContentViewKeyboardBlock;
}

-(void)actionRegisterContentViewTFBlock:(MKDataBlock)registerContentViewTFBlock{
    self.registerContentViewTFBlock = registerContentViewTFBlock;
}
#pragma mark —— lazyLoad
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.backgroundColor = KLightGrayColor;
        _bgView.frame = CGRectMake(0,
                                   0,
                                   self.width,
                                   self.height);
        [self addSubview:_bgView];
    }return _bgView;
}

-(UIButton *)backToLoginBtn{
    if (!_backToLoginBtn) {
        _backToLoginBtn = UIButton.new;
        _backToLoginBtn.titleLabel.numberOfLines = 0;
        _backToLoginBtn.backgroundColor = kBlackColor;
        _backToLoginBtn.alpha = 0.7f;
        _backToLoginBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        [_backToLoginBtn setTitle:@"返\n回\n登\n录"
                        forState:UIControlStateNormal];
        [_backToLoginBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:8];
        [_backToLoginBtn setImage:KIMG(@"用户名称")
                         forState:UIControlStateNormal];
        @weakify(self)
        [[_backToLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            NSLog(@"返回登录");
            @strongify(self)
            [self endEditing:YES];
            if (self.registerContentViewBlock) {
                self.registerContentViewBlock(self->_backToLoginBtn);
            }
        }];
        [_bgView addSubview:_backToLoginBtn];
        [_backToLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.mas_equalTo(64);
        }];
        [_backToLoginBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:8];
    }return _backToLoginBtn;
}

-(UIButton *)toRegisterBtn{
    if (!_toRegisterBtn) {
        _toRegisterBtn = UIButton.new;
        _toRegisterBtn.enabled = NO;
        _toRegisterBtn.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"AppDoorBtnCanNotBeUse")];//不可用
        [self addSubview:_toRegisterBtn];
        [_toRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            UBLDoorInputViewStyle_3 *InputView = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr.lastObject;
            make.centerX.equalTo(InputView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(245,44));
            make.top.equalTo(InputView.mas_bottom).offset(15);
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_toRegisterBtn
                          AndCornerRadius:20];
        [_toRegisterBtn setTitle:@"注册"
                        forState:UIControlStateNormal];
        [_toRegisterBtn setTitleColor:kWhiteColor
                        forState:UIControlStateNormal];
        @weakify(self)
        [[_toRegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self endEditing:YES];
            //各种判断过滤在内层做处理，在外层就直接用最终结果
            if (self.registerContentViewBlock) {
                self.registerContentViewBlock(self->_toRegisterBtn);
            }
            [self startToRegisterBtn];//加了判断的 不能删
        }];
    }return _toRegisterBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"注册";
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = kWhiteColor;
        _titleLab.font = [UIFont systemFontOfSize:19
                                           weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [_bgView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(20);
            make.top.equalTo(self).offset(20);
        }];
    }return _titleLab;
}

-(NSMutableArray<UIImage *> *)headerImgMutArr{
    if (!_headerImgMutArr) {
        _headerImgMutArr = NSMutableArray.array;
        [_headerImgMutArr addObject:KIMG(@"用户名称")];
        [_headerImgMutArr addObject:KIMG(@"Lock")];
        [_headerImgMutArr addObject:KIMG(@"Lock")];
        [_headerImgMutArr addObject:KIMG(@"验证ICON")];
    }return _headerImgMutArr;
}

-(NSMutableArray<NSString *> *)placeHolderMutArr{
    if (!_placeHolderMutArr) {
        _placeHolderMutArr = NSMutableArray.array;
        [_placeHolderMutArr addObject:@"4-11位字母或数字的用户名"];
        [_placeHolderMutArr addObject:@"6-12位字母或数字的密码"];
        [_placeHolderMutArr addObject:@"确认密码"];
        [_placeHolderMutArr addObject:@"请输入图像验证码"];
    }return _placeHolderMutArr;
}

-(NSMutableArray<UIImage *> *)btnSelectedImgMutArr{
    if (!_btnSelectedImgMutArr) {
        _btnSelectedImgMutArr = NSMutableArray.array;
        [_btnSelectedImgMutArr addObject:KIMG(@"空白图")];
        [_btnSelectedImgMutArr addObject:KIMG(@"codeDecode")];
        [_btnSelectedImgMutArr addObject:KIMG(@"codeDecode")];
    }return _btnSelectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)btnUnselectedImgMutArr{
    if (!_btnUnselectedImgMutArr) {
        _btnUnselectedImgMutArr = NSMutableArray.array;
        [_btnUnselectedImgMutArr addObject:KIMG(@"closeCircle")];
        [_btnUnselectedImgMutArr addObject:KIMG(@"codeEncode")];
        [_btnUnselectedImgMutArr addObject:KIMG(@"codeEncode")];
    }return _btnUnselectedImgMutArr;
}

-(NSMutableArray<UBLDoorInputViewBaseStyle *> *)inputViewMutArr{
    if (!_inputViewMutArr) {
        _inputViewMutArr = NSMutableArray.array;
    }return _inputViewMutArr;
}

@end
