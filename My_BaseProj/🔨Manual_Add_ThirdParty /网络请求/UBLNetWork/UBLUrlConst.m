//
//  UBLUrlConst.m
//  UBLLive
//
//  Created by . John on 2020/11/19.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "UBLUrlConst.h"

/** muyu 于2020.11.28 统一
 
 //直播api服务
 http://222.186.150.148:8001/live-api/
 //直播后台服务
 http://222.186.150.148:8001/live-backend/
 //用户api服务
 http://222.186.150.148:8001/live-passport-api/
 //公共后台api服务
 http://222.186.150.148:8001/live-common-backend/
 //比分api服务
 http://222.186.150.148:8001/sports-api/
 
 */

//muyu服务器
//NSString * const UBLBaseURL = @"http://172.24.135.16";//BaseURL
//NSString * const UBLUrlPort = @"12100";//端口

NSString * const UBLBaseURL = @"http://222.186.150.148";//BaseURL
NSString * const UBLUrlPort = @"8001";//端口   9003？？？？

//用户api服务
NSString * const UBLUrlUserLogin = @"live-passport-api/user/login";//用户登录 Post
NSString * const UBLUrlUserRegister = @"live-passport-api/user/register";//用户注册 Post
NSString * const UBLUrlUserRandCode = @"live-passport-api/user/randCode";//随机生成4位随机数 GET
NSString * const UBLUrlRetrievePassword = @"live-passport-api/user/resetPassword";//找回密码接口-重置密码 Post
NSString * const UBLUrlChangePassword = @"live-passport-api/user/changePassword";//找回密码接口-修改密码接口 Post
NSString * const UBLUrlCheckIdentity = @"live-passport-api/user/checkIdentity";//找回密码接口-身份验证 Post
NSString * const UBLUrlSendSmsCode = @"live-passport-api/user/sendSmsCode";//发送短信 Post
NSString * const UBLUrlUserInfo = @"live-passport-api/user/getUserInfoById";//查询用户信息 GET

//直播api服务
NSString * const UBLUrlRoomDetail = @"live-api/v0.1/room/detail";//获取房间详情 GET
NSString * const UBLUrlMatchListInfo = @"live-api/v1/app/matchList";//比分列表信息 GET
NSString * const UBLUrlBanners = @"live-api/v1.0/banner/getBanners";//获取banner GET
NSString * const UBLUrlLivingList = @"live-api/v1.2/rooms/app";///获取直播列表 GET
NSString * const UBLUrlAttentions = @"live-api/v1.1/attentions";///关注  PUT
NSString * const UBLUrlCancelAttentions = @"live-api/v1.1/attentions";///取消关注 DELETE

NSString * const UBLUrlMatchSoccerListInfo = @"sports-api/v1/app/matchList";//比分足球列表信息 GET
NSString * const UBLUrlMatchHotListInfo = @"sports-api/v1/app/hotList";//比分热门列表信息 GET
NSString * const UBLUrlMatchHotTabInfo = @"sports-api/v1/tabs";//比分热门tab信息 GET

NSString * const UBLUrlMatchOdds = @"/v1/getMatchOdds";//获取赛事指数 GET


