//
//  NetworkingAPI+CommentApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NetworkingAPI.h"
/*
各种环境的地址 和 接口文档地址 在这里写，方便调用
 
 */
NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI (CommentApi)

#pragma mark —— APP评论相关接口
/// 评论视频
+(void)commentVideoPOST:(id)parameters
       withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 删除评论
+(void)delCommentPOST:(id)parameters
     withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 初始化用户评论列表
+(void)queryInitListGET:(id)parameters
       withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 获取回复列表
+(void)queryReplyListGET:(id)parameters
        withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 回复评论
+(void)replyCommentPOST:(id)parameters
       withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 点赞或取消点赞
+(void)setPraisePOST:(id)parameters
    withsuccessBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
