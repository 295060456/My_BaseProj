//
//  NSObject+URLManager.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLManagerModel.h"

#define HTTP @"http://"
#define append(fmt, ...) [self append:[URLManagerModel stringWithFormat:fmt, ##__VA_ARGS__]]//多参数

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (URLManager)
 
#pragma mark —— BaseURL
+(NSString *)BaseUrl;
+(NSString *)BaseUrl_H5;
#pragma mark —— 请求支付控制器
///
+(URLManagerModel *)callbackGET;
///
+(URLManagerModel *)callbackPOST;
/// 支付金额列表
+(URLManagerModel *)payMoneyListGET;
/// 订单查询
+(URLManagerModel *)payQueryGET;
/// 请求发起支付
+(URLManagerModel *)payReqPOST;
///
+(URLManagerModel *)paySecondCallbackPOST;
///
+(URLManagerModel *)payThirdCallbackPOST;
#pragma mark —— 数据统计相关接口
/// 启动次数 POST
+(URLManagerModel *)addStartTimePOST;
/// 使用时长 POST
+(URLManagerModel *)addUseTimeDataPOST;
/// 渠道列表 GET
+(URLManagerModel *)channelListGET;
/// 上传长视频/短视频观看时长   POST
+(URLManagerModel *)playDatasPOST;
/// app版本信息 GET
+(URLManagerModel *)versionInfoAppGET;
#pragma mark —— App登录信息相关接口
///找回密码接口-重置密码 POST
+(URLManagerModel *)changePasswordPOST;
///找回密码接口-身份验证 POST
+(URLManagerModel *)checkIdentityPOST;
///登录接口 POST
+(URLManagerModel *)appLoginPOST;
///退出接口 GET
+(URLManagerModel *)appLogoutGET;
///随机生成4位随机数 GET
+(URLManagerModel *)randCodeGET;
///注册接口(new) POST
+(URLManagerModel *)appRegisterPOST;
///修改密码接口 POST
+(URLManagerModel *)resetPasswordPOST;
///发送短信 POST
+(URLManagerModel *)sendSmsCodePOST;
#pragma mark —— App广告相关接口
///查询开屏或视频广告 GET
+(URLManagerModel *)adInfoGET;
#pragma mark —— App好友关系相关接口
/// selectUrl GET
+(URLManagerModel *)friendUrlselectUrlGET;
/// 二期好友列表 GET
+(URLManagerModel *)userFriendListGET;
#pragma mark —— App获取配置信息
///app启动参数 GET
+(URLManagerModel *)refreshGET;
#pragma mark —— App看视频获得金币奖励
/// 抖币领取开关 GET
+(URLManagerModel *)goldSwitchGET;
/// 抖币领取开关 POST
+(URLManagerModel *)goldSwitchPOST;
/// 首页看视频得抖币奖励 POST
+(URLManagerModel *)randomRewardPOST;
/// 首页看视频得抖币配置 GET
+(URLManagerModel *)rewardSnapshotGET;
/// 首页看视频得抖币配置 POST
+(URLManagerModel *)rewardSnapshotPOST;
#pragma mark —— App评论相关接口
/// 评论视频 POST
+(URLManagerModel *)commentVideoPOST;
/// 删除评论 POST
+(URLManagerModel *)delCommentPOST;
/// 初始化用户评论列表 GET
+(URLManagerModel *)queryInitListGET;
/// 获取回复列表 GET
+(URLManagerModel *)queryReplyListGET;
/// 回复评论 POST
+(URLManagerModel *)replyCommentPOST;
/// 点赞或取消点赞 POST
+(URLManagerModel *)setPraisePOST;
#pragma mark —— App钱包相关接口
/// 查询游戏钱包接口
+(URLManagerModel *)gamePursePOST;
/// 二期抖币流水
+(URLManagerModel *)myGoldGET;
/// 钱包流水（二期)
+(URLManagerModel *)myPurseFlowGET;
/// 获取钱包用户信息二期
+(URLManagerModel *)myUserWalletPOST;
/// app端转账（转账即可畅玩游戏）
+(URLManagerModel *)transferPOST;
/// 包网回调地址
+(URLManagerModel *)transferCallBackPOST;
/// 包网回调校验地址
+(URLManagerModel *)transferVerifyPOST;
//GET支付金额列表
+(URLManagerModel *)PayMoneyListGET;
#pragma mark —— App视频相关接口
/// 删除自己发布的视频 POST
+(URLManagerModel *)delAppVideoPOST;
/// 标签列表 GET
+(URLManagerModel *)labelListGET;
/// 我的发布 GET
+(URLManagerModel *)loadVideosGET;
/// 视频列表(关注、点赞)  POST
+(URLManagerModel *)loadVideosPOST;
/// 我的喜欢(0、短视频 1、长视频)  GET
+(URLManagerModel *)myPraiseVideoGET;
/// 视频点赞or取消 POST
+(URLManagerModel *)praiseVideoPOST;
/// 生成上传链接 POST
+(URLManagerModel *)presignedUploadUrlPOST;
/// 推荐的视频列表 POST
+(URLManagerModel *)recommendVideosPOST;
/// 搜索视频 POST
+(URLManagerModel *)searchPOST;
/// 查询短视频剩余次数GET
+(URLManagerModel *)shortVideoCountGET;
/// 上传视频 POST
+(URLManagerModel *)uploadVideoPOST;
/// 水印列表 GET
+(URLManagerModel *)waterMarkListGET;
#pragma mark —— App帖子粉丝相关接口
/// 帖子粉丝用户列表 GET
+(URLManagerModel *)postFansListGET;
#pragma mark —— App帖子关注相关接口
/// 添加 POST
+(URLManagerModel *)postFansListPOST;
/// 删除 GET
+(URLManagerModel *)postFocusDeleteGET;
/// 帖子关注用户列表 GET
+(URLManagerModel *)postFocusListGET;
#pragma mark —— App帖子评论相关接口
/// 评论 GET
+(URLManagerModel *)commentAddPOST;
/// 全部评论列表 GET
+(URLManagerModel *)commentAllListGET;
/// 评论列表 GET
+(URLManagerModel *)commentListGET;
#pragma mark —— App消息相关接口
/// 消息二级级列表 GET
+(URLManagerModel *)messageSecondClassListGET;
/// app公告列表 GET
+(URLManagerModel *)noticeListGET;
/// 消息数量
+(URLManagerModel *)selectMessageNumberGET;
#pragma mark —— App消息状态相关接口
/// 添加已读消息 POST
+(URLManagerModel *)messageStatusAddPOST;
#pragma mark —— App意见反馈相关接口
/// 意见反馈
+(URLManagerModel *)feedBackAddPOST;
#pragma mark —— App用户粉丝相关接口
///用户粉丝列表 GET
+(URLManagerModel *)userFansListGET;
#pragma mark —— App用户关注相关接口
/// 添加 POST
+(URLManagerModel *)userFocusAddPOST;
/// 删除 GET
+(URLManagerModel *)userFocusDeleteGET;
/// 关注用户列表 GET
+(URLManagerModel *)userFocusListGET;
#pragma mark —— App用户帖子相关接口
/// 发帖 POST
+(URLManagerModel *)postAddPostPOST;
/// 轮播图列表 GET
+(URLManagerModel *)bannerListGET;
/// 评论帖子详情 GET
+(URLManagerModel *)postCommentDetailInfoGET;
/// 删除帖子 POST
+(URLManagerModel *)delPostPOST;
/// 用户帖子详情 GET
+(URLManagerModel *)postDetailInfoGET;
/// 帖子列表 GET
+(URLManagerModel *)postListGET;
/// 帖子我的(关注、点赞.发布) GET
+(URLManagerModel *)postMyPostGET;
/// 帖子详情 GET
+(URLManagerModel *)postInfoGET;
/// 点赞 POST
+(URLManagerModel *)postPraisePostPOST;
/// 查询环体下载地址 GET
+(URLManagerModel *)selectDowndSettingGET;
/// 帖子图片上传 POST
+(URLManagerModel *)postUploadImagePOST;
/// 帖子视频上传 POST
+(URLManagerModel *)postuploadVideoPOST;
/// 用户详情  GET
+(URLManagerModel *)postUserInfoGET;
/// 用户帖子列表 GET
+(URLManagerModel *)userPostListGET;
#pragma mark —— App用户信息相关接口
/// 绑定手机号 POST
+(URLManagerModel *)bindPhonePOST;
/// 校验是否有权限 GET
+(URLManagerModel *)checkHadRoleGET;
/// 系统头像选择
+(URLManagerModel *)choiceHeadImagePOST;
/// 进行签到 POST
+(URLManagerModel *)doSignPOST;
/// 系统头像列表 GET
+(URLManagerModel *)headImageListGET;
/// 邀请好友 POST
+(URLManagerModel *)userInfoInviteFriendPOST;
/// 邀请任务数据展示 GET
+(URLManagerModel *)userInfoListGET;
/// 客服QQ列表 GET
+(URLManagerModel *)userInfoQQListGET;
/// 滚动数据 GET
+(URLManagerModel *)rollDateGET;
/// 获取邀请码接口 POST
+(URLManagerModel *)userInfoSelectInviteCodePOST;
/// App首页任务界面，查询用户长短视频观影数 POST
+(URLManagerModel *)userInfoSelectVideoCountPOST;
/// 敏感词列表
+(URLManagerModel *)userInfoSensitiveListGET;
/// 我的签到列表 GET
+(URLManagerModel *)signListGET;
/// 用户更新个人信息-昵称-生日-地区  POST
+(URLManagerModel *)userInfoUpdatePOST;
/// 上传头像 POST
+(URLManagerModel *)uploadImagePOST;
/// App端查看用户详情 GET
+(URLManagerModel *)userInfoGET;
#pragma mark —— App vip相关接口
/// 开通vip GET
+(URLManagerModel *)vipApplyGET;
/// 查询全部会员等级权益列表 GET
+(URLManagerModel *)vipListGET;
/// 用户开通会员之后，查询当前会员等级权益 GET
+(URLManagerModel *)vipSelfGET;
#pragma mark —— movie-controller
/// 首页列表 GET
+(URLManagerModel *)homePageListGET;
/// 首页影片分类列表 GET
+(URLManagerModel *)categoryListGET;
/// 添加收藏 POST
+(URLManagerModel *)collectMovePOST;
/// 取消收藏 POST
+(URLManagerModel *)delCollectMovePOST;
/// 取消点赞 POST
+(URLManagerModel *)delPraisePOST;
/// 首页影片列表 GET
+(URLManagerModel *)movListGET;
/// 影片详情列表 GET
+(URLManagerModel *)listInfoGET;
/// 影片详情 GET
+(URLManagerModel *)moveInfoGET;
/// 点赞 POST
+(URLManagerModel *)praiseMovePOST;
/// 随机推荐列表 GET
+(URLManagerModel *)movRandListGET;
/// 推荐分类列表 GET
+(URLManagerModel *)recommendCategoryListGET;
/// 查询长视频剩余次数 GET
+(URLManagerModel *)movShortLongCountGET;

@end

NS_ASSUME_NONNULL_END

