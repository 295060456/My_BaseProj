//
//  Pods.h
//  My_BaseProj
//
//  Created by 刘赓 on 2019/9/26.
//  Copyright © 2019 Corp. All rights reserved.
//

#ifndef Pods_h
#define Pods_h

#if DEBUG

#if __has_include(<FBRetainCycleDetector/FBRetainCycleDetector.h>)
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>
#else
#import "FBRetainCycleDetector.h"
#endif

#if __has_include(<DoraemonManager/DoraemonManager.h>)
#import <DoraemonKit/DoraemonManager.h>
#else
#import "DoraemonManager.h"
#endif

#endif

#if __has_include(<IQKeyboardManager/IQKeyboardManager.h>)
#import <IQKeyboardManager/IQKeyboardManager.h>
#else
#import "IQKeyboardManager.h"
#endif

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#if __has_include(<Reachability/Reachability.h>)
#import <Reachability/Reachability.h>
#else
#import "Reachability.h"//检查联网情况
#endif

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
#import "SDWebImage.h"
#endif

#if __has_include(<MJExtension/MJExtension.h>)
#import <MJExtension/MJExtension.h>
#else
#import "MJExtension.h"
#endif

#if __has_include(<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif

#if __has_include(<SPAlertController/SPAlertController.h>)
#import <SPAlertController/SPAlertController.h>
#else
#import "SPAlertController.h"
#endif

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

#if __has_include(<BRPickerView/BRPickerView.h>)
#import <BRPickerView/BRPickerView.h>
#else
#import "BRPickerView.h"
#endif

#if __has_include(<JXCategoryView/JXCategoryView.h>)
#import <JXCategoryView/JXCategoryView.h>
#else
#import "JXCategoryView.h"
#endif

#if __has_include(<JXPagingView/JXPagerView.h>)
#import <JXPagingView/JXPagerView.h>
#else
#import "JXPagerView.h"
#endif

#if __has_include(<JPImageresizerView/JPImageresizerView.h>)
#import <JPImageresizerView/JPImageresizerView.h>
#else
#import "JPImageresizerView.h"
#endif

#if __has_include(<GKNavigationBar/GKNavigationBar.h>)
#import <GKNavigationBar/GKNavigationBar.h>
#else
#import "GKNavigationBar.h"
#endif

#if __has_include(<GKPageScrollView/GKPageScrollView.h>)
#import <TFPopup/TFPopup.h>
#else
#import "TFPopup.h"
#endif

#if __has_include(<PPBadgeView/PPBadgeView.h>)
#import <PPBadgeView/PPBadgeView.h>
#else
#import "PPBadgeView.h"
#endif

#if __has_include(<LYEmptyViewHeader/LYEmptyViewHeader.h>)
#import <LYEmptyViewHeader/LYEmptyViewHeader.h>
#else
#import "LYEmptyViewHeader.h"
#endif

#if __has_include(<Masonry/Masonry.h>)
#import <WHToast/WHToast.h>
#else
#import "WHToast.h"
#endif

#import <Shimmer/Shimmer-umbrella.h>

//WebSocket
#import "GCDAsyncSocket.h" // for TCP
#import "GCDAsyncUdpSocket.h" // for UDP
//MQTT
#if __has_include(<MQTTClient/MQTTClient.h>)
#import <MQTTClient/MQTTClient.h>
#else
#import "MQTTClient.h"
#endif

#pragma mark —— ZFPlayer 播放器相关
//Core
#import "ZFPlayer.h"
//AVPlayer
#import <ZFPlayer/ZFAVPlayerManager.h>
//ijkplayer
#import <ZFPlayer/ZFIJKPlayerManager.h>
//ControlView
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/ZFLandScapeControlView.h>
#import <ZFPlayer/ZFLoadingView.h>
#import <ZFPlayer/ZFNetworkSpeedMonitor.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFPortraitControlView.h>
#import <ZFPlayer/ZFSliderView.h>
#import <ZFPlayer/ZFSmallFloatControlView.h>
#import <ZFPlayer/ZFSpeedLoadingView.h>
#import <ZFPlayer/ZFUtilities.h>
#import <ZFPlayer/ZFVolumeBrightnessView.h>

#import "AYCheckManager.h"
#import "BEMCheckBox.h"
#import "DDProgressView.h"
#import "FLEX.h"
#import "FMDB.h"
#import "HCSStarRatingView.h"
#import "BSYTextFiled.h"
#import "NJKWebViewProgress.h"
#import "OpenUDID.h"
#import "POP.h"
#import "TXScrollLabelView.h"
#import "AwesomeMenu.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import <HBDNavigationBar/HBDNavigationController.h>
#import "TZImagePickerController.h"
#import <YYKit/YYKit.h>
#import "JJStockView.h"
#import "TKCarouselView.h"
#import "UIViewController+CWLateralSlide.h"
#import "YQImageCompressTool.h"
#import <TXFileOperation.h>
#import "SZTextView.h"
#import <Lottie/Lottie.h>
#import "XHLaunchAd.h"

//#import "PureLayout.h"
//#import "MyLayout.h"
//#import "TRCustomAlert.h"
//#import "GPUImage.h"
//#import <LKDBHelper.h>
//#import "LBXScanView.h"
//#import <YYText/YYText.h>
//#import "ZXingObjC.h"
//#import "SVProgressHUD.h"//和sceneDelegate冲突
//#import <AsyncDisplayKit/AsyncDisplayKit.h>
//#import "PGBanner.h"
//#import "PINCache.h"
//#import "PINOperation.h"
//#import "PINRemoteImage.h"//支持带标记的图片后处理。对于同一张图片，当需要不同的后处理方式时（a 界面需要正圆角，b 界面需要小幅度的圆角），尤为有用 https://juejin.im/post/5a96a9b4f265da4e7f35d24e#heading-4

#endif /* Pods_h */
