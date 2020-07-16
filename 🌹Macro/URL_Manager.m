//
//  URL_Manager.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "URL_Manager.h"

@implementation URL_Manager

static URL_Manager *_instance = nil;
static dispatch_once_t onceToken;
+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    });return _instance;
}

-(NSString *)BaseUrl_1{
    return @"http://172.24.137.213:8011";
}

-(NSString *)ImgBaseURL{
    return @"";
}
///PUT 员工启用接口
-(NSString *)MKEmployeeDoValidPUT{
    return @"/back/employee/doValid";
}
///POST 添加
-(NSString *)MKEmployeeInfoPOST{
    return @"/back/employee/info";
}
///PUT 修改
-(NSString *)MKEmployeeInfoPUT{
    return @"/back/employee/info";
}

-(NSString *)MKQueryEmployeeInfoListGET{
    return @"/back/employee/queryEmployeeInfoList";
}
#pragma mark —— 导出相关接口
///GET 导出管理列表
-(NSString *)MKExportUserListGET{
    return @"/back/export/userList";
}
#pragma mark —— 后台登录信息相关接口
///GET 后台退出登录
-(NSString *)MKLogoutGET{
    return @"/back/logout";
}
///POST 登录接口
-(NSString *)MKLoginPOST{
    return @"/back/user/login";
}
#pragma mark —— 后台广告相关接口
/// GET 随机查询一条广告
-(NSString *)MKAdInfoGET{
    return @"/back/adInfo/adInfo";
}
/// POST 添加广告
-(NSString *)MKAdInfoAddSpreadPOST{
    return @"/back/adInfo/addSpread";
}
///GET 删除广告
-(NSString *)MKAdInfoDeleteGET{
    return @"/back/adInfo/delete";
}
///GET 广告列表
-(NSString *)MKAdInfoListGET{
    return @"/back/adInfo/list";
}
///POST 修改开屏广告或者视频广告
-(NSString *)MKAdInfoUpdatePOST{
    return @"/back/adInfo/update";
}
///POST 修改是否显示
-(NSString *)MKAdInfoUpdateStatusPOST{
    return @"/back/adInfo/updateStatus";
}
#pragma mark —— 后台用户管理相关接口
///GET 获取用户详情
-(NSString *)MKUserListUserInfoGET{
    return @"/back/userList/UserInfo";
}
///GET 用户视频列表
-(NSString *)MKUserListUserVideoListGET{
    return @"/back/userList/UserVideoList";
}
///POST 删除用户
-(NSString *)MKUserListDeletePOST{
    return @"/back/userList/delete";
}
///GET 用户管理列表
-(NSString *)MKUserListQueryUserListGET{
    return @"/back/userList/queryUserList";
}
///POST
-(NSString *)MKUserListUpdatePOST{
    return @"/back/userList/update";
}
///POST 修改是否开启
-(NSString *)MKUserListUpdateStatusPOST{
    return @"/back/userList/updateStatus";
}
#pragma mark —— 角色管理信息接口
///PUT 角色启用接口
-(NSString *)MKRoleDoValidPUT{
    return @"/back/role/doValid";
}
///DELETE 删除
-(NSString *)MKRoleInfoDELETE{
    return @"/back/role/info";
}
///POST 添加
-(NSString *)MKRoleInfoPOST{
    return @"/back/role/info";
}
///PUT 修改
-(NSString *)MKRoleInfoPUT{
    return @"/back/role/info";
}
///GET 获取菜单列表
-(NSString *)MKRoleMenuGET{
    return @"/back/role/menu";
}
///POST 新增菜单
-(NSString *)MKRoleMenuPOST{
    return @"/back/role/menu";
}
///PUT 修改菜单
-(NSString *)MKRoleMenuPUT{
    return @"/back/role/menu";
}
///GET 角色查询列表 & 角色下拉框
-(NSString *)MKRoleQueryRoleListGET{
    return @"/back/role/queryRoleList";
}
#pragma mark —— 视频标签相关接口
///POST 新増标签
-(NSString *)MKVideoLabelAddVideoLabelPOST{
    return @"/back/videoLabel/addVideoLabel";
}
///POST 修改标签
-(NSString *)MKVideoLabelModifyLabelPOST{
    return @"/back/videoLabel/modifyLabel";
}
///GET 标签列表
-(NSString *)MKVideoLabelListGET{
    return @"/back/videoLabel/videoLabelList";
}
///POST 标签列表
-(NSString *)MKVideoLabelListPOST{
    return @"/back/videoLabel/videoLabelList";
}
#pragma mark —— 视频管理相关接口
///POST 视频审核
-(NSString *)MKVideoManageCheckVideoPOST{
    return @"/back/videoManage/checkVideo";
}
///POST 视频删除
-(NSString *)MKVideoManageDelVideoPOST{
    return @"/back/videoManage/upVideoToTop";
}
///POST 视频置顶
-(NSString *)MKVideoManageUpVideoToTopPOST{
    return @"";
}
///POST 视频列表
-(NSString *)MKVideoManageVideoListPOST{
    return @"/back/videoManage/videoList";
}
#pragma mark —— 系统配置接口
///POST 系统参数添加或者修改
-(NSString *)MKSysParamAddOrEditPOST{
    return @"/back/sysParam/addOrEdit";
}
///DELETE 系统参数删除
-(NSString *)MKSysParamDELETE{
    return @"/back/sysParam/delete";
}
///GET 系统参数查询列表
-(NSString *)MKSysParamListGET{
    return @"/back/sysParam/list";
}
///POST 系统参数启用
-(NSString *)MKSysParamSetValidPOST{
    return @"/back/sysParam/setValid";
}
#pragma mark —— APP登录信息相关接口
///注册/登录接口
-(NSString *)MKLoginDo{
    return @"/app/login/do";
}
///发送短信
-(NSString *)MKSendSmsCode{
    return @"/app/login/sendSmsCode";
}
///退出接口
-(NSString *)MKOut{
    return @"/app/login/out";
}
#pragma mark —— APP好友关系相关接口 ..
///GET 获取活跃用户
-(NSString *)MKUserFirendAwardListGET{
    return @"/app/userFirend/awardList";
}
///GET 最新四个好友
-(NSString *)MKUserFirendFourListGET{
    return @"/app/userFirend/fourList";
}
///GET selectUrl
-(NSString *)MKUserFirendFriendUrlselectUrlGET{
    return @"/app/userFirend/friendUrlselectUrl";
}
///GET list
-(NSString *)MKUserFirendListlistGET{
    return @"/app/userFirend/listlist";
}
#pragma mark —— APP黑名单相关接口
///POST 添加
-(NSString *)MKBlackAddPOST{
    return @"/app/black/add";
}
///GET 删除
-(NSString *)MKBlackDeleteGET{
    return @"/app/black/delete";
}
///GET 黑名单列表
-(NSString *)MKBlackListGET{
    return @"/app/black/list";
}
#pragma mark —— APP钱包相关接口
///POST 金币兑换
-(NSString *)MKWalletChargeGoldPOST{
    return @"/app/wallet/chargeGold";
}
///POST 余额兑换会员
-(NSString *)MKWalletChargeVIPPOST{
    return @"/app/wallet/chargeVIP";
}
///POST 我的钱包流水
-(NSString *)MKWalletMyFlowsPOST{
    return @"/app/wallet/myFlows";
}
///POST 获取个人钱包数据
-(NSString *)MKWalletMyWalletPOST{
    return @"/app/wallet/myWallet";
}
#pragma mark —— APP视频相关接口
///POST 指定用户的视频列表(关注、点赞)
-(NSString *)MKVideosLoadVideosPOST{
    return @"/app/videos/loadVideos";
}
///POST 推荐的视频列表
-(NSString *)MKVideosRecommendVideosPOST{
    return @"/app/videos/recommendVideos";
}
#pragma mark —— App消息相关接口
///GET 消息一级列表
-(NSString *)MKMessageList_1_GET{
    return @"/app/message/list";
}
///GET 获取系统消息详情
-(NSString *)MKMessageInfoGET{
    return @"/app/message/messageInfo";
}
///GET 消息二级级列表
-(NSString *)MKMessageList_2_GET{
    return @"/app/message/messageList";
}
///POST 修改消息开关
-(NSString *)MKmessageUpdateOffPOST{
    return @"/app/message/updateOff";
}
#pragma mark —— APP银行卡相关接口
///POST 添加银行卡
-(NSString *)MKBankAddPOST{
    return @"/app/bank/add";
}
///GET 获取银行卡信息
-(NSString *)MkBankInfoGET{
    return @"/app/bank/bankInfo";
}
///GET 删除
-(NSString *)MKBankDeleteGET{
    return @"/app/bank/delete";
}
///GET 银行卡列表
-(NSString *)MKBankListGET{
    return @"/app/bank/list";
}
///POST 修改银行卡
-(NSString *)MKBankUpdatePOST{
    return @"/app/bank/update";
}
#pragma mark —— APP用户粉丝相关接口
///POST 添加
-(NSString *)MKUserFansAdd{
    return @"/app/userFans/add";
}
///GET 删除
-(NSString *)MKUserFansDeleteGET{
    return @"/app/userFans/delete";
}
///GET 获取用户粉丝详情
-(NSString *)MKUserFansInfoGET{
    return @"/app/userFans/fansInfo";
}
//GET 我的粉丝列表
-(NSString *)MKUserFansListGET{
    return @"/app/userFans/list";
}
///GET 粉丝人视频记录
-(NSString *)MKUserFansSelectFocusListGET{
    return @"/app/userFans/selectFocusList";
}
#pragma mark —— App用户关注相关接口
///POST 添加
-(NSString *)MKUserFocusAddPOST{
    return @"/app/userFocus/add";
}
///GET 删除
-(NSString *)MKUserFocusDeleteGET{
    return @"/app/userFocus/delete";
}
///GET 获取用户关注详情
-(NSString *)MKUserFocusFocusInfoGET{
    return @"/app/userFocus/focusInfo";
}
///GET 关注用户列表
-(NSString *)MkUserFocusListGET{
    return @"/app/userFocus/list";
}
///GET 被关注人视频记录
-(NSString *)MKUserFocusSelectFocusListGET{
    return @"/app/userFocus/selectFocusList";
}
#pragma mark —— APP用户信息相关接口
///POST 进行签到
-(NSString *)MKUserInfoDoSign{
    return @"/app/userInfo/doSign";
}
///POST 载入首页
-(NSString *)MkUserInfoLoadHomePagePOST{
    return @"/app/userInfo/loadHomePage";
}
///GET 我的签到列表
-(NSString *)MKUserInfoSignListGET{
    return @"/app/userInfo/signList";
}
///POST 编辑个人资料
-(NSString *)MKUserInfoUpdatePOST{
    return @"/app/userInfo/update";
}
///POST 补填邀请码
-(NSString *)MkUserInfoUpdateCodePOST{
    return @"/app/userInfo/updateCode";
}
///POST 完善身份信息
-(NSString *)MKUserInfoUpdateIDCardInfoPOST{
    return @"/app/userInfo/updateIDCardInfo";
}
///POST 完善实名信息
-(NSString *)MKUserInfoUpdateRealInfoPOST{
    return @"/app/userInfo/updateRealInfo";
}
#pragma mark —— demo信息相关接口
//GET 添加
-(NSString *)MKDemoAddGET{
    return @"/demo/add";
}
///GET async
-(NSString *)MKDemoAsyncGET{
    return @"/demo/async";
}
///GET delete
-(NSString *)MKDemoDeleteGET{
    return @"/demo/delete";
}
///GET query
-(NSString *)MKDemoQueryGET{
    return @"/demo/query";
}
///GET 分布式锁用法
-(NSString *)MKDemoRedisLockGET{
    return @"/demo/redisLock";
}
///GET sendMq
-(NSString *)MKDemoSendMqGET{
    return @"/demo/sendMq";
}
///GET update
-(NSString *)MkDemoUpdateGET{
    return @"/demo/update";
}

@end
