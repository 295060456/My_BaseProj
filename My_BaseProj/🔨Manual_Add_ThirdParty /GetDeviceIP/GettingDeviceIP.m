//
//  GettingDeviceIP.m
//  Feidegou
//
//  Created by Kite on 2019/12/4.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "GettingDeviceIP.h"

@implementation GettingDeviceIP

//获取ip地址
+(NSString *)getIPaddress{
    NSString *address = @"error";
    struct ifaddrs * ifaddress = NULL;
    struct ifaddrs * temp_address = NULL;
    int success = 0;
    success = getifaddrs(&ifaddress);
    if(success == 0) {
        temp_address = ifaddress;
        while(temp_address != NULL) {
            if(temp_address->ifa_addr->sa_family == AF_INET) {
              if([[NSString stringWithUTF8String:temp_address->ifa_name] isEqualToString:@"en0"]) {
         address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_address->ifa_addr)->sin_addr)];
                }
            }
            temp_address = temp_address->ifa_next;
        }
    }
    NSLog(@"获取到的IP地址为：%@",address);
    return address;
}

@end
