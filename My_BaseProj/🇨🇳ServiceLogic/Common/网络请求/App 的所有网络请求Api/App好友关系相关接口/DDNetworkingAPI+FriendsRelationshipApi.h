//
//  DDNetworkingAPI+FriendsRelationshipApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (FriendsRelationshipApi)

#pragma mark —— App好友关系相关接口
/// selectUrl
+(void)friendUrlselectUrlGET:(id _Nullable)parameters
                successBlock:(MKDataBlock _Nullable)successBlock;
/// 二期好友列表 GET
+(void)userFriendListGET:(id _Nullable)parameters
            successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
