//
//  URL_Manager.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HTTP @"http://"
#define append(fmt, ...) [self append:[NSString stringWithFormat:fmt, ##__VA_ARGS__]]//多参数

NS_ASSUME_NONNULL_BEGIN

@interface URL_Manager : NSObject

+ (URL_Manager *)sharedInstance;

-(NSString *)BaseUrl_1;
-(NSString *)BaseUrl_H5;
-(NSString *)BaseUrl_eddy;//临时测试服
#pragma mark - H5 地址
/// 帮助中心
-(NSString *)MKH5HelpCenter;
/// 填写邀请码
-(NSString *)MKH5InvitationCode;
/// 邀请好友
-(NSString *)MKH5Invit;
/// 银行卡
-(NSString *)MKH5BankCard;
/// 开屏广告
-(NSString *)MKH5OpenScrennAD;
/// 任务
-(NSString *)MKH5Task;
///
-(NSString *)ImgBaseURL;
#pragma mark —— 成员管理相关接口
///PUT 员工启用接口
-(NSString *)MKEmployeeDoValidPUT;
///POST 添加
-(NSString *)MKEmployeeInfoPOST;
///PUT 修改
-(NSString *)MKEmployeeInfoPUT;
///员工查询列表
-(NSString *)MKQueryEmployeeInfoListGET;
///删除员工
-(NSString *)MKEmployeeRemoveDELETE;
#pragma mark —— 后台登录信息相关接口
///GET 后台退出登录
-(NSString *)MKLogoutGET;
///POST 登录接口
-(NSString *)MKLoginPOST;
#pragma mark —— 后台广告相关接口
/// POST 添加广告
-(NSString *)MKAdInfoAddSpreadPOST;
///GET 删除广告
-(NSString *)MKAdInfoDeletePOST;
///GET 广告列表
-(NSString *)MKAdInfoListGET;
///POST 修改开屏广告或者视频广告
-(NSString *)MKAdInfoUpdatePOST;
///POST 修改是否显示
-(NSString *)MKAdInfoUpdateStatusPOST;
///广告图片上传上传
-(NSString *)MKAdInfoUploadImagePOST;
///广告视频上传
-(NSString *)MKAdInfoUploadVideoPOST;
#pragma mark —— 后台用户管理相关接口
///GET获取权限详情
-(NSString *)MKUserListPermissionInfoGET;
///GET 获取用户详情
-(NSString *)MKUserListUserInfoGET;
///GET 用户视频列表
-(NSString *)MKUserListUserVideoListGET;
///POST 删除用户
-(NSString *)MKUserListDeletePOST;
///GET用户管理列表导出
-(NSString *)MKUserListQueryExportListGET;
///GET登录日志列表
-(NSString *)MKUserListQueryLoginLogGET;
///GET用户管理列表
-(NSString *)MKUserListQueryUserListGET;
///POST编辑用户信息
-(NSString *)MKUserListUpdatePOST;
///POST 修改是否开启
-(NSString *)MKUserListUpdateStatusPOST;
#pragma mark —— 角色管理信息接口
///POST删除菜单
-(NSString *)MKRoleDelMenuPOST;
///PUT 角色启用接口
-(NSString *)MKRoleDoValidPUT;
///POST权限设置
-(NSString *)MKRoleEditRoleMenuPOST;
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
///GET 角色查询列表
-(NSString *)MKRoleQueryRoleListGET;
///GET角色下拉框
-(NSString *)MKRoleSelectRoleListGET;
#pragma mark —— 评论相关接口
///GET我的评论用户列表
-(NSString *)MKCommentListGET;
#pragma mark —— 视频标签相关接口
///POST 新増标签
-(NSString *)MKVideoLabelAddVideoLabelPOST;
///POST删除标签
-(NSString *)MKVideoLabelDelLabel;
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
///POST 视频上传(仅支持flv/mp4类型)
-(NSString *)MKVideoManageUploadVideo;
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
///POST注册/登录接口
-(NSString *)MKLoginDo;
///GET退出接口
-(NSString *)MKOut;
///POST发送短信
-(NSString *)MKSendSmsCode;
#pragma mark —— App广告相关接口
///GET 查询开屏或视频广告
-(NSString *)MKadInfoAdInfoGET;
#pragma mark —— APP好友关系相关接口 ..
///GET手动执行奖励记录
-(NSString *)MKUserFriendAddAwardInfoGET;
///GET 获取活跃用户
-(NSString *)MKUserFriendAwardListGET;
///GET 最新四个好友
-(NSString *)MKUserFriendFourListGET;
///GET selectUrl
-(NSString *)MKUserFriendSelectUrlGET;
///GET  好友列表
-(NSString *)MKUserFriendListlistGET;
///GET统计我的收益
-(NSString *)MKUserFriendMyInComeGET;
///POST面对面邀请保存好友手机号码
-(NSString *)MKUserFriendsavePhonePOST;
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
///POST 获取用户信息
-(NSString *)MKWalletMyWalletPOST;
///POST 权限启用关闭
#pragma mark —— APP权限用户接口相关信息
-(NSString *)MKAppRoleSetValuePOST;
#pragma mark —— APP视频相关接口
///POST 评论
-(NSString *)MKVideosCommentVideoPOST;
///POST 指定用户的视频列表(关注、点赞)
-(NSString *)MKVideosLoadVideosPOST;
///POST 视频点赞or取消
-(NSString *)MKVideosPraiseVideoPOST;
///POST 推荐的视频列表
-(NSString *)MKVideosRecommendVideosPOST;
#pragma mark —— App消息相关接口
///GET 获取用户粉丝详情
-(NSString *)MKMessageFansInfoGET;
///GET 消息一级列表
-(NSString *)MKMessageList_1_GET;
///GET 获取系统消息详情视频列表
-(NSString *)MKMessageInfoGET;
///GET 消息二级级列表
-(NSString *)MKMessageList_2_GET;
///GET 消息开关列表
-(NSString *)MKmessageTurnOffListGET;
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
///GET 查询身份信息
-(NSString *)MKUserInfoIdCardInfoGET;
///POST 进行签到
-(NSString *)MKUserInfoDoSignPOST;
///POST 载入首页
-(NSString *)MkUserInfoLoadHomePagePOST;
//GET 滚动数据
-(NSString *)MKUserInfoRollDateGET;
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
///POST 上传头像
-(NSString *)MKUserInfoUploadImagePOST;
#pragma mark —— demo信息相关接口
///GET 添加
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
///POST uploadVideo
-(NSString *)MKDemoUploadPOST;
#pragma mark —— 临时添加,为了保证视频源一定有数据,App不崩溃
-(NSString *)MKAppSysInitData;

@end

NS_ASSUME_NONNULL_END
