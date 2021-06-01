//
//  DDNetworkingAPI+ConfigApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 
NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (ConfigApi)

#pragma mark —— App获取配置信息
/// app启动参数
+(void)refreshGET:(id _Nullable)parameters
     successBlock:(MKDataBlock _Nullable)successBlock
     failureBlock:(MKDataBlock _Nullable)failureBlock;

@end

NS_ASSUME_NONNULL_END
