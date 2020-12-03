//
//  UBLRetrievePasswordTBVCell.m
//  UBLLive
//
//  Created by Jobs on 2020/11/26.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "UBLRetrievePasswordTBVCell.h"

@interface UBLRetrievePasswordTBVCell ()
<
UITextFieldDelegate
>

@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,strong)ZYTextField *tf;
@property(nonatomic,strong)NSString *placeholder;
@property(nonatomic,strong)NSMutableArray <RichLabelDataStringsModel *>*richLabelDataStringsForPlaceHolderMutArr;
@property(nonatomic,copy)MKDataBlock retrievePasswordTBVCellBlock;

@end

@implementation UBLRetrievePasswordTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    UBLRetrievePasswordTBVCell *cell = (UBLRetrievePasswordTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[UBLRetrievePasswordTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }return cell;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.tf.alpha = 1;
        self.isOK = YES;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //重设textLabel的frame
    self.textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [self.textLabel sizeToFit];
    self.textLabel.centerY = self.contentView.centerY;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 119 / 2;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        self.placeholder = dic[@"placeHolder"];
        self.textLabel.text = dic[@"title"];
        
        if ([dic[@"title"] isEqualToString:@"手机号码"]) {
            self.tf.keyboardType = UIKeyboardTypePhonePad;
        }else if ([dic[@"title"] isEqualToString:@"邮箱"]){
            self.tf.keyboardType = UIKeyboardTypeEmailAddress;
        }else{}
    }
}

-(void)actionBlockRetrievePasswordTBVCell:(MKDataBlock)retrievePasswordTBVCellBlock{
    self.retrievePasswordTBVCellBlock = retrievePasswordTBVCellBlock;
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人在指定的文本字段中开始编辑
//- (void)textFieldDidBeginEditing:(UITextField *)textField{}
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [textField isEmptyText];
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

    NSLog(@"resString = %@",resString);
    if (self.retrievePasswordTBVCellBlock) {
        self.retrievePasswordTBVCellBlock(@{
            @"ResString":resString,
            @"TextLabelContentText":self.textLabel.text
                                          });
    }return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    [self endEditing:YES];

    return YES;
}
#pragma mark —— lazyLoad
-(ZYTextField *)tf{
    if (!_tf) {
        _tf = ZYTextField.new;
        _tf.placeholder = self.placeholder;
        _tf.placeHolderOffset = 10;
        _tf.placeHolderAlignment = PlaceHolderAlignmentRight;
        _tf.ZYtextColor = RGBCOLOR(165, 166, 169);
//        _tf.attributedPlaceholder = [NSObject makeRichTextWithDataConfigMutArr:self.richLabelDataStringsForPlaceHolderMutArr];
        _tf.delegate = self;
//        _tf.cj_delegate = self;
        _tf.returnKeyType = UIReturnKeyDone;
        _tf.keyboardAppearance = UIKeyboardAppearanceAlert;
        [self.contentView addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.left.equalTo(self.textLabel.mas_right).offset(10);
            make.centerY.equalTo(self.contentView);
        }];
        [self.contentView layoutIfNeeded];
        NSLog(@"");
    }return _tf;
}

-(NSMutableArray<RichLabelDataStringsModel *> *)richLabelDataStringsForPlaceHolderMutArr{
    if (!_richLabelDataStringsForPlaceHolderMutArr) {
        _richLabelDataStringsForPlaceHolderMutArr = NSMutableArray.array;
        
        RichLabelFontModel *richLabelFontModel = RichLabelFontModel.new;
        richLabelFontModel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        richLabelFontModel.range = NSMakeRange(0, self.placeholder.length);
        
        RichLabelTextCorModel *richLabelTextCorModel = RichLabelTextCorModel.new;
        richLabelTextCorModel.cor = RGBCOLOR(165, 166, 169);
        richLabelTextCorModel.range = NSMakeRange(0, self.placeholder.length);
        
        RichLabelDataStringsModel *richLabelDataStringsModel = RichLabelDataStringsModel.new;
        richLabelDataStringsModel.dataString = self.placeholder;
        richLabelDataStringsModel.richLabelFontModel = richLabelFontModel;
        richLabelDataStringsModel.richLabelTextCorModel = richLabelTextCorModel;
        
        [_richLabelDataStringsForPlaceHolderMutArr addObject:richLabelDataStringsModel];
    }return _richLabelDataStringsForPlaceHolderMutArr;
}


@end


