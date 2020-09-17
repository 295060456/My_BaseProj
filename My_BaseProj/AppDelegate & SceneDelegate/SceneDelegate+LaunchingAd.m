//
//  SceneDelegate+LaunchingAd.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/21.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "SceneDelegate+LaunchingAd.h"

@implementation SceneDelegate (LaunchingAd)
///如果需要网络请求得到URL
-(void)netWorkingAd{
//    http://172.24.135.208/taskpage/#/adverti
      [NSObject makeLBLaunchImageAdView:^(LBLaunchImageAdView *imgAdView) {
          /// 1. 配置参数
          NSMutableDictionary *easyDict = [NSMutableDictionary dictionary];
          /// 2. 配置参数模型
          FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                                 path:@"Room/GetHotLive_v2"
                                                           parameters:easyDict];
          RACSignal *reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
          [reqSignal subscribeNext:^(FMHttpResonse *response) {
              if (response.isSuccess) {
                  NSLog(@"%p",response.reqResult);
                  NSLog(@"--%@",response.reqResult);
                  //设置网络启动图片URL
                  imgAdView.imgUrl = @"";
                  //点击响应的url
                  imgAdView.advertUrl = @"";
                  //是否能点击
                  imgAdView.isClickAdView = YES;
                  //设置广告的类型
                  imgAdView.getLBlaunchImageAdViewType(LogoAdType);
                  //自定义跳过按钮
                  imgAdView.skipBtn.backgroundColor = [UIColor lightGrayColor];
                  imgAdView.skipBtn.alpha = 0.5;
                  [imgAdView.skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                  __block LBLaunchImageAdView *adView = imgAdView;
                  imgAdView.clickBlock = ^(const clickType type) {
                      switch (type) {
                          case clickAdType:{
                              NSLog(@"点击广告回调");
                              if (adView.advertUrl.length > 10 && adView.isClickAdView) {
                                  [self clickAd];
                              }
                          }break;
                          case skipAdType:{
                              NSLog(@"点击跳过回调");
                              [self skipAd];
                          }break;
                          case overtimeAdType:{
                              NSLog(@"倒计时完成后的回调");
                              [self overtimeAd];
                          }break;
                          default:
                              break;
                    }
                };
              }
          }];
      }];
}
///如果直接是固定的图片Url
-(void)fixedAdPicsUrl{
    @weakify(self)
    [NSObject makeLBLaunchImageAdView:^(LBLaunchImageAdView *imgAdView) {
        //设置广告的类型
        imgAdView.getLBlaunchImageAdViewType(FullScreenAdType);
        imgAdView.imgUrl = @"http://172.24.135.12/video/font.png";
        //自定义跳过按钮
        imgAdView.skipBtn.backgroundColor = [UIColor blackColor];
        //各种点击事件的回调
        imgAdView.clickBlock = ^(clickType type){
            @strongify(self)
            switch (type) {
                case clickAdType:{
                    NSLog(@"点击广告回调");
                    [self clickAd];
                }break;
                case skipAdType:{
                    NSLog(@"点击跳过回调");
                    [self skipAd];
                }break;
                case overtimeAdType:{
                    NSLog(@"倒计时完成后的回调");
                    [self overtimeAd];
                }break;
                default:
                    break;
            }
        };
    }];
}
///如果是本地图片
-(void)localAdPic{
    @weakify(self)
    [NSObject makeLBLaunchImageAdView:^(LBLaunchImageAdView *imgAdView) {
        //设置广告的类型
        imgAdView.getLBlaunchImageAdViewType(LogoAdType);
        //设置本地启动图片
        imgAdView.localAdImgName = @"GIF大图.gif";
        //自定义跳过按钮
        imgAdView.skipBtn.backgroundColor = [UIColor blackColor];
        //各种点击事件的回调
        imgAdView.clickBlock = ^(clickType type){
            @strongify(self)
            switch (type) {
                case clickAdType:{
                    NSLog(@"点击广告回调");
                    [self clickAd];
                }break;
                case skipAdType:{
                    NSLog(@"点击跳过回调");
                    [self skipAd];
                }break;
                case overtimeAdType:{
                    NSLog(@"倒计时完成后的回调");
                    [self overtimeAd];
                }break;
                default:
                    break;
            }
        };
    }];
}
#pragma mark —— 启动页触发事件
///点击广告回调
-(void)clickAd{
    if (@available(iOS 13.0, *)){
        [self.window setRootViewController:self.navigationController];
        [self.window makeKeyAndVisible];
//        [[FLEXManager sharedManager] showExplorer];
    }
}
///点击跳过回调
-(void)skipAd{
    if (@available(iOS 13.0, *)){
        [self.window setRootViewController:self.navigationController];
        [self.window makeKeyAndVisible];
    }
}
///倒计时完成后的回调
-(void)overtimeAd{
    if (@available(iOS 13.0, *)){
        [self.window setRootViewController:self.navigationController];
        [self.window makeKeyAndVisible];
    }
}

@end
