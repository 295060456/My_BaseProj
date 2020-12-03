//
//  UBLNetWorkManager.h
//  UBLLive
//
//  Created by . John on 2020/11/19.
//  Copyright © 2020 UBL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UBLNetWorkResult;
@interface UBLNetWorkManager : NSObject

typedef void (^resultInfoBlock)(UBLNetWorkResult *result);

/// post 方法
+ (NSURLSessionDataTask *)postRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters finished:(resultInfoBlock)finished;
/// get 方法
+ (NSURLSessionDataTask *)getRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters finished:(resultInfoBlock)finished;
/// post 方法上传图片
+ (NSURLSessionDataTask *)uploadImageWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters image:(UIImage *)image finished:(resultInfoBlock)finished;
/// put 方法
+ (NSURLSessionDataTask *)putRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters finished:(resultInfoBlock)finished;
/// delete 方法
+ (NSURLSessionDataTask *)deleteRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters finished:(resultInfoBlock)finished;


@end

NS_ASSUME_NONNULL_END
