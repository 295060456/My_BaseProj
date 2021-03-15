//
//  NetworkingAPI.h
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import <Foundation/Foundation.h>
#import "RequestTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI : NSObject
#pragma mark —— 普通的网络请求
/// 【只有Body参数、不需要错误回调】
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock;
///【只有Body参数、需要错误回调的】
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock;
#pragma mark —— 特殊的上传文件的网络请求
/// 上传【图片】文件的网络请求
+(void)requestApi:(NSString *_Nonnull)requestApi
uploadImagesParamArr:(NSArray *)uploadImagesParamArr
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock;
/// 上传【视频】文件的网络请求
+(void)requestApi:(NSString *_Nonnull)requestApi
uploadVideosParamArr:(NSArray *)uploadVideosParamArr
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
