//
//  SceneDelegate+LaunchingAd.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/21.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "SceneDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SceneDelegate (LaunchingAd)

///如果需要网络请求得到URL
-(void)netWorkingAd;
///如果直接是固定的图片Url
-(void)fixedAdPicsUrl;
///如果是本地图片
-(void)localAdPic;

@end

NS_ASSUME_NONNULL_END
