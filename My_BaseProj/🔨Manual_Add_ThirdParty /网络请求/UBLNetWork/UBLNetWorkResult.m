//
//  UBLNetWorkResult.m
//  UBLLive
//
//  Created by . John on 2020/11/19.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "UBLNetWorkResult.h"

@implementation UBLNetWorkResult

+ (instancetype)resultWithError:(NSError *)error {
    UBLNetWorkResult *result = [[UBLNetWorkResult alloc] init];
    result.error = error;
    [MBProgressHUD showError:result.error.userInfo[@"NSLocalizedDescription"]];
    return result;
}

+ (instancetype)resultWithResultObject:(id)resultObject {
    NSString *errorDefault = @"未知错误";
    if(!resultObject || ![resultObject isKindOfClass:[NSDictionary class]]) {
        NSError *error =  [NSError errorWithDomain:errorDefault code:10000 userInfo:@{NSLocalizedDescriptionKey: errorDefault}];
        return [self resultWithError:error];
    }
    NSInteger code = [[resultObject objectForKey:@"code"] integerValue];
    NSString *msg = [resultObject objectForKey:@"msg"] ? : errorDefault;
    NSString *data = [resultObject objectForKey:@"data"];
    if(code != 200) {
        NSError *error = [NSError errorWithDomain:errorDefault code:code userInfo:@{NSLocalizedDescriptionKey: msg}];
        return [self resultWithError:error];
    }else {
        UBLNetWorkResult *result = [[UBLNetWorkResult alloc] init];
        result.resultObject = (NSDictionary *)resultObject;
        result.resultData = data;
        NSLog(@"result.resultData = %@",result.resultData);
        return result;
    }
}

@end
