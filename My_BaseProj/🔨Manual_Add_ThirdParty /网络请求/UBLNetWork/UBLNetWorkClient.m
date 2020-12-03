//
//  UBLNetWorkClient.m
//  UBLLive
//
//  Created by . John on 2020/11/19.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "UBLNetWorkClient.h"

@implementation UBLNetWorkClient

+ (instancetype)shareClient {
    static UBLNetWorkClient* client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
        client.requestSerializer = [AFJSONRequestSerializer serializer];
        client.responseSerializer = [AFJSONResponseSerializer serializer];
        client.requestSerializer.timeoutInterval = 30;
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        client.securityPolicy = securityPolicy;
        client.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", @"application/octet-stream", @"application/zip"]];
        [client.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
#if DEBUG
//        client.baseUrlString = @"http://222.186.150.148:13000";
//        client.baseUrlString = [NSString stringWithFormat:@"%@:%@",UBLBaseURL,UBLUrlPort];
        //@"http://222.186.150.148:12100";
#else
//        client.baseUrlString = [NSString stringWithFormat:@"%@:%@",UBLBaseURL,UBLUrlPort];
#endif

    });
    return client;
}

@end
