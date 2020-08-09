//
//  InputView.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "InputView.h"
#import "ZYTextField.h"

@interface InputView ()
<
UITextFieldDelegate
,CJTextFieldDeleteDelegate
>

@property(nonatomic,strong)UIImageView *headerImgV;
//@property(nonatomic,strong)ZYTextField *textField;
//@property(nonatomic,strong)BSYTextFiled *textField;
@property(nonatomic,strong)UIButton *sendBtn;
@property(nonatomic,copy)MKDataBlock inputViewActionBlock;
@property(nonatomic,copy)MKDataBlock isInputtingActionBlock;

@end

@implementation InputView

-(instancetype)init{
    if (self = [super init]) {
        self.headerImgV.alpha = 1;
//        self.textField.alpha = 1;
        self.textField.isInputting = NO;
        self.isReturnBtnSelect = NO;
    }return self;
}
///发送
-(void)actionInputViewBlock:(MKDataBlock)inputViewActionBlock{
    self.inputViewActionBlock = inputViewActionBlock;
}
///删除
-(void)actionisInputtingBlock:(MKDataBlock)isInputtingActionBlock{
    self.isInputtingActionBlock = isInputtingActionBlock;
}

-(void)sendBtnClickEvent:(UIButton *)sender{
    self.textField.isInputting = NO;
    [self.textField endEditing:YES];
    //_textField.enablesReturnKeyAutomatically = YES;的时候，以下block 无意义
    if (!self.textField.enablesReturnKeyAutomatically) {
        if (self.inputViewActionBlock) {
            self.inputViewActionBlock(self.textField);
        }
    }
}

-(void)showSendBtn{
    self.sendBtn.alpha = 1;
    [UIView animateWithDuration:3
                     animations:^{
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImgV.mas_right).offset(SCALING_RATIO(13));
            make.top.bottom.equalTo(self.headerImgV);
            make.right.equalTo(self.sendBtn.mas_left).offset(SCALING_RATIO(-13));
        }];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideSendBtn{
    self.sendBtn.alpha = 0;
    [UIView animateWithDuration:3
                     animations:^{
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImgV.mas_right).offset(SCALING_RATIO(13));
            make.top.bottom.equalTo(self.headerImgV);
            make.right.equalTo(self).offset(SCALING_RATIO(-13));
        }];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark —— CJTextFieldDeleteDelegate
- (void)cjTextFieldDeleteBackward:(ZYTextField *)textField{//已经删除的结果
    self.textField.isInputting = YES;
    if ([NSString isNullString:textField.text] && self.sendBtn.alpha) {
        [self hideSendBtn];
    }
    if (self.isInputtingActionBlock) {
        self.isInputtingActionBlock(self.textField);
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    self.textField.text = self.tfContentStr;
    self.textField.isInputting = YES;
    if (self.isInputtingActionBlock) {
        self.isInputtingActionBlock(self.textField);
    }return YES;
}
//告诉委托人在指定的文本字段中开始编辑
- (void)textFieldDidBeginEditing:(ZYTextField *)textField{
    self.textField.text = self.tfContentStr;
    self.textField.isInputting = YES;
    if (self.isInputtingActionBlock) {
        self.isInputtingActionBlock(self.textField);
    }
}
//询问委托人是否应在指定的文本字段中停止编辑
//- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
//}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    self.tfContentStr = textField.text;
    self.textField.isInputting = NO;
    //_textField.enablesReturnKeyAutomatically = YES;的时候，以下block 无意义
    if (!self.textField.enablesReturnKeyAutomatically) {
        if (self.inputViewActionBlock) {
            self.inputViewActionBlock(textField);
        }
    }
    if (![NSString isNullString:textField.text]) {
        [self showSendBtn];
    }else{
        [self hideSendBtn];
    }
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(ZYTextField *)textField
//                        reason:(UITextFieldDidEndEditingReason)reason{
//}
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(ZYTextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{//实现逐词搜索
    self.textField.isInputting = YES;
    if (self.isInputtingActionBlock) {
        self.isInputtingActionBlock(self.textField);
    }return YES;
}
//询问委托人是否应删除文本字段的当前内容
- (BOOL)textFieldShouldClear:(ZYTextField *)textField{
    self.textField.isInputting = YES;
    if (self.isInputtingActionBlock) {
        self.isInputtingActionBlock(self.textField);
    }return YES;;
}
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    self.textField.isInputting = NO;
    self.isReturnBtnSelect = YES;
    [self.textField endEditing:YES];
    return YES;
}
#pragma mark —— lazyLoad
-(UIImageView *)headerImgV{
    if (!_headerImgV) {
        _headerImgV = UIImageView.new;
        [_headerImgV sd_setImageWithURL:[NSURL URLWithString:@""]
                       placeholderImage:[UIImage animatedGIFNamed:@"钱袋"]];
        [UIView cornerCutToCircleWithView:_headerImgV
                          AndCornerRadius:SCALING_RATIO(34 / 2)];
        [self addSubview:_headerImgV];
        [_headerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(SCALING_RATIO(13));
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(34), SCALING_RATIO(34)));
            make.centerY.equalTo(self);
        }];
    }return _headerImgV;
}

-(ZYTextField *)textField{
    if (!_textField) {
        _textField = ZYTextField.new;
        _textField.backgroundColor = KLightGrayColor;
        _textField.returnKeyType = UIReturnKeySend;//Done按钮
        _textField.delegate = self;
        _textField.cj_delegate = self;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _textField.enablesReturnKeyAutomatically = YES;//
//        _textField.inputView;//自定义 系统的键盘你是拿不到的 一切为了安全
        _textField.placeholder = @"我也说几句...";
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerImgV.mas_right).offset(SCALING_RATIO(13));
            make.top.bottom.equalTo(self.headerImgV);
            make.right.equalTo(self).offset(SCALING_RATIO(-13));
        }];
        [UIView cornerCutToCircleWithView:_textField
                          AndCornerRadius:SCALING_RATIO(5)];
    }return _textField;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = UIButton.new;
        _sendBtn.backgroundColor = COLOR_HEX(0x1992FE, 0.7);
        _sendBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_sendBtn setTitle:@"发送"
                  forState:UIControlStateNormal];
        [_sendBtn.titleLabel sizeToFit];
        [_sendBtn addTarget:self
                     action:@selector(sendBtnClickEvent:)
           forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendBtn];
        [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.textField);
            make.right.equalTo(self).offset(SCALING_RATIO(-13));
            make.width.mas_equalTo(SCALING_RATIO(80));
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_sendBtn
                             AndCornerRadius:SCALING_RATIO(5)];
    }return _sendBtn;
}

//-(BSYTextFiled *)textField{
//    if (!_textField) {
//        _textField = [[BSYTextFiled alloc] initWithFrame:CGRectZero
//                                        showKeyBoardType:BSYPassWordType];
//        _textField.backgroundColor = KLightGrayColor;
////        _textField.delegate = self;
//        _textField.placeholder = @"我也说几句...";
//        [self addSubview:_textField];
//        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.headerImgV.mas_right).offset(SCALING_RATIO(13));
//            make.top.bottom.equalTo(self.headerImgV);
//            make.right.equalTo(self).offset(SCALING_RATIO(-13));
//        }];
//        [UIView cornerCutToCircleWithView:_textField
//                          AndCornerRadius:SCALING_RATIO(5)];
//    }return _textField;
//}

@end
