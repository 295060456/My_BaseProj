//
//  DDNetworkingAPI+MsgStateApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 
NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (MsgStateApi)

#pragma mark —— App消息状态相关接口
/// 添加已读消息 POST
+(void)messageStatusAddPOST:(id _Nullable)parameters
               successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
