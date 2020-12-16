//
//  JobsAppDoorInputViewBaseStyle_1.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorInputViewBaseStyle_1.h"

@interface JobsAppDoorInputViewBaseStyle_1 ()
<
UITextFieldDelegate
>
//UI
@property(nonatomic,strong)UIButton *countDownBtn;
@property(nonatomic,strong)JobsMagicTextField *tf;
//Data
@property(nonatomic,strong)NSString *titleStr_1;
@property(nonatomic,strong)NSString *titleStr_2;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;
@property(nonatomic,strong)NSMutableArray <RichLabelDataStringsModel *>*richLabelDataStringsMutArr;
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)MKDataBlock doorInputViewStyle_1Block;

@end

@implementation JobsAppDoorInputViewBaseStyle_1

- (instancetype)init{
    if (self = [super init]) {
//        self.backgroundColor = kRedColor;
        self.titleStr_1 = @"点击";
        self.titleStr_2 = @"发送验证码";
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
    if (self.doorInputViewStyle_1Block) {
        self.doorInputViewStyle_1Block(textField);
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
    
    if (self.doorInputViewStyle_1Block) {
        self.doorInputViewStyle_1Block(resString);
    }return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField
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
    self.countDownBtn.alpha = 1;
    self.tf.alpha = 1;
}

-(void)actionBlockDoorInputViewStyle_1:(MKDataBlock)doorInputViewStyle_1Block{
    self.doorInputViewStyle_1Block = doorInputViewStyle_1Block;
}
#pragma mark —— lazyLoad
-(UIButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [[UIButton alloc] initWithRichTextRunningDataMutArr:self.richLabelDataStringsMutArr
                                                           countDownBtnType:CountDownBtnType_countDown
                                                                    runType:CountDownBtnRunType_manual
                                                           layerBorderWidth:1
                                                          layerCornerRadius:1
                                                           layerBorderColor:kClearColor
                                                                 titleColor:kWhiteColor
                                                              titleBeginStr:@""
                                                             titleLabelFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];

        _countDownBtn.titleRuningStr = @"重新发送";
        _countDownBtn.count = 60;
        _countDownBtn.showTimeType = ShowTimeType_SS;
        _countDownBtn.bgCountDownColor = kClearColor;
        _countDownBtn.cequenceForShowTitleRuningStrType = CequenceForShowTitleRuningStrType_tail;
        _countDownBtn.countDownBtnNewLineType = CountDownBtnNewLineType_newLine;

        [self addSubview:_countDownBtn];
        [_countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.mas_equalTo(80);
        }];
        
//        [UIView appointCornerCutToCircleWithTargetView:_countDownBtn
//                                     byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
//                                           cornerRadii:CGSizeMake(_countDownBtn.height / 2, _countDownBtn.height / 2)];

    }return _countDownBtn;
}

-(NSMutableArray<RichLabelDataStringsModel *> *)richLabelDataStringsMutArr{
    if (!_richLabelDataStringsMutArr) {
        _richLabelDataStringsMutArr = NSMutableArray.array;
        
        RichLabelFontModel *richLabelFontModel_1 = RichLabelFontModel.new;
        richLabelFontModel_1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        richLabelFontModel_1.range = NSMakeRange(0, self.titleStr_1.length);
        
        RichLabelFontModel *richLabelFontModel_2 = RichLabelFontModel.new;
        richLabelFontModel_2.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        richLabelFontModel_2.range = NSMakeRange(self.titleStr_1.length, self.titleStr_2.length);
        
        RichLabelTextCorModel *richLabelTextCorModel_1 = RichLabelTextCorModel.new;
        richLabelTextCorModel_1.cor = kBlueColor;
        richLabelTextCorModel_1.range = NSMakeRange(0, self.titleStr_1.length);
        
        RichLabelTextCorModel *richLabelTextCorModel_2 = RichLabelTextCorModel.new;
        richLabelTextCorModel_2.cor = kRedColor;
        richLabelTextCorModel_2.range = NSMakeRange(self.titleStr_1.length, self.titleStr_2.length);
        //////
        
        RichLabelDataStringsModel *richLabelDataStringsModel_1 = RichLabelDataStringsModel.new;
        richLabelDataStringsModel_1.dataString = self.titleStr_1;
        richLabelDataStringsModel_1.richLabelFontModel = richLabelFontModel_1;
        richLabelDataStringsModel_1.richLabelTextCorModel = richLabelTextCorModel_1;
        
        RichLabelDataStringsModel *richLabelDataStringsModel_2 = RichLabelDataStringsModel.new;
        richLabelDataStringsModel_2.dataString = self.titleStr_2;
        richLabelDataStringsModel_2.richLabelFontModel = richLabelFontModel_2;
        richLabelDataStringsModel_2.richLabelTextCorModel = richLabelTextCorModel_2;
        
        [_richLabelDataStringsMutArr addObject:richLabelDataStringsModel_1];
        [_richLabelDataStringsMutArr addObject:richLabelDataStringsModel_2];
        
    }return _richLabelDataStringsMutArr;
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
            make.top.left.bottom.equalTo(self);
            make.right.equalTo(self.countDownBtn.mas_left);
        }];
    }return _tf;
}

@end
