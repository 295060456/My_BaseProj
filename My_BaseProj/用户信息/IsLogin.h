//
//  IsLogin.h
//  ShengAi
//
//  Created by 刘赓 on 2018/11/27.
//  Copyright © 2018 刘赓. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IsLogin : NSObject

/**
 *  是否登录判断
 */
+(BOOL)isLogin;

/**
 *  登陆成功,保存用户名、Member_id（以手机号绑定，唯一）、User_token（需要加在请求头上）、IsVip（会员身份）
 */
+(void)recordLoginInfoWithUserName:(NSString *)username
                         Member_id:(NSNumber *)member_id
                        User_token:(NSString *)user_token
                             IsVip:(NSNumber *)isVip;

/**
 *  登录成功,获取用户名
 */
+(NSString *)getUserName;

/**
 *  登录成功,获取IsVip
 */
+(NSString *)getIsVip;

/**
 *  登录成功,获取User_token
 */
+(NSString *)getUser_token;

/**
 *  登录成功,获取Member_id
 */
+(NSString *)getMember_id;

/**
 *  退出登录
 */
+(void)logout;

+ (IsLogin *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
