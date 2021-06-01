//
//  DDNetworkingAPI+UserFansApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 
NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (UserFansApi)

#pragma mark —— App用户粉丝相关接口
/// 用户粉丝列表
+(void)userFansListGET:(id _Nullable)parameters
          successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
