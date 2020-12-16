//
//  PersonalInfo.h
//  fastdrive
//
//  Created by 谭自强 on 15/9/23.
//  Copyright (c) 2015年 朝花夕拾. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ModelLogin.h"
/**
 *  PersonalInfo是一个单例,存取删除登录信息
 */
@interface PersonalInfo : NSObject
/**
 *  获取PersonalInfo对象,PersonalInfo
 *
 *  @return PersonalInfo对象
 */
+ (PersonalInfo *)sharedInstance;
/**
 *  更新登录用信息
 */
-(void)updateLoginUserInfo:(ModelLogin*)model;
/**
 *  获取用户登录信息
 *
 *  @return ModelLogin 用户信息对象实体
 */
-(ModelLogin*)fetchLoginUserInfo;
/**
 *  删除保存的登录用户信息
 */
-(void)deleteLoginUserInfo;
/**
 *  是否登录
 */
-(BOOL)isLogined;

@end
