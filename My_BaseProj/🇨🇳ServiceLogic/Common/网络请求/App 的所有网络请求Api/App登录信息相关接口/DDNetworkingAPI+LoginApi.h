//
//  DDNetworkingAPI+LoginApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (LoginApi)

#pragma mark —— App登录信息相关接口
/// 找回密码接口-重置密码
+(void)changePasswordPOST:(id _Nullable)parameters
             successBlock:(MKDataBlock _Nullable)successBlock;
/// 找回密码接口-身份验证
+(void)checkIdentityPOST:(id _Nullable)parameters
            successBlock:(MKDataBlock _Nullable)successBlock;
/// 登录
+(void)appLoginPOST:(id _Nullable)parameters
       successBlock:(MKDataBlock _Nullable)successBlock
       failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 退出
+(void)appLogoutGET:(id _Nullable)parameters
       successBlock:(MKDataBlock _Nullable)successBlock;
/// 随机生成4位随机数
+(void)randCodeGET:(id _Nullable)parameters
      successBlock:(MKDataBlock _Nullable)successBlock;
/// 注册接口(new)
+(void)appRegisterPOST:(id _Nullable)parameters
          successBlock:(MKDataBlock _Nullable)successBlock
          failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 修改密码接口
+(void)resetPasswordPOST:(id _Nullable)parameters
            successBlock:(MKDataBlock _Nullable)successBlock;
/// 发送短信
+(void)sendSmsCodePOST:(id _Nullable)parameters
          successBlock:(MKDataBlock _Nullable)successBlock;

@end

NS_ASSUME_NONNULL_END
