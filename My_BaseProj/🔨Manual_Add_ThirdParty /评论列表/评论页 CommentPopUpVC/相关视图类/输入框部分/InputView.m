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
<UITextFieldDelegate>

@property(nonatomic,strong)UIImageView *headerImgV;
@property(nonatomic,strong)ZYTextField *textField;

@end

@implementation InputView

-(instancetype)init{
    if (self = [super init]) {
        self.headerImgV.alpha = 1;
        self.textField.alpha = 1;
    }return self;
}

-(void)actionBlock:(MKDataBlock)block{
    self.block = block;
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
//告诉委托人在指定的文本字段中开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"");
}
//询问委托人是否应在指定的文本字段中停止编辑
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.block) {
        self.block(textField);
    }
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason;
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{//实现逐词搜索
    return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
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
        _textField.delegate = self;
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

@end
