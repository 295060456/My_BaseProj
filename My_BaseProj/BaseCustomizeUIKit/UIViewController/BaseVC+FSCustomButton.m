//
//  BaseVC+FSCustomButton.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+FSCustomButton.h"
#import <objc/runtime.h>

@implementation BaseVC (FSCustomButton)

static char *BaseVC_FSCustomButton_backBtn;
@dynamic backBtn;

#pragma mark —— 子类需要覆写
-(void)backBtnClickEvent:(UIButton *)sender{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
}
#pragma mark —— lazyLoad
-(FSCustomButton *)backBtn{
    FSCustomButton *BackBtn = objc_getAssociatedObject(self, BaseVC_FSCustomButton_backBtn);
    if (!BackBtn) {
        BackBtn = FSCustomButton.new;
        BackBtn.buttonImagePosition = FSCustomButtonImagePositionLeft;
        [BackBtn setTitleColor:kWhiteColor
                       forState:UIControlStateNormal];
        [BackBtn setTitle:@"返回"
                  forState:UIControlStateNormal];
        [BackBtn setImage:kIMG(@"back_white")
                  forState:UIControlStateNormal];
        [BackBtn addTarget:self
                     action:@selector(backBtnClickEvent:)
           forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(self,
                                 BaseVC_FSCustomButton_backBtn,
                                 BackBtn,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BackBtn;
}

@end
