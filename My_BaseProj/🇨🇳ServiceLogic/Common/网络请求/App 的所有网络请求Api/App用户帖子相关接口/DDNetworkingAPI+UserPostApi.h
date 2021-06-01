//
//  DDNetworkingAPI+UserPostApi.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/8.
//

#import "DDNetworkingAPI.h"

 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (UserPostApi)

#pragma mark —— App用户帖子相关接口
/// 发帖 POST
+(void)postAddPostPOST:(id _Nullable)parameters
          successBlock:(MKDataBlock _Nullable)successBlock;
/// 轮播图列表 GET
+(void)bannerListGET:(id _Nullable)parameters
        successBlock:(MKDataBlock _Nullable)successBlock;
/// 评论帖子详情 GET
+(void)postCommentDetailInfoGET:(id _Nullable)parameters
                   successBlock:(MKDataBlock _Nullable)successBlock;
/// 删除帖子 POST
+(void)delPostPOST:(id _Nullable)parameters
      successBlock:(MKDataBlock _Nullable)successBlock;
/// 用户帖子详情 GET
+(void)postDetailInfoGET:(id _Nullable)parameters
            successBlock:(MKDataBlock _Nullable)successBlock;
/// 帖子列表 GET
+(void)postListGET:(id _Nullable)parameters
      successBlock:(MKDataBlock _Nullable)successBlock
      failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 帖子我的(关注、点赞.发布) GET
+(void)postMyPostGET:(id _Nullable)parameters
        successBlock:(MKDataBlock _Nullable)successBlock
        failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 帖子详情 GET
+(void)postInfoGET:(id _Nullable)parameters
      successBlock:(MKDataBlock _Nullable)successBlock;
/// 点赞 POST
+(void)postPraisePostPOST:(id _Nullable)parameters
             successBlock:(MKDataBlock _Nullable)successBlock;
/// 查询环体下载地址 GET
+(void)selectDowndSettingGET:(id _Nullable)parameters
                successBlock:(MKDataBlock _Nullable)successBlock;
/// 帖子图片上传 POST
+(void)postUploadImagePOST:(id _Nullable)parameters
               uploadDatas:(NSMutableArray<ZBUploadData *> *)uploadDatas
              successBlock:(MKDataBlock _Nullable)successBlock
              failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 帖子视频上传 POST
+(void)postuploadVideoPOST:(id _Nullable)parameters
               uploadVideo:(NSMutableArray <NSData *>*)videoDatas
              successBlock:(MKDataBlock _Nullable)successBlock
              failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 用户详情  GET
+(void)postUserInfoGET:(id _Nullable)parameters
          successBlock:(MKDataBlock _Nullable)successBlock;
/// 用户帖子列表 GET
+(void)userPostListGET:(id _Nullable)parameters
          successBlock:(MKDataBlock _Nullable)successBlock
          failureBlock:(MKDataBlock _Nullable)failureBlock;



@end

NS_ASSUME_NONNULL_END
