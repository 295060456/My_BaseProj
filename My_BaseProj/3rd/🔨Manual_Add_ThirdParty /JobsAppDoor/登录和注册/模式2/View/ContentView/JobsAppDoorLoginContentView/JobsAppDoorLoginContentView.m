//
//  LoginContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorLoginContentView.h"

@interface JobsAppDoorLoginContentView ()

@property(nonatomic,strong)UIButton *toRegisterBtn;//去注册
@property(nonatomic,strong)UILabel *titleLab;//标题
@property(nonatomic,strong)UIButton *abandonLoginBtn;//随便逛逛按钮
@property(nonatomic,strong)UIButton *sendBtn;//登录
@property(nonatomic,strong)UIButton *storeCodeBtn;//记住密码
@property(nonatomic,strong)UIButton *findCodeBtn;//忘记密码

@property(nonatomic,copy)MKDataBlock loginContentViewBlock;
@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyleModel *>*loginDoorInputViewBaseStyleModelMutArr;

@end

@implementation JobsAppDoorLoginContentView

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = Cor1;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)makeInputView{
    for (int i = 0; i < self.loginDoorInputViewBaseStyleModelMutArr.count; i++) {
        JobsAppDoorInputViewBaseStyle_3 *inputView = JobsAppDoorInputViewBaseStyle_3.new;
        [self.loginDoorInputViewBaseStyleMutArr addObject:inputView];
        [inputView richElementsInViewWithModel:self.loginDoorInputViewBaseStyleModelMutArr[i]];
        @weakify(self)
        [inputView actionBlockDoorInputViewStyle_3:^(id data) {
            @strongify(self)
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(data);//data：监测输入字符回调 和 激活的textField
            }
        }];
        [self addSubview:inputView];
        inputView.size = CGSizeMake(self.width - self.toRegisterBtn.width - 40, ThingsHeight);
        inputView.x = 20;
        if (i == 0) {
            inputView.top = self.titleLab.bottom + 20;//20是偏移量
        }else if(i == 1){
            JobsAppDoorInputViewBaseStyle_3 *lastObj = (JobsAppDoorInputViewBaseStyle_3 *)self.loginDoorInputViewBaseStyleMutArr[i - 1];
            inputView.top = lastObj.bottom + InputViewOffset;
        }else{}
        inputView.layer.cornerRadius = ThingsHeight / 2;
        [self layoutIfNeeded];// 这句话不加，不刷新界面，placeHolder会出现异常
    }
}
//外层数据渲染
-(void)richElementsInViewWithModel:(id _Nullable)contentViewModel{
   
    self.toRegisterBtn.alpha = 1;
    self.titleLab.alpha = 1;
    [self makeInputView];
    self.abandonLoginBtn.alpha = 1;
    self.sendBtn.alpha = 1;
    self.storeCodeBtn.alpha = 1;
    self.findCodeBtn.alpha = 1;
}

-(void)actionBlockLoginContentView:(MKDataBlock)loginContentViewBlock{
    self.loginContentViewBlock = loginContentViewBlock;
}
#pragma mark —— lazyLoad
-(UIButton *)toRegisterBtn{
    if (!_toRegisterBtn) {
        _toRegisterBtn = UIButton.new;
        _toRegisterBtn.titleLabel.numberOfLines = 0;
        _toRegisterBtn.backgroundColor = kBlackColor;
        _toRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        _toRegisterBtn.alpha = 0.7f;
        [_toRegisterBtn setTitle:btnTitle2
                        forState:UIControlStateNormal];
        [_toRegisterBtn setImage:KIMG(@"用户名称")
                        forState:UIControlStateNormal];
        @weakify(self)
        [[_toRegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            [self endEditing:YES];
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(x);
            }
        }];
        [self addSubview:_toRegisterBtn];
        [_toRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.mas_equalTo(btnWidth);
        }];
        [_toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:8];
    }return _toRegisterBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"登录";
        _titleLab.textColor = kWhiteColor;
        _titleLab.font = [UIFont systemFontOfSize:20
                                           weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        _titleLab.centerX = (self.width - self.toRegisterBtn.width) / 2;
        _titleLab.top = 20;
    }return _titleLab;
}

