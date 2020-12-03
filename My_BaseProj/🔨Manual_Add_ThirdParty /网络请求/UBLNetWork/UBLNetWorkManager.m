//
//  UBLNetWorkManager.m
//  UBLLive
//
//  Created by . John on 2020/11/19.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "UBLNetWorkManager.h"
#import "UBLNetWorkClient.h"
#import "UBLNetWorkResult.h"

@implementation UBLNetWorkManager

+ (NSURLSessionDataTask *)postRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters finished:(resultInfoBlock)finished {
    UBLNetWorkClient *client = [UBLNetWorkClient shareClient];
    NSString *urlStr = urlPath;
    if(![urlPath containsString:@"http"]) {
        urlStr = [NSString stringWithFormat:@"%@/%@", client.baseUrlString, urlPath];
        NSLog(@"urlStr = %@",urlStr);
    }
    NSDictionary *header = [self setHeadersWithUrlpath:urlPath parameters:parameters client:client];
    return [client POST:urlStr parameters:parameters headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(finished)finished([UBLNetWorkResult resultWithResultObject:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(finished)finished([UBLNetWorkResult resultWithError:error]);
    }];
}

+ (NSURLSessionDataTask *)getRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters finished:(resultInfoBlock)finished {
    UBLNetWorkClient *client = [UBLNetWorkClient shareClient];
    NSString *urlStr = urlPath;
    if(![urlPath containsString:@"http"]) {
        urlStr = [NSString stringWithFormat:@"%@/%@", client.baseUrlString, urlPath];
        NSLog(@"urlStr = %@",urlStr);
    }
    NSDictionary *header = [self setHeadersWithUrlpath:urlPath parameters:parameters client:client];
    return [client GET:urlStr parameters:parameters headers:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(finished)finished([UBLNetWorkResult resultWithResultObject:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(finished)finished([UBLNetWorkResult resultWithError:error]);
    }];
}


+ (NSURLSessionDataTask *)putRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters finished:(resultInfoBlock)finished{
    UBLNetWorkClient *client = [UBLNetWorkClient shareClient];
    NSString *urlStr = urlPath;
    if(![urlPath containsString:@"http"]) {
        urlStr = [NSString stringWithFormat:@"%@/%@", client.baseUrlString, urlPath];
        NSLog(@"urlStr = %@",urlStr);
    }
    NSDictionary *header = [self setHeadersWithUrlpath:urlPath parameters:parameters client:client];
    return  [client PUT:urlStr parameters:parameters headers:header success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(finished)finished([UBLNetWorkResult resultWithResultObject:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(finished)finished([UBLNetWorkResult resultWithError:error]);
    }];
    
}


+ (NSURLSessionDataTask *)deleteRequestWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters finished:(resultInfoBlock)finished{
    UBLNetWorkClient *client = [UBLNetWorkClient shareClient];
    NSString *urlStr = urlPath;
    if(![urlPath containsString:@"http"]) {
        urlStr = [NSString stringWithFormat:@"%@/%@", client.baseUrlString, urlPath];
        NSLog(@"urlStr = %@",urlStr);
    }
    NSDictionary *header = [self setHeadersWithUrlpath:urlPath parameters:parameters client:client];
    return  [client DELETE:urlStr parameters:parameters headers:header success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(finished)finished([UBLNetWorkResult resultWithResultObject:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(finished)finished([UBLNetWorkResult resultWithError:error]);
    }];
}


+ (NSURLSessionDataTask *)uploadImageWithUrlPath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters image:(UIImage *)image finished:(resultInfoBlock)finished {
    UBLNetWorkClient *client = [UBLNetWorkClient shareClient];
    NSString *urlStr = urlPath;
    if(![urlPath containsString:@"http"]) {
        urlStr = [NSString stringWithFormat:@"%@/%@", client.baseUrlString, urlPath];
        NSLog(@"urlStr = %@",urlStr);
    }
    NSDictionary *header = [self setHeadersWithUrlpath:urlPath parameters:parameters client:client];
    return [client POST:urlStr parameters:parameters headers:header constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
        NSString *imgName = [parameters objectForKey:@"cc_imageName"] ?: @"file";
        [formData appendPartWithFileData:imgData name:imgName fileName:[imgName stringByAppendingString:@".jpg"] mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(finished)finished([UBLNetWorkResult resultWithResultObject:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(finished)finished([UBLNetWorkResult resultWithError:error]);
    }];
}

+ (NSDictionary *)setHeadersWithUrlpath:(NSString *)urlPath parameters:(NSDictionary *_Nullable)parameters client:(AFHTTPSessionManager *)client {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setValue:[NSString stringWithFormat:@"Bearer %@", @""] forKey:@"Authorization"];
    [dict setValue:@"0" forKey:@"hq_source"];
    [dict setValue:[UBLTools idfv] forKey:@"hq_deviceId"];
    return dict;
    
}

@end
