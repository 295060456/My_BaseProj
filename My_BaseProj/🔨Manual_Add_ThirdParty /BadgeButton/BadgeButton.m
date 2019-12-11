//
//  BadgeButton.m
//  ShengAi
//
//  Created by 刘赓 on 2018/11/30.
//  Copyright © 2018 刘赓. All rights reserved.
//

#import "BadgeButton.h"
#import "UIColor+YYAdd.h"
#import "NSString+Extras.h"

@interface BadgeButton()

@property(nonatomic,strong)UILabel *badgeLabel;
@property(nonatomic,assign)CGFloat badgeLabelHeight;

@end

@implementation BadgeButton

-(instancetype)initWithFrame:(CGRect)frame
                LocationType:(BadgeButtonLocationType)locationType
     BadgeLabBackgroundColor:(nullable UIColor *)backgroundColor
           BadgeLabTextColor:(nullable UIColor *)textColor
            BadgeborderColor:(nullable UIColor *)borderColor
            BadgeWithContent:(nullable NSString *)contentStr{
    
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = NO;
        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self setTitleColor:[UIColor blackColor]
                   forState:UIControlStateNormal];
        
        self.badgeLabel.layer.borderColor = [borderColor CGColor];
        self.badgeLabel.textColor = textColor;
        self.badgeLabel.backgroundColor = backgroundColor;
        self.badgeLabel.text = contentStr;
        
        //建立约束
        switch (locationType) {
            case BadgeButtonLocationType_leftTop:{
                
                [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.right.mas_equalTo(self.mas_left).mas_offset(5);
                    make.bottom.mas_equalTo(self.mas_top).mas_offset(5);
                    [NSString isNullString:contentStr] ? make.size.mas_equalTo(CGSizeMake(10,10)) : make.height.mas_equalTo(10) ;
                }];
            }
                break;
            case BadgeButtonLocationType_rightTop:{
                
                [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.mas_equalTo(self.mas_right).mas_offset(-5);
                    make.bottom.mas_equalTo(self.mas_top).mas_offset(5);
                    [NSString isNullString:contentStr] ? make.size.mas_equalTo(CGSizeMake(10,10)) : make.height.mas_equalTo(10) ;
                }];
                [self layoutIfNeeded];
            }
                break;
            default:
                break;
        }
        
        [self layoutIfNeeded];
    }
    
    return self;
}

#pragma mark ======== lazyLoad ======
-(UILabel *)badgeLabel{
    
    if (!_badgeLabel) {
        _badgeLabel = UILabel.new;
        [self addSubview:_badgeLabel];
        _badgeLabel.clipsToBounds = YES;
        _badgeLabel.adjustsFontSizeToFitWidth = YES;
        _badgeLabel.layer.cornerRadius = 10 / 2;
        _badgeLabel.font = [UIFont systemFontOfSize:10];
        _badgeLabel.layer.borderWidth = 0.5f;
        
    }
    
    return _badgeLabel;
}

#pragma mark ======== 隐藏角标 ======
-(void)hideBadge{
    
    self.badgeLabel.hidden = YES;
    
}



@end