-(UIButton *)abandonLoginBtn{
    if (!_abandonLoginBtn) {
        _abandonLoginBtn = UIButton.new;
        [_abandonLoginBtn setTitle:@"随便逛逛"
                          forState:UIControlStateNormal];
        [_abandonLoginBtn setTitleColor:kWhiteColor
                               forState:UIControlStateNormal];
        _abandonLoginBtn.titleLabel.font = [UIFont systemFontOfSize:15
                                                             weight:UIFontWeightSemibold];
        [_abandonLoginBtn.titleLabel sizeToFit];
        @weakify(self)
        [[_abandonLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(x);
            }
        }];
        [self addSubview:_abandonLoginBtn];
        _abandonLoginBtn.x = self.titleLab.x;
        _abandonLoginBtn.bottom = self.height - 30;
        _abandonLoginBtn.size = CGSizeMake(SCREEN_WIDTH / 5, 10);
    }return _abandonLoginBtn;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = UIButton.new;
        [_sendBtn setTitle:@"登录"
                   forState:UIControlStateNormal];
        _sendBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.7];
        [_sendBtn setTitleColor:kWhiteColor
                        forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15
                                                     weight:UIFontWeightSemibold];
        [_sendBtn.titleLabel sizeToFit];
        @weakify(self)
        [[_sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
        }];
        [self addSubview:_sendBtn];
        _sendBtn.x = 20;
        _sendBtn.size = CGSizeMake(self.width - self.toRegisterBtn.width - 40, ThingsHeight);
        _sendBtn.bottom = self.abandonLoginBtn.top - 10;
        [UIView cornerCutToCircleWithView:_sendBtn andCornerRadius:_sendBtn.height / 2];
    }return _sendBtn;
}
/// 记住登录成功的账号和密码
-(UIButton *)storeCodeBtn{
    if (!_storeCodeBtn) {
        _storeCodeBtn = UIButton.new;
        [_storeCodeBtn setTitle:@"记住密码"
                       forState:UIControlStateNormal];
        _storeCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                          weight:UIFontWeightRegular];
        _storeCodeBtn.selected = YES;// 默认记住密码
        [_storeCodeBtn setImage:KIMG(@"没有记住密码")
                       forState:UIControlStateNormal];
        [_storeCodeBtn setImage:KIMG(@"记住密码")
                       forState:UIControlStateSelected];
        _storeCodeBtn.titleLabel.textColor = kWhiteColor;
        [_storeCodeBtn.titleLabel sizeToFit];
        [_storeCodeBtn.titleLabel adjustsFontSizeToFitWidth];
        [self addSubview:_storeCodeBtn];
        [_storeCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            JobsAppDoorInputViewBaseStyle *inputView = (JobsAppDoorInputViewBaseStyle *)self.loginDoorInputViewBaseStyleMutArr.lastObject;
            make.left.equalTo(inputView).offset(20);
            make.top.equalTo(inputView.mas_bottom).offset(20);
        }];
        @weakify(self)
        [[_storeCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(x);
            }
        }];
    }return _storeCodeBtn;
}

-(UIButton *)findCodeBtn{
    if (!_findCodeBtn) {
        _findCodeBtn = UIButton.new;
        [_findCodeBtn setTitle:@"忘记密码"
                      forState:UIControlStateNormal];
        _findCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                         weight:UIFontWeightRegular];
        _findCodeBtn.titleLabel.textColor = kWhiteColor;
        [_findCodeBtn.titleLabel sizeToFit];
        [_findCodeBtn.titleLabel adjustsFontSizeToFitWidth];
        [self addSubview:_findCodeBtn];
        [_findCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            JobsAppDoorInputViewBaseStyle *inputView = (JobsAppDoorInputViewBaseStyle *)self.loginDoorInputViewBaseStyleMutArr.lastObject;
            make.right.equalTo(inputView).offset(-20);
            make.top.equalTo(inputView.mas_bottom).offset(15);
        }];
        @weakify(self)
        [[_findCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(x);
            }
        }];
    }return _findCodeBtn;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyleModel *> *)loginDoorInputViewBaseStyleModelMutArr{
    if (!_loginDoorInputViewBaseStyleModelMutArr) {
        _loginDoorInputViewBaseStyleModelMutArr = NSMutableArray.array;
        
        JobsAppDoorInputViewBaseStyleModel *用户名 = JobsAppDoorInputViewBaseStyleModel.new;
        用户名.leftViewIMG = KIMG(@"用户名称");
        用户名.placeHolderStr = @"用户名";
        用户名.isShowDelBtn = YES;
        用户名.isShowSecurityBtn = NO;
        用户名.returnKeyType = UIReturnKeyDone;
        用户名.keyboardAppearance = UIKeyboardAppearanceAlert;
        用户名.leftViewMode = UITextFieldViewModeAlways;
        [_loginDoorInputViewBaseStyleModelMutArr addObject:用户名];
        
        JobsAppDoorInputViewBaseStyleModel *密码 = JobsAppDoorInputViewBaseStyleModel.new;
        密码.leftViewIMG = KIMG(@"Lock");
        密码.placeHolderStr = @"密码";
        密码.isShowDelBtn = YES;
        密码.isShowSecurityBtn = YES;
        密码.selectedSecurityBtnIMG = KIMG(@"codeEncode");//闭眼
        密码.unSelectedSecurityBtnIMG =KIMG(@"codeDecode");//开眼
        密码.returnKeyType = UIReturnKeyDone;
        密码.keyboardAppearance = UIKeyboardAppearanceAlert;
        密码.leftViewMode = UITextFieldViewModeAlways;
        [_loginDoorInputViewBaseStyleModelMutArr addObject:密码];
        
    }return _loginDoorInputViewBaseStyleModelMutArr;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyle *> *)loginDoorInputViewBaseStyleMutArr{
    if (!_loginDoorInputViewBaseStyleMutArr) {
        _loginDoorInputViewBaseStyleMutArr = NSMutableArray.array;
    }return _loginDoorInputViewBaseStyleMutArr;
}

@end
