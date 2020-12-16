//
//  JobsAppDoorInputViewBaseStyle_3.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorInputViewBaseStyle_3.h"

@interface JobsAppDoorInputViewBaseStyle_3 ()
<
UITextFieldDelegate
>
//UI
@property(nonatomic,strong)UIButton *securityModeBtn;
@property(nonatomic,strong)JobsMagicTextField *tf;
//Data
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)MKDataBlock doorInputViewStyle_3Block;

@end

@implementation JobsAppDoorInputViewBaseStyle_3

- (instancetype)init{
    if (self = [super init]) {
//        self.backgroundColor = kRedColor;
        [UIView colourToLayerOfView:self
                         WithColour:kWhiteColor
                     AndBorderWidth:1];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        
        self.isOK = YES;
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(JobsMagicTextField *)textField{
    if (self.doorInputViewStyle_3Block) {
        self.doorInputViewStyle_3Block(textField);
    }return YES;
}
//告诉委托人在指定的文本字段中开始编辑
- (void)textFieldDidBeginEditing:(JobsMagicTextField *)textField{

}
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(JobsMagicTextField *)textField{
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(JobsMagicTextField *)textField{
    [self.tf isEmptyText];
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(JobsMagicTextField *)textField
//reason:(UITextFieldDidEndEditingReason)reason{}
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(JobsMagicTextField *)textField
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
    
    if (self.doorInputViewStyle_3Block) {
        self.doorInputViewStyle_3Block(resString);
    }return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(JobsMagicTextField *)textField
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(JobsMagicTextField *)textField{
    [self endEditing:YES];
    return YES;
}

- (void)textFieldDidChange:(JobsMagicTextField *)textField {
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

-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel{
    self.doorInputViewBaseStyleModel = doorInputViewBaseStyleModel;
    self.securityModeBtn.alpha = 1;
    self.tf.alpha = 1;
}

-(void)actionBlockDoorInputViewStyle_3:(MKDataBlock)doorInputViewStyle_3Block{
    self.doorInputViewStyle_3Block = doorInputViewStyle_3Block;
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

-(JobsMagicTextField *)tf{
    if (!_tf) {
        _tf = JobsMagicTextField.new;
        _tf.delegate = self;
        _tf.leftView = [[UIImageView alloc] initWithImage:self.doorInputViewBaseStyleModel.leftViewIMG];
        _tf.leftViewMode = self.doorInputViewBaseStyleModel.leftViewMode;
        _tf.placeholder = self.doorInputViewBaseStyleModel.placeHolderStr;
        _tf.returnKeyType = self.doorInputViewBaseStyleModel.returnKeyType;
        _tf.keyboardAppearance = self.doorInputViewBaseStyleModel.keyboardAppearance;

        _tf.animationColor = kWhiteColor;
        _tf.placeHolderAlignment = PlaceHolderAlignmentLeft;
        _tf.moveDistance = 40;
        _tf.placeHolderOffset = 20;
        
        [self addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.right.equalTo(self.securityModeBtn.mas_left);
        }];
    }return _tf;
}


@end
