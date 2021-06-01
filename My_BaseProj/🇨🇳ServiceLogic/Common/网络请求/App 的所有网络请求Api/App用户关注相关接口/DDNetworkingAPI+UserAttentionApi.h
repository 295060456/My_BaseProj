//
//  DDNetworkingAPI+UserAttentionApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (UserAttentionApi)

#pragma mark —— App用户关注相关接口
/// 添加
+(void)userFocusAddPOST:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock;
/// 删除
+(void)userFocusDeleteGET:(id _Nullable)parameters
             successBlock:(MKDataBlock _Nullable)successBlock;
/// 关注用户列表
+(void)userFocusListGET:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock
           failureBlock:(MKDataBlock _Nullable)failureBlock;

@end

NS_ASSUME_NONNULL_END
