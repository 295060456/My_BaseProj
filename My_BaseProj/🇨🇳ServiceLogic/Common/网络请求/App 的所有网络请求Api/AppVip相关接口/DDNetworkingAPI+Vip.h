//
//  DDNetworkingAPI+Vip.h
//  DouDong-II
//
//  Created by Jobs on 2021/2/17.
//

#import "DDNetworkingAPI.h"

 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (Vip)
/// 开通vip
+(void)vipApplyGET:(id _Nullable)parameters
      successBlock:(MKDataBlock _Nullable)successBlock;
/// 查询全部会员等级权益列表
+(void)vipListGET:(id _Nullable)parameters
     successBlock:(MKDataBlock _Nullable)successBlock;
/// 用户开通会员之后，查询当前会员等级权益
+(void)vipSelfGET:(id _Nullable)parameters
     successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
