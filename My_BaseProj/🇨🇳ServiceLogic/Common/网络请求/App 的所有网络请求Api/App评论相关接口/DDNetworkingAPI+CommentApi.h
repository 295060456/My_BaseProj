//
//  DDNetworkingAPI+CommentApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (CommentApi)

#pragma mark —— App评论相关接口
/// 评论视频
+(void)commentVideoPOST:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock;
/// 删除评论
+(void)delCommentPOST:(id _Nullable)parameters
         successBlock:(MKDataBlock _Nullable)successBlock;
/// 初始化用户评论列表
+(void)queryInitListGET:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock;
/// 获取回复列表
+(void)queryReplyListGET:(id _Nullable)parameters
            successBlock:(MKDataBlock _Nullable)successBlock;
/// 回复评论
+(void)replyCommentPOST:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock;
/// 点赞或取消点赞
+(void)setPraisePOST:(id _Nullable)parameters
        successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
