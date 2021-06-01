//
//  DDNetworkingAPI+AdsApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 
NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (AdsApi)

#pragma mark —— App广告相关接口
/// 查询开屏或视频广告   开屏0，视频广告1
+(void)adInfoGET:(id _Nullable)parameters
    successBlock:(MKDataBlock _Nullable)successBlock
    failureBlock:(MKDataBlock _Nullable)failureBlock;

@end

NS_ASSUME_NONNULL_END
