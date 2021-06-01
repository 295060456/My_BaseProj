//
//  DDNetworkingAPI+EarnApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (EarnApi)

#pragma mark —— App看视频获得金币奖励
/// 抖币领取开关
+(void)goldSwitchGET:(id _Nullable)parameters
        successBlock:(MKDataBlock _Nullable)successBlock;
/// 抖币领取开关
+(void)goldSwitchPOST:(id _Nullable)parameters
         successBlock:(MKDataBlock _Nullable)successBlock;
/// 首页看视频得抖币奖励
+(void)randomRewardPOST:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock;
/// 首页看视频得抖币配置
+(void)rewardSnapshotGET:(id _Nullable)parameters
            successBlock:(MKDataBlock _Nullable)successBlock;
/// 首页看视频得抖币配置
+(void)rewardSnapshotPOST:(id _Nullable)parameters
             successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
