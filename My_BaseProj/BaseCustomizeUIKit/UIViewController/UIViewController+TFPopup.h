//
//  UIViewController+TFPopup.h
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import <UIKit/UIKit.h>

#if __has_include(<GKPageScrollView/GKPageScrollView.h>)
#import <TFPopup/TFPopup.h>
#else
#import "TFPopup.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TFPopup)

@property(nonatomic,strong)TFPopupParam *param;

@end

NS_ASSUME_NONNULL_END
