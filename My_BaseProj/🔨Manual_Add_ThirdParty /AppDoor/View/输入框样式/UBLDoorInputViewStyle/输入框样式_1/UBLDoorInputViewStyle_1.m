//
//  DoorInputViewStyle_2.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLDoorInputViewStyle_1.h"

@interface UBLDoorInputViewStyle_1 ()
<
UITextFieldDelegate
>

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,copy)MKDataBlock doorInputViewStyle_1CountDownBtnClickBlock;
@property(nonatomic,copy)FourDataBlock doorInputViewStyle_1Block;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLDoorInputViewStyle_1

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = KLightGrayColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        if (![NSString isNullString:self.titleStr]) {
            self.titleLab.text = self.titleStr;
        }
        self.tf.alpha = 1;
        self.time = 60;
        if (self.time) {
            self.countDownBtn.count = self.time;
        }
        self.isOK = YES;
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人在指定的文本字段中开始编辑
//- (void)textFieldDidBeginEditing:(ZYTextField *)textField;
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [self.tf isEmptyText];
    if (self.doorInputViewStyle_1Block) {
        self.doorInputViewStyle_1Block(self,
                                       textField,
                                       @"",
                                       NSStringFromSelector(_cmd));
    }
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField
//reason:(UITextFieldDidEndEditingReason)reason;
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    
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

    NSLog(@"resString = %@",resString);
    
    if (self.doorInputViewStyle_1Block) {
        self.doorInputViewStyle_1Block(self,
                                       textField,
                                       resString,
                                       NSStringFromSelector(_cmd));
    }return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    [self endEditing:YES];
    return YES;
}

-(void)actionBlockDoorInputViewStyle_1CountDownBtnClick:(MKDataBlock)doorInputViewStyle_1CountDownBtnClickBlock{
    self.doorInputViewStyle_1CountDownBtnClickBlock = doorInputViewStyle_1CountDownBtnClickBlock;
}

-(void)actionBlockdoorInputViewStyle_1:(FourDataBlock)doorInputViewStyle_1Block{
    self.doorInputViewStyle_1Block = doorInputViewStyle_1Block;
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:14
                                           weight:UIFontWeightRegular];
        _titleLab.textColor = kWhiteColor;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
        }];
    }return _titleLab;
}

-(ZYTextField *)tf{
    if (!_tf) {
        _tf = ZYTextField.new;
        _tf.placeHolderAlignment = PlaceHolderAlignmentRight;
        _tf.placeHolderOffset = 10;
        _tf.leftViewOffsetX = 20;
        _tf.ZYtextFont = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        _tf.delegate = self;
        _tf.returnKeyType = UIReturnKeyDone;
        _tf.keyboardAppearance = UIKeyboardAppearanceAlert;
        _tf.backgroundColor = kBlackColor;
        _tf.alpha = 0.7;
        [self addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.width.mas_equalTo(self.inputViewWidth * 0.7);
            if (![NSString isNullString:self.titleStr]) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(3);
            }else{
                make.top.equalTo(self);
            }
        }];
    }return _tf;
}

-(UIButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [[UIButton alloc] initWithType:CountDownBtnType_countDown
                                               runType:CountDownBtnRunType_manual
                                      layerBorderWidth:0
                                     layerCornerRadius:6
                                      layerBorderColor:nil
                                            titleColor:kWhiteColor
                                         titleBeginStr:@"获取验证码"
                                        titleLabelFont:[UIFont systemFontOfSize:12
                                               
                                                                         weight:UIFontWeightRegular]];
        _countDownBtn.titleLabelFont = kFontSize(12);
        _countDownBtn.titleColor =  [UIColor whiteColor];
        _countDownBtn.titleRuningStr = @"重新发送";
        _countDownBtn.titleLabel.numberOfLines = 0;
        _countDownBtn.titleEndStr = @"重新发送";
        _countDownBtn.backgroundColor = KLightGrayColor;
        _countDownBtn.alpha = 0.7f;
        _countDownBtn.bgCountDownColor = KLightGrayColor;//倒计时的时候此btn的背景色
        _countDownBtn.bgEndColor = KLightGrayColor;//倒计时完全结束后的背景色
        _countDownBtn.showTimeType = ShowTimeType_SS;
        _countDownBtn.countDownBtnNewLineType = CountDownBtnNewLineType_newLine;
        
        [_countDownBtn timeFailBeginFrom:self.time];//注销这句话就是手动启动，放开这句话就是自启动
        
        @weakify(self)
        [_countDownBtn actionCountDownClickEventBlock:^(id data) {
            @strongify(self)
            if (self.doorInputViewStyle_1CountDownBtnClickBlock) {
                self.doorInputViewStyle_1CountDownBtnClickBlock(data);
            }
        }];
        [self addSubview:_countDownBtn];
        [_countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-13);
            make.bottom.equalTo(self.tf.mas_bottom).offset(-5);
            make.height.mas_equalTo(self.inputViewHeight - 5);
            make.width.mas_equalTo(self.inputViewWidth * 0.27);
        }];
        
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_countDownBtn
                          AndCornerRadius:(self.inputViewHeight - 5) / 2];

//        [UIView appointCornerCutToCircleWithTargetView:_countDownBtn
//                                     byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
//                                           cornerRadii:CGSizeMake(self.inputViewHeight / 2,
//                                                                  self.inputViewHeight / 2)];

    }return _countDownBtn;
}

@end
