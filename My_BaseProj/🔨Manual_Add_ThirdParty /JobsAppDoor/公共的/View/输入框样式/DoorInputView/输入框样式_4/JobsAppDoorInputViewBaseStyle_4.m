//
//  JobsAppDoorInputViewBaseStyle_4.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorInputViewBaseStyle_4.h"

@interface JobsAppDoorInputViewBaseStyle_4 ()
<
UITextFieldDelegate
>
//UI
@property(nonatomic,strong)ImageCodeView *imageCodeView;
@property(nonatomic,strong)JobsMagicTextField *tf;
//Data
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)MKDataBlock doorInputViewStyle_4Block;

@end

@implementation JobsAppDoorInputViewBaseStyle_4

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
    if (self.doorInputViewStyle_4Block) {
        self.doorInputViewStyle_4Block(textField);
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
    
    if (self.doorInputViewStyle_4Block) {
        self.doorInputViewStyle_4Block(resString);
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
    }
}

-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel{
    self.doorInputViewBaseStyleModel = doorInputViewBaseStyleModel;
    self.imageCodeView.alpha = 1;
    self.tf.alpha = 1;
}

-(void)actionBlockDoorInputViewStyle_4:(MKDataBlock)doorInputViewStyle_4Block{
    self.doorInputViewStyle_4Block = doorInputViewStyle_4Block;
}
#pragma mark —— lazyLoad
-(ImageCodeView *)imageCodeView{
    if (!_imageCodeView) {
        _imageCodeView = ImageCodeView.new;
        _imageCodeView.font = kFontSize(16);
        _imageCodeView.alpha = 0.7;
        _imageCodeView.bgColor = kWhiteColor;
        [self addSubview:_imageCodeView];
        [_imageCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(self).offset(-10);
            make.width.mas_equalTo(80);
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_imageCodeView
                          AndCornerRadius:20];
    }return _imageCodeView;
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
        _tf.moveDistance = 35;
        _tf.placeHolderAlignment = PlaceHolderAlignmentLeft;
        _tf.placeHolderOffset = 20;
        
        [self addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.right.equalTo(self.imageCodeView.mas_left);
        }];
    }return _tf;
}

@end
