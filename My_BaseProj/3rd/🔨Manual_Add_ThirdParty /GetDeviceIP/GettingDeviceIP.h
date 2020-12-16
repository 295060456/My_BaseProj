//
//  GettingDeviceIP.h
//  Feidegou
//
//  Created by Kite on 2019/12/4.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GettingDeviceIP : NSObject

+(NSString *)getIPaddress;//获取ip地址
+(BOOL)isValidatIP:(NSString *)ipAddress;
+(NSDictionary *)getIPAddresses;
+(NSString *)getLocalIPAddress:(BOOL)preferIPv4;
+(NSString *)getNetworkIPAddress;


@end

NS_ASSUME_NONNULL_END
