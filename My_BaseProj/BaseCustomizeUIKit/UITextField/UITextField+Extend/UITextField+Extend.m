//
//  UITextField+Extend.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/15.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "UITextField+Extend.h"

@implementation UITextField (Extend)

- (void)modifyClearButtonWithImage:(UIImage *)image{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image
            forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0.0f,
                                0.0f,
                                15.0f,
                                15.0f)];
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        self.text = @"";
    }];
    self.rightView = button;
    self.rightViewMode = UITextFieldViewModeWhileEditing;
}


@end
