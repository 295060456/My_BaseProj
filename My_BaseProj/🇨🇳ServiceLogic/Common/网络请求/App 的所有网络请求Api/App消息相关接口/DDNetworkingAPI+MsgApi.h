//
//  DDNetworkingAPI+MsgApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (MsgApi)

#pragma mark —— App消息相关接口
/// 消息二级级列表
+(void)messageSecondClassListGET:(id _Nullable)parameters
                    successBlock:(MKDataBlock _Nullable)successBlock
                    failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 公告列表
+(void)noticeListGET:(id _Nullable)parameters
        successBlock:(MKDataBlock _Nullable)successBlock
        failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 消息数量
+(void)selectMessageNumberGET:(id _Nullable)parameters
                 successBlock:(MKDataBlock _Nullable)successBlock;
@end

NS_ASSUME_NONNULL_END
