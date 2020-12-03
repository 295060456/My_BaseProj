//
//  UBLNetWorkClient.h
//  UBLLive
//
//  Created by . John on 2020/11/19.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLNetWorkClient : AFHTTPSessionManager

+ (instancetype)shareClient;

@property (copy, nonatomic) NSString *baseUrlString;


@end

NS_ASSUME_NONNULL_END
