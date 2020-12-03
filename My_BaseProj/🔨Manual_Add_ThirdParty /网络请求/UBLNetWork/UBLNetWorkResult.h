//
//  UBLNetWorkResult.h
//  UBLLive
//
//  Created by . John on 2020/11/19.
//  Copyright © 2020 UBL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UBLNetWorkResult : NSObject

@property (strong, nonatomic) NSError *error;

@property (strong, nonatomic) NSDictionary *resultObject;

@property (strong, nonatomic) id resultData;

+ (instancetype)resultWithError:(NSError *)error;

+ (instancetype)resultWithResultObject:(id)resultObject;

@end

NS_ASSUME_NONNULL_END
