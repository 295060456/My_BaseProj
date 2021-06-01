//
//  DDNetworkingAPI+UserInfoApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (UserInfoApi)

#pragma mark —— App用户信息相关接口
/// 绑定手机号
+(void)bindPhonePOST:(id _Nullable)parameters
        successBlock:(MKDataBlock _Nullable)successBlock;
/// 校验是否有权限
+(void)checkHadRoleGET:(id _Nullable)parameters
          successBlock:(MKDataBlock _Nullable)successBlock
            failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 系统头像选择
+(void)choiceHeadImagePOST:(id _Nullable)parameters
              successBlock:(MKDataBlock _Nullable)successBlock;
/// 进行签到
+(void)doSignPOST:(id _Nullable)parameters
     successBlock:(MKDataBlock _Nullable)successBlock;
/// 系统头像列表
+(void)headImageListGET:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock
           failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 邀请好友
+(void)userInfoInviteFriendPOST:(id _Nullable)parameters
                   successBlock:(MKDataBlock _Nullable)successBlock;
/// 邀请任务数据展示
+(void)userInfoListGET:(id _Nullable)parameters
          successBlock:(MKDataBlock _Nullable)successBlock;
/// 客服QQ列表 GET
+(void)userInfoQQListGET:(id _Nullable)parameters
            successBlock:(MKDataBlock _Nullable)successBlock
            failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 滚动数据
+(void)rollDateGET:(id _Nullable)parameters
      successBlock:(MKDataBlock _Nullable)successBlock;
/// 获取邀请码接口
+(void)userInfoSelectInviteCodePOST:(id _Nullable)parameters
                       successBlock:(MKDataBlock _Nullable)successBlock;
/// App首页任务界面，查询用户长短视频观影数
+(void)userInfoSelectVideoCountPOST:(id _Nullable)parameters
                       successBlock:(MKDataBlock _Nullable)successBlock;
/// 敏感词列表
+(void)userInfoSensitiveListGET:(id _Nullable)parameters
                   successBlock:(MKDataBlock _Nullable)successBlock;
/// 我的签到列表
+(void)signListGET:(id _Nullable)parameters
      successBlock:(MKDataBlock _Nullable)successBlock;
/// 用户更新个人信息-昵称-生日-地区
+(void)userInfoUpdatePOST:(id _Nullable)parameters
             successBlock:(MKDataBlock _Nullable)successBlock;
/// 上传头像
+(void)uploadImagePOST:(id _Nullable)parameters
      uploadImageDatas:(NSMutableArray<UIImage *> *)uploadImageDatas
          successBlock:(MKDataBlock _Nullable)successBlock
          failureBlock:(MKDataBlock _Nullable)failureBlock;
/// App端查看用户详情
+(void)userInfoGET:(id _Nullable)parameters
      successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
