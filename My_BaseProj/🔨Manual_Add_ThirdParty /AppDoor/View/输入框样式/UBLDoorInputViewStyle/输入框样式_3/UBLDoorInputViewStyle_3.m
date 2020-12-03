//
//  DoorInputViewStyle_3.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLDoorInputViewStyle_3.h"

@interface UBLDoorInputViewStyle_3 ()
<
UITextFieldDelegate
>

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *securityModeBtn;
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)FourDataBlock doorInputViewStyle_3Block;

@end

@implementation UBLDoorInputViewStyle_3

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = KLightGrayColor;
        self.alpha = 0.7f;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        if (![NSString isNullString:self.titleStr]) {
            self.titleLab.text = self.titleStr;
        }
        self.tf.alpha = 1;
        if (self.isShowSecurityMode) {
            self.securityModeBtn.hidden = self.isShowSecurityMode;
            self.securityModeBtn.selected = !self.isShowSecurityMode;
            self.tf.secureTextEntry = self.isShowSecurityMode;
        }self.isOK = YES;
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{//
    NSLog(@"");
    return YES;
}
//告诉委托人在指定的文本字段中开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    NSLog(@"");
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [self.tf isEmptyText];
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField
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
    self.securityModeBtn.hidden = ![NSString isNullString:resString] || !self.isShowSecurityMode;
    
    if (self.doorInputViewStyle_3Block) {
        self.doorInputViewStyle_3Block(self,
                                       textField,
                                       resString,
                                       NSStringFromSelector(_cmd));
    }return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    [self endEditing:YES];
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"SSSSresString = %@",textField.text);
    if ([textField.placeholder isEqualToString:@"6-12位字母或数字的密码"] ||
        [textField.placeholder isEqualToString:@"确认密码"]) {
        if (textField.text.length > 0) {
            self.securityModeBtn.hidden = NO;
        } else {
            self.securityModeBtn.hidden = YES;
            
        }
    }
    //输入限制
    if (textField.text.length > self.limitLength){
        textField.text = [textField.text substringToIndex:self.limitLength];
    }
}

-(void)textFieldDidClear{
    if (self.doorInputViewStyle_3Block) {
        self.doorInputViewStyle_3Block(self,
                                       _tf,
                                       @"",
                                       NSStringFromSelector(_cmd));
    }
}

-(void)actionBlockDoorInputViewStyle_3:(FourDataBlock)doorInputViewStyle_3Block{
    self.doorInputViewStyle_3Block = doorInputViewStyle_3Block;
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:14
                                           weight:UIFontWeightRegular];
        _titleLab.textColor = kWhiteColor;
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(3);
            make.left.equalTo(self).offset(5);
        }];
    }return _titleLab;
}

-(ZYTextField *)tf{
    if (!_tf) {
        _tf = ZYTextField.new;
        _tf.placeHolderAlignment = PlaceHolderAlignmentRight;
        _tf.placeHolderOffset = 10;
        _tf.leftViewOffsetX = 20;
        _tf.rightViewOffsetX = 15;
        _tf.ZYtextFont = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        _tf.delegate = self;
        _tf.backgroundColor = kBlackColor;
        _tf.alpha = 0.7f;
        _tf.returnKeyType = UIReturnKeyDone;
        _tf.keyboardAppearance = UIKeyboardAppearanceAlert;
        _tf.keyboardType = UIKeyboardTypeASCIICapable;
        [self addSubview:_tf];
        [_tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
            make.bottom.equalTo(self);
            make.width.mas_equalTo(self.inputViewWidth * 0.86);
            if (![NSString isNullString:self.titleStr]) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(3);
            }else{
                make.top.equalTo(self).offset(3);
            }
        }];
    }return _tf;
}

-(UIButton *)securityModeBtn{
    if (!_securityModeBtn) {
        _securityModeBtn = UIButton.new;
        _securityModeBtn.hidden = YES;
        [_securityModeBtn setImage:KIMG(@"codeDecode")
                          forState:UIControlStateNormal];
        [_securityModeBtn setImage:KIMG(@"codeEncode")
                          forState:UIControlStateSelected];
        @weakify(self) 
        [[_securityModeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.tf.secureTextEntry = x.selected;
            x.selected = !x.selected;
        }];
        [self addSubview:_securityModeBtn];
        [_securityModeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.equalTo(self);
        }];
        [self layoutIfNeeded];
    }return _securityModeBtn;
}

-(NSInteger)limitLength{
    if (_limitLength == 0) {
        _limitLength = 10;
    }return _limitLength;
}

@end
