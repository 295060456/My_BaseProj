//
//  JobsAppDoorInputViewBaseStyle_5.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import "JobsAppDoorInputViewBaseStyle_5.h"

@implementation JobsAppDoorInputViewTFModel

@end

@interface JobsAppDoorInputViewBaseStyle_5 ()
<
UITextFieldDelegate
>
// UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)ZYTextField *tf;
@property(nonatomic,strong)UIButton *authCodeBtn;
@property(nonatomic,strong)UIButton *securityModeBtn;
// Data
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;
@property(nonatomic,copy)MKDataBlock doorInputViewStyle_5Block;

@end

@implementation JobsAppDoorInputViewBaseStyle_5

-(void)dealloc{
    [_authCodeBtn timerDestroy];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    // 指定描边
    [UIView setBorderWithView:self
                  borderColor:COLOR_RGB(162, 162, 162, 0.2f)
                  borderWidth:1
                   borderType:UIBorderSideTypeBottom];
}
// 外层数据渲染
-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel{
    self.doorInputViewBaseStyleModel = doorInputViewBaseStyleModel;
    self.titleLab.alpha = 1;

    switch (self.style_5) {
        case InputViewStyle_5_1:{
            self.authCodeBtn.alpha = 1;
        }break;
        case InputViewStyle_5_2:{
            
        }break;
        default:
            break;
    }
    
    self.tf.alpha = 1;
}

-(void)block:(ZYTextField *)textField
       value:(NSString *)value{
    JobsAppDoorInputViewTFModel *InputViewTFModel = JobsAppDoorInputViewTFModel.new;
    InputViewTFModel.resString = value;
    if (self.doorInputViewStyle_5Block) {
        self.doorInputViewStyle_5Block(@{@"PlaceHolder":textField.placeholder,
                                         @"TFResModel":InputViewTFModel});
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人在指定的文本字段中开始编辑
- (void)textFieldDidBeginEditing:(ZYTextField *)textField{

}
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [self.tf isEmptyText];
    //实时更新后就不需要捕获终值
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(JobsMagicTextField *)textField
//reason:(UITextFieldDidEndEditingReason)reason{}
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(ZYTextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
    NSLog(@"textField.text = %@",textField.text);
    NSLog(@"string = %@",string);
    
#warning 过滤删除最科学的做法
    
    NSString *resString = nil;
    //textField.text 有值 && string无值 ————> 删除操作
    if (![NSString isNullString:textField.text] && [NSString isNullString:string]) {
        
        if (textField.text.length == 1) {
            resString = @"";
        }else{
            resString = [textField.text substringToIndex:(textField.text.length - 1)];//去掉最后一个
        }
    }
    //textField.text 无值 && string有值 ————> 首字符输入
    if ([NSString isNullString:textField.text] && ![NSString isNullString:string]) {
        resString = string;
    }
    //textField.text 有值 && string有值 ————> 非首字符输入
    if (![NSString isNullString:textField.text] && ![NSString isNullString:string]) {
        resString = [textField.text stringByAppendingString:string];
    }

    NSLog(@"SSSresString = %@",resString);
    self.securityModeBtn.hidden = ![NSString isNullString:resString] || !self.doorInputViewBaseStyleModel.isShowSecurityBtn;
    [self block:textField
          value:resString];
    return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(JobsMagicTextField *)textField
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    [self endEditing:YES];
    [self block:textField
          value:textField.text];
    return YES;
}

- (void)textFieldDidChange:(ZYTextField *)textField {
    NSLog(@"SSSSresString = %@",textField.text);
    if ([textField.placeholder isEqualToString:@"6-12位字母或数字的密码"] ||
        [textField.placeholder isEqualToString:@"确认密码"]) {
        if (textField.text.length > 0) {
            self.securityModeBtn.hidden = NO;
        } else {
            self.securityModeBtn.hidden = YES;
        }
    }
}
// 监测输入字符回调 和 激活的textField
-(void)actionBlockDoorInputViewStyle_5:(MKDataBlock)doorInputViewStyle_5Block{
    self.doorInputViewStyle_5Block = doorInputViewStyle_5Block;
}
#pragma mark —— lazyLoad
-(UIButton *)securityModeBtn{
    if (!_securityModeBtn) {
        _securityModeBtn = UIButton.new;
        [_securityModeBtn setImage:self.doorInputViewBaseStyleModel.selectedSecurityBtnIMG
                          forState:UIControlStateNormal];
        [_securityModeBtn setImage:self.doorInputViewBaseStyleModel.unSelectedSecurityBtnIMG
                          forState:UIControlStateSelected];
        @weakify(self)
        [[_securityModeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            self.tf.secureTextEntry = x.selected;
        }];
        [self addSubview:_securityModeBtn];
        [_securityModeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.mas_equalTo(40);
        }];
    }return _securityModeBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.doorInputViewBaseStyleModel.titleLabStr;
        _titleLab.textColor = self.doorInputViewBaseStyleModel.titleStrCor;
        _titleLab.font = self.doorInputViewBaseStyleModel.titleStrFont;
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(50);
        }];
    }return _titleLab;
}

