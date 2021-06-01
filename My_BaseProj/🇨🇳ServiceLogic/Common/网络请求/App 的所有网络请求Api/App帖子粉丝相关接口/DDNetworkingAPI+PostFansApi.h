//
//  DDNetworkingAPI+PostFansApi.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/8.
//

#import "DDNetworkingAPI.h"
 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (PostFansApi)

/// App帖子粉丝相关接口
+(void)postFansListGET:(id _Nullable)parameters
          successBlock:(MKDataBlock _Nullable)successBlock
          failureBlock:(MKDataBlock _Nullable)failureBlock;

@end

NS_ASSUME_NONNULL_END
