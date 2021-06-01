//
//  DDNetworkingAPI+StatisticsApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 
NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (StatisticsApi)

#pragma mark —— 数据统计相关接口
/// 启动次数
+(void)addStartTimePOST:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock;
/// 使用时长
+(void)addUseTimeDataPOST:(id _Nullable)parameters
             successBlock:(MKDataBlock _Nullable)successBlock;
/// 渠道列表
+(void)channelListGET:(id _Nullable)parameters
         successBlock:(MKDataBlock _Nullable)successBlock;
/// 版本信息
+(void)versionInfoAppGET:(id _Nullable)parameters
            successBlock:(MKDataBlock _Nullable)successBlock
            failureBlock:(MKDataBlock _Nullable)failureBlock;
///  长短视频观看时长上报
+(void)playDatasPOST:(id _Nullable)parameters
       successBlock:(MKDataBlock _Nullable)successBlock
       failureBlock:(MKDataBlock _Nullable)failureBlock;


@end

NS_ASSUME_NONNULL_END
