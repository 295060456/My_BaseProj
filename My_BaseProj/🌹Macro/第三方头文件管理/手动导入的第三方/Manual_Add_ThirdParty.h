//
//  Manual_Add_ThirdParty.h
//  My_BaseProj
//
//  Created by 刘赓 on 2019/9/26.
//  Copyright © 2019 Corp. All rights reserved.
//

#ifndef Manual_Add_ThirdParty_h
#define Manual_Add_ThirdParty_h

#pragma mark —— BaseCustomizeUIKit
/// UIButton
#import "UIButton+Block.h"
#import "UIButton+ImageTitleSpacing.h"
#import "UIButton+CountDownBtn.h"//验证码倒计时按钮
#import "RBCLikeButton.h"//高仿抖音点赞动画
#import "SoundBtn.h"
/// UIColor
#import "UIColor+Hex.h"
/// UIControl
#import "UIControl+XY.h"
/// NSString
#import "NSString+Extras.h"
/// UIFont
#import "UIFont+Extras.h"
/// CALayer
#import "CALayer+Anim.h"
#import "CALayer+Transition.h"
/// NSArray
#import "NSArray+Extension.h"
#import "NSArray+Extend.h"
/// UIView
#import "UIView+Extras.h"
#import "UIView+Chain.h"
#import "UIView+SuspendView.h"
#import "UIView+Measure.h"
#import "UIView+Animation.h"
#import "UIView+Gradient.h"
#import "UIView+EmptyData.h"
#import "UIView+Gesture.h"
#import "UIView+MJRefresh.h"
//#import "UIView+JHGestureBlock.h"
/// NSObject
#import "NSObject+Extras.h"
#import "NSObject+Time.h"
#import "NSObject+Measure.h"
#import "NSObject+Sound.h"
#import "NSObject+Shake.h"
#import "NSObject+Random.h"
#import "NSObject+SYSAlertController.h"
#import "NSObject+SPAlertController.h"
#import "NSObject+OpenURL.h"
#import "NSObject+AFNReachability.h"
#import "NSObject+DataSave.h"
/// UITextField
#import "JobsMagicTextField.h"
#import "CJTextField.h"
#import "HQTextField.h"
#import "UITextField+Extend.h"
#import "ZYTextField.h"
#import "ZYTextField+HistoryDataList.h"
/// UIImageView
#import "UIImageView+GIF.h"//UIImageView支持GIF动画 https://github.com/pupboss/UIImageView-GIF
/// UIImage
#import "LoadingImage.h"
#import "UIImage+YBGIF.h"
#import "UIImage+Extras.h"
#import "UIImage+SYS.h"
#import "UIImage+Overlay.h"
#import "UIImage+Tailor.h"
#import "UIImage+ScreenShot.h"
#import "UIImage+TBCityIconFont.h"
/// UICollectionView
#import "UICollectionView+RegisterClass.h"
/// UICollectionView
#import "CollectionView.h"
/// UICollectionReusableView
#import "CollectionReusableView.h"
/// UICollectionViewCell
#import "CollectionViewCell.h"
/// UICollectionViewLayout
#import "LMHWaterFallLayout.h"
#import "KFZShopCatoryFlowLayput.h"//给UICollectionView每个section加背景
#import "HQCollectionViewFlowLayout.h"//UICollectionView 实现类似于UITableView的悬停效果
/// UIViewController
#import "UIViewController+BaseVC.h"
#import "UIViewController+BackBtn.h"
#import "UIViewController+BRPickerView.h"
#import "UIViewController+BWShareView.h"
#import "UIViewController+GifImageView.h"
#import "UIViewController+JPImageresizerView.h"
#import "UIViewController+JXCategoryListContentViewDelegate.h"
#import "UIViewController+JXPagerViewListViewDelegate.h"
#import "UIViewController+MJRefresh.h"
#import "UIViewController+Shake.h"
#import "UIViewController+TZImagePickerController.h"
#import "UIViewController+TZImagePickerControllerDelegate.h"
#import "UIViewController+TZLocationManager.h"
#import "UIViewController+NavigationBar.h"
#import "UIViewController+TFPopup.h"
#import "UIViewController+InteractivePushGesture.h"
#import "UIViewController+EmptyData.h"
#import "UIViewController+XLBubbleTransition.h"
/// UITableViewHeaderFooterView
#import "ViewForTableViewFooter.h"
#import "ViewForTableViewHeader.h"
/// UITableViewCell
#import "UITableViewCell+WhiteArrows.h"
/// UINavigationController
#import "BaseNavigationVC.h"
/// UINavigationBar
#import "NavigationBar.h"
/// UIDevice
#import "UIDevice+XMUtils.h"

#pragma mark —— 🔨Manual_Add_ThirdParty
#import "UserDefaultManager.h"
#import "LongPressToDeleteImageView.h"
#import "RYCuteView.h"
#import "XWCountryCodeController.h"
#import "HAHandleDemoView.h"
//#import "SDCycleScrollView.h"
#import "LXTagsView.h"
#import "TouchID.h"
#import "UIButton+CountDownBtn.h"
#import "XDSDropDownMenu.h"
#import "XLSphereView.h"
#import "UICountingLabel.h"//数字可以一直变化到指定值的UILable
#import "DeleteSystemUITabBarButton.h"//移除 系统自带的 UITabBarButton
#import "XDTextBtnView.h"//自适应文字按钮
#import "TWPageViewController.h"//https://www.jianshu.com/p/25b1a3888bb8
#import "WebViewJavascriptBridge.h"
#import "XLChannelControl.h"//https://github.com/mengxianliang/XLChannelControl
#import "TBCityIconFont.h"
#import "CountdownView.h"//圆形倒计时进度条（中间有字，可点击回调）
#import "HWTextCodeView.h"
#import "LMHWaterFallLayout.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "WGradientProgress.h"
#import "WGradientProgressView.h"
#import "BWShareView.h"
#import "BWItemModel.h"
#import "FileFolderHandleTool.h"
#import "EmptyView.h"
#import "SuspendBtn.h"
#import "SuspendLab.h"
#import "SuspendView.h"
#import "JhtBannerView.h"
#import "ZZCircleProgress.h"
#import "MovieCountDown.h"
#import "TabbarControllerSysEx.h"

//#import "ZFMRACNetworkTool.h"//网络请求 RAC+MVVM

#pragma mark —— 以下是自定义的
///一些工具库
#import "MKPublickDataManager.h"//数据管理

//#import "IsLogin.h"
//#import "PersonalInfo.h"
//#import "NSlogToDocumentFolder.h"//上线需要去掉
///公用的类和库
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
//#import "LBXScanDIYViewController.h"
//#import "Global.h"
//#import "StyleDIY.h"

///Model
#import "BaseModel.h"
#import "MyVCModel.h"

#endif /* Manual_Add_ThirdParty_h */
