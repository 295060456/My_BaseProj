//
//  NetworkingAPI+FriendsRelationshipApi.h
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

@interface NetworkingAPI (FriendsRelationshipApi)

#pragma mark —— APP好友关系相关接口
/// 手动执行奖励记录
+(void)addAwardGET:(id)parameters
  withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 手动执行奖励记录
+(void)addAwardInfoGET:(id)parameters
      withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 获取活跃用户
+(void)awardListGET:(id)parameters
   withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 最新四个好友
+(void)fourListGET:(id)parameters
  withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// selectUrl
+(void)friendUrlselectUrlGET:(id)parameters
            withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 好友列表
+(void)userFriendListGET:(id)parameters
        withsuccessBlock:(MKDataBlock _Nullable)successBlock;
/// 统计我的收益
+(void)myInComeGET:(id)parameters
  withsuccessBlock:(MKDataBlock _Nullable)successBlock;
///面对面邀请保存好友手机号码 
+(void)savePhonePOST:(id)parameters
    withsuccessBlock:(MKDataBlock _Nullable)successBlock;
@end

NS_ASSUME_NONNULL_END
