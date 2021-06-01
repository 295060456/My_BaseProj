//
//  DDNetworkingAPI+PostCommentApi.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/8.
//

#import "DDNetworkingAPI.h"

 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (PostCommentApi)

#pragma mark —— App帖子评论相关接口
/// 评论 GET
+(void)commentAddPOST:(id _Nullable)parameters
        successBlock:(MKDataBlock _Nullable)successBlock;
///  全部评论列表 GET
+(void)commentAllListGET:(id _Nullable)parameters
            successBlock:(MKDataBlock _Nullable)successBlock;
/// 评论列表 GET
+(void)commentListGET:(id _Nullable)parameters
         successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
