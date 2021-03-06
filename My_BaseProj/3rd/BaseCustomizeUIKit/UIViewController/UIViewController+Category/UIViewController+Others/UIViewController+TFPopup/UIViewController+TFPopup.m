//
//  UIViewController+TFPopup.m
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import "UIViewController+TFPopup.h"
#import <objc/runtime.h>

@implementation UIViewController (TFPopup)

static char *UIViewController_TFPopup_param = "UIViewController_TFPopup_param";
@dynamic param;

#pragma mark —— @property(nonatomic,strong)TFPopupParam *param;
-(TFPopupParam *)param{
    TFPopupParam *Param = objc_getAssociatedObject(self, UIViewController_TFPopup_param);
    if (!Param) {
        Param = TFPopupParam.new;
        objc_setAssociatedObject(self,
                                 UIViewController_TFPopup_param,
                                 Param,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Param;
}

-(void)setParam:(TFPopupParam *)param{
    objc_setAssociatedObject(self,
                             UIViewController_TFPopup_param,
                             param,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