-(UIButton *)authCodeBtn{
    if (!_authCodeBtn) {
        _authCodeBtn = [[UIButton alloc] initWithType:CountDownBtnType_countDown
                                               runType:CountDownBtnRunType_manual
                                      layerBorderWidth:0
                                     layerCornerRadius:0
                                      layerBorderColor:nil
                                            titleColor:kWhiteColor
                                         titleBeginStr:@"发送验证码"
                                        titleLabelFont:[UIFont systemFontOfSize:8
                                                                         weight:UIFontWeightRegular]];
        _authCodeBtn.titleBeginStr = @"发送验证码";
        _authCodeBtn.titleRuningStr = @"重新发送 ";
        _authCodeBtn.titleEndStr = @"重新发送";
        _authCodeBtn.backgroundColor = KLightGrayColor;
        _authCodeBtn.titleColor = kWhiteColor;
        _authCodeBtn.bgCountDownColor = KLightGrayColor;//倒计时的时候此btn的背景色
        _authCodeBtn.bgEndColor = KLightGrayColor;//倒计时完全结束后的背景色
        _authCodeBtn.showTimeType = ShowTimeType_SS;
        _authCodeBtn.titleLabelFont = [UIFont systemFontOfSize:8
                                                        weight:UIFontWeightRegular];
        
        [_authCodeBtn timeFailBeginFrom:60];//注销这句话就是手动启动，放开这句话就是自启动
        
//        @weakify(self)
        [_authCodeBtn actionCountDownClickEventBlock:^(id data) {
//            @strongify(self)
            NSLog(@"MMP");
        }];
        
        [self addSubview:_authCodeBtn];
        [_authCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-50);
            make.bottom.equalTo(self.tf);
            make.size.mas_equalTo(CGSizeMake(78, 25));
        }];
        [UIView cornerCutToCircleWithView:_authCodeBtn
                          andCornerRadius:25 / 2];
    }return _authCodeBtn;
}

-(ZYTextField *)tf{
    if (!_tf) {
        _tf = ZYTextField.new;
        _tf.placeholder = self.doorInputViewBaseStyleModel.placeHolderStr;
        _tf.delegate = self;
        _tf.placeHolderAlignment = self.doorInputViewBaseStyleModel.placeHolderAlignment;
        _tf.placeHolderOffset = self.doorInputViewBaseStyleModel.placeHolderOffset;
        _tf.ZYtextColor = self.doorInputViewBaseStyleModel.ZYtextColor;
        _tf.leftViewOffsetX = self.doorInputViewBaseStyleModel.leftViewOffsetX;
        _tf.offset = self.doorInputViewBaseStyleModel.offset;
        
        [self addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab);
            make.top.equalTo(self.titleLab.mas_bottom);
            make.bottom.equalTo(self).offset(-8);
            
            switch (self.style_5) {
                case InputViewStyle_5_1:{
                    make.right.equalTo(self.authCodeBtn.mas_left);
                }break;
                case InputViewStyle_5_2:{
                    make.right.equalTo(self);
                }break;
                default:
                    break;
            }
            
        }];
    }return _tf;
}

@end
