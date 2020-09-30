//
//  AgreementView.m
//  Shooting
//
//  Created by Jobs on 2020/9/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AgreementView.h"

@interface AgreementView ()

@property(nonatomic,strong)YYLabel *yylab;
@property(nonatomic,assign)BOOL isOk;
@property(nonatomic,copy)MKDataBlock agreementViewBtnBlock;
@property(nonatomic,copy)MKDataBlock agreementViewLinkBlock;

@end

@implementation AgreementView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOk) {
        self.agreementBtn.alpha = 1;
        self.yylab.alpha = 1;
        self.isOk = YES;
    }
}

-(void)actionAgreementViewBtnBlock:(MKDataBlock)agreementViewBtnBlock{
    _agreementViewBtnBlock = agreementViewBtnBlock;
}

-(void)actionAgreementViewLinkBlock:(MKDataBlock)agreementViewLinkBlock{
    _agreementViewLinkBlock = agreementViewLinkBlock;
}
#pragma mark —— lazyLoad
-(UIButton *)agreementBtn{
    if (!_agreementBtn) {
        _agreementBtn = UIButton.new;
        [_agreementBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                       imageTitleSpace:10];
        _agreementBtn.selected = YES;
        [_agreementBtn setTitle:@"已阅读并同意"
                       forState:UIControlStateNormal];
        [_agreementBtn setImage:KIMG(@"状态未选中")
                       forState:UIControlStateNormal];
        [_agreementBtn setImage:KIMG(@"状态选中")
                       forState:UIControlStateSelected];
        _agreementBtn.titleLabel.font = [UIFont systemFontOfSize:10.2
                                                          weight:UIFontWeightRegular];
        _agreementBtn.titleLabel.textColor = RGBCOLOR(78, 110, 255);
        [_agreementBtn sizeToFit];
        [_agreementBtn.titleLabel adjustsFontSizeToFitWidth];
        @weakify(self)
        [[_agreementBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.agreementViewBtnBlock) {
                self.agreementViewBtnBlock(x);
            }
        }];
        [self addSubview:_agreementBtn];
        [_agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
        }];
    }return _agreementBtn;
}

-(YYLabel *)yylab{
    if (!_yylab) {
        _yylab = YYLabel.new;
        NSString *str = @"上传须知";
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        [text setTextHighlightRange:NSMakeRange(0, 4)
                              color:RGBCOLOR(78, 88, 110)
                    backgroundColor:kWhiteColor
                          tapAction:^(UIView * _Nonnull containerView,
                                      NSAttributedString * _Nonnull text,
                                      NSRange range,
                                      CGRect rect) {

            if (self.agreementViewLinkBlock) {
                self.agreementViewLinkBlock(@1);
            }
        }];

        _yylab.attributedText = text;
        
        _yylab.font = [UIFont systemFontOfSize:10.2
                                        weight:UIFontWeightRegular];
        _yylab.textColor = RGBCOLOR(78, 110, 255);
        [self addSubview:_yylab];
        [_yylab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.agreementBtn.mas_right).offset(5);
            make.top.bottom.right.equalTo(self);
        }];
    }return _yylab;
}

@end
