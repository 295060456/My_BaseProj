//
//  AppDelegate+PopupView.h
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import "AppDelegate.h"

#if __has_include(<TFPopup/TFPopup.h>)
#import <TFPopup/TFPopup.h>
#else
#import "TFPopup.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (PopupView)

-(void)Popupview;

@end

NS_ASSUME_NONNULL_END
