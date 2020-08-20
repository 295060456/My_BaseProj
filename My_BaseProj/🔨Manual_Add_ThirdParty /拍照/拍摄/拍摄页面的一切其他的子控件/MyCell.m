//
//  MyCell.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.icon.alpha = 1;
        self.leftText.alpha = 1;
        [UIView cornerCutToCircleWithView:self.contentView
                          AndCornerRadius:8];
    }return self;
}
#pragma mark —— lazyLoad
-(UIImageView *)icon{
    if (!_icon) {
        _icon = UIImageView.new;
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.layer.masksToBounds = YES;
        [self.contentView addSubview:_icon];
        _icon.frame = self.contentView.bounds;
    }return _icon;
}

-(UILabel *)leftText{
    if (!_leftText) {
        _leftText = UILabel.new;
        _leftText.backgroundColor = [UIColor lightGrayColor];
        _leftText.alpha = 0.8;
        _leftText.textColor = [UIColor whiteColor];
        _leftText.numberOfLines = 1;
        _leftText.textAlignment = NSTextAlignmentCenter;
        [self.icon addSubview:_leftText];
        
        _leftText.frame = CGRectMake(0,
                                     self.contentView.frame.size.height-35,
                                     self.contentView.frame.size.width,
                                     35);
    }return _leftText;
}

@end
