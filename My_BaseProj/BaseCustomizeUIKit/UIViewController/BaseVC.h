//
//  BaseVC.h
//  gtp
//
//  Created by GT on 2019/1/8.
//  Copyright © 2019 GT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCustomButton.h"
#import "AABlock.h"

typedef enum : NSUInteger {
    ComingStyle_PUSH = 0,
    ComingStyle_PRESENT
} ComingStyle;

typedef enum : NSUInteger {
    SYS_AlertController = 0,//UIAlertController
    YX_AlertController//Pod
} AlertControllerStyle;

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC : UIViewController
<
UIGestureRecognizerDelegate
,UINavigationControllerDelegate
>
#pragma mark ——RACSignal
@property(nonatomic,strong)RACSignal *reqSignal;
//#pragma mark —— BaseVC+GifImageView
//@property(nonatomic,strong)UIImageView *gifImageView;
//@property(nonatomic,strong)NSString *path;
//@property(nonatomic,strong)UIImage *image;
//@property(nonatomic,strong)NSData *data;
#pragma mark —— BaseVC+BRStringPickerView
//@property(nonatomic,strong)BRStringPickerView *stringPickerView;
@property(nonatomic,assign)BRStringPickerMode brStringPickerMode;
@property(nonatomic,copy)MKDataBlock brStringPickerViewBlock;
@property(nonatomic,strong)NSArray *BRStringPickerViewDataMutArr;
#pragma mark —— BaseVC+JXCategoryListContentViewDelegate

//#pragma mark —— BaseVC+FSCustomButton
//@property(nonatomic,strong)FSCustomButton *backBtn;
#pragma mark —— BaseVC+AFNReachability
//@property(nonatomic,strong)AFNetworkReachabilityManager *afNetworkReachabilityManager;
@property(nonatomic,assign)BOOL isRequestFinish;//数据请求是否完毕 !!!
@property(nonatomic,copy)void (^ReachableViaWWANNetWorking)(void);//3G网络
@property(nonatomic,copy)void (^ReachableViaWiFiNetWorking)(void);//WiFi
@property(nonatomic,copy)void (^UnknownNetWorking)(void);//未知网络
@property(nonatomic,copy)void (^NotReachableNetWorking)(void);//无任何网络连接
@property(nonatomic,copy)void (^ReachableNetWorking)(void);//有网络
//#pragma mark —— BaseVC+AlertController
//@property(nonatomic,strong)UIAlertController *alertController;
//#pragma mark —— BaseVC+MJRefresh
//@property(nonatomic,strong)MJRefreshAutoGifFooter *tableViewFooter;
//@property(nonatomic,strong)MJRefreshGifHeader *tableViewHeader;
//@property(nonatomic,strong)MJRefreshBackNormalFooter *refreshBackNormalFooter;
#pragma mark —— BaseVC+TZImagePickerController
//@property(nonatomic,strong)TZImagePickerController *imagePickerVC;
@property(nonatomic,copy)MKDataBlock picBlock;
#pragma mark —— Sys_LifeCycle
-(void)VCwillComingBlock:(MKDataBlock)block;//即将进来
-(void)VCdidComingBlock:(MKDataBlock)block;//已经进来
-(void)VCwillBackBlock:(MKDataBlock)block;//即将出去
-(void)VCdidBackBlock:(MKDataBlock)block;//已经出去
#pragma mark —— Sys.
-(void)locateTabBar:(NSInteger)index;
///设置状态栏背景颜色
-(void)setStatusBarBackgroundColor:(UIColor *)color;
///震动特效反馈
-(void)feedbackGenerator;
///跳转系统设置
-(void)pushToSysConfig;
#pragma mark —— Others
@property(nonatomic,copy)MKDataBlock didBackBlock;
//@property(nonatomic,strong)ViewForHeader *viewForHeader;
//@property(nonatomic,strong)ViewForFooter *viewForFooter;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
