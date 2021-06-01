//
//  DDNetworkingAPI+PostFocusApi.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/8.
//

#import "DDNetworkingAPI.h"

 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (PostFocusApi)

#pragma mark —— App帖子关注相关接口
/// 添加 POST
+(void)postFansListPOST:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock
           failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 删除 GET
+(void)postFocusDeleteGET:(id _Nullable)parameters
             successBlock:(MKDataBlock _Nullable)successBlock;
/// 帖子关注用户列表 GET
+(void)postFocusListGET:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
