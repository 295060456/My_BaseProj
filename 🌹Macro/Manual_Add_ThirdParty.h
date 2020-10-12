//
//  Manual_Add_ThirdParty.h
//  My_BaseProj
//
//  Created by 刘赓 on 2019/9/26.
//  Copyright © 2019 Corp. All rights reserved.
//

#ifndef Manual_Add_ThirdParty_h
#define Manual_Add_ThirdParty_h

#import "UIButton+ImageTitleSpacing.h"
#import "AABlock.h"
#import "YBNotificationManager.h"
#import "LongPressToDeleteImageView.h"
#import "RYCuteView.h"
#import "XWCountryCodeController.h"
#import "HAHandleDemoView.h"
#import "SDCycleScrollView.h"
#import "SoundBtn.h"
#import "LXTagsView.h"
#import "TouchID.h"
#import "UIButton+CountDownBtn.h"
#import "XDSDropDownMenu.h"
#import "XLSphereView.h"
#import "UICountingLabel.h"//数字可以一直变化到指定值的UILable
#import "AnimateToSpecifiedDateView.h"
#import "PlaySound.h"//播放自定义声音关键代码
#import "DeleteSystemUITabBarButton.h"//移除 系统自带的 UITabBarButton
#import "ZFMRACNetworkTool.h"//网络请求 RAC+MVVM
#import "XDTextBtnView.h"//自适应文字按钮
#import "TWPageViewController.h"//https://www.jianshu.com/p/25b1a3888bb8
#import "WebViewJavascriptBridge.h"
#import "BaseNavigationVC.h"
#import "XLChannelControl.h"//https://github.com/mengxianliang/XLChannelControl
#import "ECAuthorizationTools.h"//https://github.com/EchoZuo/ECAuthorizationTools/blob/master/README.md
#import "TBCityIconFont.h"
#import "UIImage+TBCityIconFont.h"
#import "CountdownView.h"//圆形倒计时进度条（中间有字，可点击回调）
#import "NSObject+LBLaunchImage.h"
#import "HWTextCodeView.h"
#import "LMHWaterFallLayout.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "BWShareView.h"
#import "BWItemModel.h"
#import "RBCLikeButton.h"//高仿抖音点赞动画
#import "ZYTextField.h"
#import "FileFolderHandleTool.h"
//#import "SDWebImageWebP_umbrella.h"
//#import "YYTimer+Block.h"
#import "EmptyView.h"
#import "UIViewController+InteractivePushGesture.h"
#import "SuspendBtn.h"
#import "SuspendLab.h"
#import "SuspendView.h"
#import "MonitorNetwoking.h"
#import "JhtBannerView.h"
#import "ZZCircleProgress.h"
#import "MovieCountDown.h"
#import "UIButton+CountDownBtn.h"//验证码倒计时按钮
#import "UIDevice+XMUtils.h"
#import "WGradientProgress.h"
#import "WGradientProgressView.h"

#pragma mark —— 以下是自定义的

#import "MacroDef_Sys.h"
#import "MacroDef_Cor.h"
#import "MacroDef_Size.h"
#import "MacroDef_Func.h"

#import "NSString+Extras.h"
#import "UITableViewCell+WhiteArrows.h"
#import "UIControl+XY.h"
#import "UIButton+Block.h"
#import "UIColor+Hex.h"

#import "CALayer+Anim.h"
#import "CALayer+Transition.h"

#import "NSArray+Extension.h"
#import "NSArray+Extend.h"

#import "UIView+Extras.h"
#import "UIView+Chain.h"
#import "UIView+SuspendView.h"
#import "UIView+Measure.h"
#import "UIView+Animation.h"
#import "UIView+Gradient.h"
#import "UIView+Rotate.h"

#import "NSObject+Extras.h"
#import "NSObject+Time.h"
#import "NSObject+Measure.h"
#import "NSObject+Sound.h"
#import "NSObject+Shake.h"
#import "NSObject+Random.h"
#import "NSObject+SYSAlertController.h"
#import "NSObject+SPAlertController.h"
#import "NSObject+OpenURL.h"

#import "UIImageView+GIF.h"//UIImageView支持GIF动画 https://github.com/pupboss/UIImageView-GIF
#import "UIImage+YBGIF.h"
#import "UIImage+Extras.h"
#import "UIImage+SYS.h"
#import "UIImage+Overlay.h"
#import "UIImage+Tailor.h"
#import "UIImage+screenshot.h"
#import "LoadingImage.h"

//#import "UIView+JHGestureBlock.h"
///BaseVC
#import "BaseVC.h"
#import "UIViewController+Shake.h"
#import "BaseVC+TZImagePickerController.h"
#import "BaseVC+TZImagePickerControllerDelegate.h"
#import "BaseVC+TZLocationManager.h"
#import "BaseVC+MJRefresh.h"
#import "BaseVC+AFNReachability.h"
#import "BaseVC+BackBtn.h"
#import "BaseVC+JXCategoryListContentViewDelegate.h"
#import "BaseVC+BRPickerView.h"
#import "BaseVC+GifImageView.h"
#import "BaseVC+JPImageresizerView.h"
#import "BaseVC+BWShareView.h"

#import "AppDelegate.h"
#import "SceneDelegate.h"
#import <VideoToolbox/VideoToolbox.h>//FFmpeg 需要
///一些工具库
#import "MKPublickDataManager.h"//数据管理
#import "YBNotificationManager.h"//通知名字定义
#import "APIKey.h"

//#import "IsLogin.h"
//#import "PersonalInfo.h"
//#import "NSlogToDocumentFolder.h"//上线需要去掉
///公用的类和库
//替代系统的TabBarController
#import "LZBTabBarVC.h"
#import "CustomSYSUITabBarController.h"
//URL
#import "URL_Manager.h"
//登录
//#import "LoginVC.h"
//个人中心
//#import "PersonalCenterVC.h"
//视频播放Cell
//#import "VideoCell.h"
//#import "MKRecoderHeader.h"
//扫一扫
#import "LBXScanDIYViewController.h"
#import "Global.h"
#import "StyleDIY.h"
//评论列表的
#import "PopUpVC.h"//弹窗小控件（高仿今日头条App评论弹窗框架）
#import "CommentPopUpNonHoveringHeaderFooterView.h"
#import "HoveringHeaderView.h"
#import "UITableViewHeaderFooterView+Attribute.h"
///Model
#import "BaseModel.h"
#import "MyVCModel.h"
#import "MKCommentModel.h"

#endif /* Manual_Add_ThirdParty_h */
