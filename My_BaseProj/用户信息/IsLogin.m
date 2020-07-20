//
//  isLogin.m
//  ShengAi
//
//  Created by 刘赓 on 2018/11/27.
//  Copyright © 2018 刘赓. All rights reserved.
//

#import "IsLogin.h"

@implementation IsLogin

static IsLogin *static_isLogin = nil;
+(IsLogin *)sharedInstance{
    @synchronized(self){
        if (!static_isLogin) {
            static_isLogin = IsLogin.new;
        }
    }return static_isLogin;
}

-(instancetype)init{
    if (self = [super init]) {
        static_isLogin = self;
    }return self;
}

//登陆成功,保存用户名、Member_id（以手机号绑定，唯一）、User_token（需要加在请求头上）、IsVip（会员身份）
+(void)recordLoginInfoWithUserName:(NSString *)username
                         Member_id:(NSNumber *)member_id
                        User_token:(NSString *)user_token
                             IsVip:(NSNumber *)isVip{
    
    SetUserDefaultKeyWithObject(@"name", isVip);
    
    SetUserDefaultKeyWithObject(@"member_id", isVip);
    
    SetUserDefaultKeyWithObject(@"user_token", isVip);
    
    SetUserDefaultKeyWithObject(@"isVip", isVip);
    
    UserDefaultSynchronize;
}

//登录成功,获取用户名
+(NSString *)getUserName{

    return GetUserDefaultObjForKey(@"name");
}

//登录成功,获取Member_id
+(NSNumber *)getMember_id{

    return GetUserDefaultObjForKey(@"member_id");
}

//登录成功,获取User_token
+(NSString *)getUser_token{
    
    return GetUserDefaultObjForKey(@"user_token");
}

//登录成功,获取IsVip
+(NSString *)getIsVip{
    
    return GetUserDefaultObjForKey(@"isVip");
}

//退出登录
+(void)logout{

    //退出的时候删除UserDefaults单例中的用户信息
    DeleUserDefaultWithKey(@"name");
    
    DeleUserDefaultWithKey(@"member_id");
    
    DeleUserDefaultWithKey(@"user_token");
    
    DeleUserDefaultWithKey(@"isVip");

    UserDefaultSynchronize;
}

/**
 是否登录判断
 执行标准:获取不到用户名即视作未登录

 @return NO;//未登录   &   YES;//已登录
 */
+(BOOL)isLogin{

    NSLog(@"[IsLogin getUserName] = %@",[IsLogin getUserName]);

    if ([NSString isNullString:[IsLogin getUserName]]) return NO;//未登录

    return YES;//已登录
}

@end
