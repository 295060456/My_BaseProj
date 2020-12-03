//
//  DoorInputViewStyle_2.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLDoorInputViewStyle_2.h"

@interface UBLDoorInputViewStyle_2 ()
<
UITextFieldDelegate
>

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,copy)FourDataBlock doorInputViewStyle_2Block;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLDoorInputViewStyle_2

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kClearColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        if (![NSString isNullString:self.titleStr]) {
            self.titleLab.text = self.titleStr;
        }
        self.tf.alpha = 0.5;
        self.imageCodeView.alpha = 1;
        self.isOK = YES;
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人在指定的文本字段中开始编辑
//- (void)textFieldDidBeginEditing:(ZYTextField *)textField{}
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [self.tf isEmptyText];
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason;
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
    
    if (self.doorInputViewStyle_2Block) {
        self.doorInputViewStyle_2Block(self,
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

-(void)actionBlockDoorInputViewStyle_2:(FourDataBlock)doorInputViewStyle_2Block{
    self.doorInputViewStyle_2Block = doorInputViewStyle_2Block;
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:9.6
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
            make.width.mas_equalTo(self.inputViewWidth * 0.75);
            if (![NSString isNullString:self.titleStr]) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(3);
            }else{
                make.top.equalTo(self);
            }
        }];
        [self layoutIfNeeded];
    }return _tf;
}

-(ImageCodeView *)imageCodeView{
    if (!_imageCodeView) {
        _imageCodeView = ImageCodeView.new;
        _imageCodeView.font = kFontSize(16);
        _imageCodeView.alpha = 0.7;
        _imageCodeView.bgColor = kWhiteColor;
        [self addSubview:_imageCodeView];
        [_imageCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.tf.mas_right).offset(5);
            make.right.equalTo(self);
        }];
        [self layoutIfNeeded];
        [UIView appointCornerCutToCircleWithTargetView:_imageCodeView
                                     byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                           cornerRadii:CGSizeMake(self.inputViewHeight / 2, self.inputViewHeight / 2)];
    }return _imageCodeView;
}

@end
