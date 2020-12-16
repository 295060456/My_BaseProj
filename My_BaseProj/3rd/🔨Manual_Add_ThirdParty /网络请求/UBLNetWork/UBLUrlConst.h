//
//  UBLUrlConst.h
//  UBLLive
//
//  Created by . John on 2020/11/19.
//  Copyright © 2020 UBL. All rights reserved.
//

/***************  Api 大合集  **************/
///BaseURL
UIKIT_EXTERN NSString * const UBLBaseURL;
/// 端口
UIKIT_EXTERN NSString * const UBLUrlPort;

//用户api服务
///用户登录 
UIKIT_EXTERN NSString * const UBLUrlUserLogin;//Post
///用户注册
UIKIT_EXTERN NSString * const UBLUrlUserRegister;//Post
///随机生成4位随机数
UIKIT_EXTERN NSString * const UBLUrlUserRandCode;//GET
///找回密码接口-重置密码
UIKIT_EXTERN NSString * const UBLUrlRetrievePassword;//Post
///找回密码接口-修改密码接口
UIKIT_EXTERN NSString * const UBLUrlChangePassword;//Post
///找回密码接口-身份验证
UIKIT_EXTERN NSString * const UBLUrlCheckIdentity;//Post
///发送短信 
UIKIT_EXTERN NSString * const UBLUrlSendSmsCode;//Post
///查询用户信息
UIKIT_EXTERN NSString * const UBLUrlUserInfo;//GET


//直播api服务
///获取房间详情
UIKIT_EXTERN NSString * const UBLUrlRoomDetail;//GET
///比分列表信息
UIKIT_EXTERN NSString * const UBLUrlMatchListInfo;//GET
///获取banner   (1、资讯 2、直播页 3、预测方案 4、个人中心 5、首页大背景 6、直播页 7、预测首页)
UIKIT_EXTERN NSString * const UBLUrlBanners;//GET
///获取直播列表
UIKIT_EXTERN NSString * const UBLUrlLivingList;//GET
///关注
UIKIT_EXTERN NSString * const UBLUrlAttentions;//PUT
///取消关注
UIKIT_EXTERN NSString * const UBLUrlCancelAttentions;//DELETE


///比分足球列表信息
UIKIT_EXTERN NSString * const UBLUrlMatchSoccerListInfo;//GET
///比分热门列表信息
UIKIT_EXTERN NSString * const UBLUrlMatchHotListInfo;//GET
///比分热门tab信息
UIKIT_EXTERN NSString * const UBLUrlMatchHotTabInfo;//GET


/// 获取赛事指数
UIKIT_EXTERN NSString * const UBLUrlMatchOdds;
