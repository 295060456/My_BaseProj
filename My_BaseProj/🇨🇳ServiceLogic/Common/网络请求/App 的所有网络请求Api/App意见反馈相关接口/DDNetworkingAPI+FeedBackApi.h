//
//  DDNetworkingAPI+FeedBackApi.h
//  DouDong-II
//
//  Created by Jobs on 2021/2/17.
//

#import "DDNetworkingAPI.h"

 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (FeedBackApi)
/// 意见反馈
+(void)feedBackAddPOST:(id _Nullable)parameters
          successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
