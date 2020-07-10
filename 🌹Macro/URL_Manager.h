//
//  URL_Manager.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface URL_Manager : NSObject

+ (instancetype)sharedInstance;

-(NSString *)BaseUrl_1;
-(NSString *)ImgBaseURL;
#pragma mark —— 成员管理相关接口
///PUT 员工启用接口
-(NSString *)MKEmployeeDoValidPUT;
///POST 添加
-(NSString *)MKEmployeeInfoPOST;
///PUT 修改
-(NSString *)MKEmployeeInfoPUT;

-(NSString *)MKQueryEmployeeInfoListGET;
#pragma mark —— 导出相关接口
///GET 导出管理列表
-(NSString *)MKExportUserListGET;
#pragma mark —— 后台登录信息相关接口
///GET 后台退出登录
-(NSString *)MKLogoutGET;
///POST 登录接口
-(NSString *)MKLoginPOST;
#pragma mark —— 后台广告相关接口
/// GET 随机查询一条广告
-(NSString *)MKAdInfoGET;
/// POST 添加广告
-(NSString *)MKAdInfoAddSpreadPOST;
///GET 删除广告
-(NSString *)MKAdInfoDeleteGET;
///GET 广告列表
-(NSString *)MKAdInfoListGET;
///POST 修改开屏广告或者视频广告
-(NSString *)MKAdInfoUpdatePOST;
///POST 修改是否显示
-(NSString *)MKAdInfoUpdateStatusPOST;
#pragma mark —— 后台用户管理相关接口
///GET 获取用户详情
-(NSString *)MKUserListUserInfoGET;
///GET 用户视频列表
-(NSString *)MKUserListUserVideoListGET;
///POST 删除用户
-(NSString *)MKUserListDeletePOST;
///GET 用户管理列表
-(NSString *)MKUserListQueryUserListGET;
///POST
-(NSString *)MKUserListUpdatePOST;
///POST 修改是否开启
-(NSString *)MKUserListUpdateStatusPOST;
#pragma mark —— 角色管理信息接口
///PUT 角色启用接口
-(NSString *)MKRoleDoValidPUT;
///DELETE 删除
-(NSString *)MKRoleInfoDELETE;
///POST 添加
-(NSString *)MKRoleInfoPOST;
///PUT 修改
-(NSString *)MKRoleInfoPUT;
///GET 获取菜单列表
-(NSString *)MKRoleMenuGET;
///POST 新增菜单
-(NSString *)MKRoleMenuPOST;
///PUT 修改菜单
-(NSString *)MKRoleMenuPUT;
///GET 角色查询列表 & 角色下拉框
-(NSString *)MKRoleQueryRoleListGET;
#pragma mark —— 视频标签相关接口
///POST 新増标签
-(NSString *)MKVideoLabelAddVideoLabelPOST;
///POST 修改标签
-(NSString *)MKVideoLabelModifyLabelPOST;
///GET 标签列表
-(NSString *)MKVideoLabelListGET;
///POST 标签列表
-(NSString *)MKVideoLabelListPOST;
#pragma mark —— 视频管理相关接口
///POST 视频审核
-(NSString *)MKVideoManageCheckVideoPOST;
///POST 视频删除
-(NSString *)MKVideoManageDelVideoPOST;
///POST 视频置顶
-(NSString *)MKVideoManageUpVideoToTopPOST;
///POST 视频列表
-(NSString *)MKVideoManageVideoListPOST;
#pragma mark —— 系统配置接口
///POST 系统参数添加或者修改
-(NSString *)MKSysParamAddOrEditPOST;
///DELETE 系统参数删除
-(NSString *)MKSysParamDELETE;
///GET 系统参数查询列表
-(NSString *)MKSysParamListGET;
///POST 系统参数启用
-(NSString *)MKSysParamSetValidPOST;
#pragma mark —— APP登录信息相关接口
///注册/登录接口
-(NSString *)MKLoginDo;
///发送短信
-(NSString *)MKSendSmsCode;
///退出接口
-(NSString *)MKOut;
#pragma mark —— APP好友关系相关接口 ..
///GET 获取活跃用户
-(NSString *)MKUserFirendAwardListGET;
///GET 最新四个好友
-(NSString *)MKUserFirendFourListGET;
///GET selectUrl
-(NSString *)MKUserFirendFriendUrlselectUrlGET;
///GET list
-(NSString *)MKUserFirendListlistGET;
#pragma mark —— APP黑名单相关接口
///POST 添加
-(NSString *)MKBlackAddPOST;
///GET 删除
-(NSString *)MKBlackDeleteGET;
///GET 黑名单列表
-(NSString *)MKBlackListGET;
#pragma mark —— APP钱包相关接口
///POST 金币兑换
-(NSString *)MKWalletChargeGoldPOST;
///POST 余额兑换会员
-(NSString *)MKWalletChargeVIPPOST;
///POST 我的钱包流水
-(NSString *)MKWalletMyFlowsPOST;
///POST 获取个人钱包数据
-(NSString *)MKWalletMyWalletPOST;
#pragma mark —— APP视频相关接口
///POST 指定用户的视频列表(关注、点赞)
-(NSString *)MKVideosLoadVideosPOST;
///POST 推荐的视频列表
-(NSString *)MKVideosRecommendVideosPOST;
#pragma mark —— App消息相关接口
///GET 消息一级列表
-(NSString *)MKMessageList_1_GET;
///GET 获取系统消息详情
-(NSString *)MKMessageInfoGET;
///GET 消息二级级列表
-(NSString *)MKMessageList_2_GET;
///POST 修改消息开关
-(NSString *)MKmessageUpdateOffPOST;
#pragma mark —— APP银行卡相关接口
///POST 添加银行卡
-(NSString *)MKBankAddPOST;
///GET 获取银行卡信息
-(NSString *)MkBankInfoGET;
///GET 删除
-(NSString *)MKBankDeleteGET;
///GET 银行卡列表
-(NSString *)MKBankListGET;
///POST 修改银行卡
-(NSString *)MKBankUpdatePOST;
#pragma mark —— APP用户粉丝相关接口
///POST 添加
-(NSString *)MKUserFansAdd;
///GET 删除
-(NSString *)MKUserFansDeleteGET;
///GET 获取用户粉丝详情
-(NSString *)MKUserFansInfoGET;
//GET 我的粉丝列表
-(NSString *)MKUserFansListGET;
///GET 粉丝人视频记录
-(NSString *)MKUserFansSelectFocusListGET;
#pragma mark —— App用户关注相关接口
///POST 添加
-(NSString *)MKUserFocusAddPOST;
///GET 删除
-(NSString *)MKUserFocusDeleteGET;
///GET 获取用户关注详情
-(NSString *)MKUserFocusFocusInfoGET;
///GET 关注用户列表
-(NSString *)MkUserFocusListGET;
///GET 被关注人视频记录
-(NSString *)MKUserFocusSelectFocusListGET;
#pragma mark —— APP用户信息相关接口
///POST 进行签到
-(NSString *)MKUserInfoDoSign;
///POST 载入首页
-(NSString *)MkUserInfoLoadHomePagePOST;
///GET 我的签到列表
-(NSString *)MKUserInfoSignListGET;
///POST 编辑个人资料
-(NSString *)MKUserInfoUpdatePOST;
///POST 补填邀请码
-(NSString *)MkUserInfoUpdateCodePOST;
///POST 完善身份信息
-(NSString *)MKUserInfoUpdateIDCardInfoPOST;
///POST 完善实名信息
-(NSString *)MKUserInfoUpdateRealInfoPOST;
#pragma mark —— demo信息相关接口
//GET 添加
-(NSString *)MKDemoAddGET;
///GET async
-(NSString *)MKDemoAsyncGET;
///GET delete
-(NSString *)MKDemoDeleteGET;
///GET query
-(NSString *)MKDemoQueryGET;
///GET 分布式锁用法
-(NSString *)MKDemoRedisLockGET;
///GET sendMq
-(NSString *)MKDemoSendMqGET;
///GET update
-(NSString *)MkDemoUpdateGET;

@end

NS_ASSUME_NONNULL_END
