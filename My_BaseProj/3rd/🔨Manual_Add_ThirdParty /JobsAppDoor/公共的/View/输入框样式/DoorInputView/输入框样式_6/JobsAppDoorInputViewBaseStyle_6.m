//
//  JobsAppDoorInputViewBaseStyle_6.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/20.
//

#import "JobsAppDoorInputViewBaseStyle_6.h"

@interface JobsAppDoorInputViewBaseStyle_6 ()
<
UITextFieldDelegate
>
//UI
@property(nonatomic,strong)JobsMagicTextField *tf;
@property(nonatomic,strong)AuthCodeLab *authCodeLab;
//Data
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;
@property(nonatomic,copy)MKDataBlock doorInputViewStyle_6Block;

@end

@implementation JobsAppDoorInputViewBaseStyle_6

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kClearColor;
        [UIView colourToLayerOfView:self
                         withColour:kWhiteColor
                     andBorderWidth:1];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [UIView appointCornerCutToCircleWithTargetView:self.authCodeLab
                                 byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                       cornerRadii:CGSizeMake(self.authCodeLab.height / 2, self.authCodeLab.height / 2)];
    [UIView setBorderWithView:self.authCodeLab
                  borderColor:kWhiteColor
                  borderWidth:1
                   borderType:UIBorderSideTypeLeft];
}

-(void)block:(JobsMagicTextField *)textField
       value:(NSString *)value{
    JobsAppDoorInputViewTFModel *InputViewTFModel = JobsAppDoorInputViewTFModel.new;
    InputViewTFModel.resString = value;
    
    Ivar ivar = class_getInstanceVariable([JobsMagicTextField class], "_placeholderAnimationLbl");//必须是下划线接属性
    UILabel *label = object_getIvar(textField, ivar);

    if (self.doorInputViewStyle_6Block) {
        self.doorInputViewStyle_6Block(@{@"PlaceHolder":label.text,
                                         @"TFResModel":InputViewTFModel});
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(JobsMagicTextField *)textField{
    return YES;
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
    //实时更新后就不需要捕获终值
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField
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
    [self block:textField
          value:resString];
    return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(JobsMagicTextField *)textField
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(JobsMagicTextField *)textField{
    [self endEditing:YES];
    [self block:textField
          value:textField.text];
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
    self.authCodeLab.alpha = 1;
    self.tf.alpha = 1;
}

-(void)actionBlockDoorInputViewStyle_6:(MKDataBlock)doorInputViewStyle_6Block{
    self.doorInputViewStyle_6Block = doorInputViewStyle_6Block;
}
#pragma mark —— lazyLoad
-(AuthCodeLab *)authCodeLab{
    if (!_authCodeLab) {
        _authCodeLab = AuthCodeLab.new;
        _authCodeLab.textAlignment = NSTextAlignmentCenter;
        _authCodeLab.text = @"ss";
        _authCodeLab.font = kFontSize(16);
        _authCodeLab.alpha = 0.7;
        _authCodeLab.textColor = kWhiteColor;
        _authCodeLab.backgroundColor = kBlackColor;

        [self addSubview:_authCodeLab];
        [_authCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self);
            make.width.mas_equalTo(80);
        }];
    }return _authCodeLab;
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
        _tf.placeHolderOffset = 20;
        _tf.moveDistance = 40;
        
        [self addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.right.equalTo(self.authCodeLab.mas_left).offset(-3);
        }];
    }return _tf;
}


@end
