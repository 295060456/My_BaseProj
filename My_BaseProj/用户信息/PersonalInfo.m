//
//  PersonalInfo.m
//  fastdrive
//
//  Created by 谭自强 on 15/9/23.
//  Copyright (c) 2015年 朝花夕拾. All rights reserved.
//

#import "PersonalInfo.h"

#define LOGIN_USER_INFO @"LOGIN_USER_INFO"//保存用户登录信息KEY
#define LOCATION_INFO @"LOCATION_INFO"//保存用户经纬度信息KEY
#define VENDOR_ADVERID @"VENDOR_ADVERID"//保存商家ID
#define MAIN_USER_INFO @"MAIN_USER_INFO"//保存用户首页信息KEY
#define StrRegistrationID @"StrRegistrationID"//极光推送ID

@implementation PersonalInfo

static PersonalInfo *personalInfo;
static dispatch_once_t longOnce;
//单例实例化
+ (PersonalInfo *)sharedInstance{
    dispatch_once(&longOnce, ^{
        personalInfo = [[PersonalInfo alloc] init];
    });return personalInfo;
}
//增
-(void)updateLoginUserInfo:(ModelLogin *)model{
    //模型 ——> 字典
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithDictionary:model.mj_keyValues];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dicInfo
                     forKey:LOGIN_USER_INFO];
    [userDefaults synchronize];
}
//查、取
-(ModelLogin *)fetchLoginUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:LOGIN_USER_INFO];
    //字典 ——> 模型
    ModelLogin *model = [ModelLogin mj_objectWithKeyValues:userInfo];
    return model;
}
//删
-(void)deleteLoginUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil
                     forKey:LOGIN_USER_INFO];
    [userDefaults synchronize];
}

-(BOOL)isLogined{
    ModelLogin *model = [self fetchLoginUserInfo];
//    D_NSLog(@"model is %@",model);
    if ([NSString isNullString:model.userId]) {
        return NO;
    }else{
        return YES;
    }
}




@end
