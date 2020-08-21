//
//  MKLaunchingAdModel.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/27.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKLaunchingAdModel.h"

@implementation MKLaunchingAdModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
        @"ID" : @"id"
    };
}

@end

//#import "ViewController@1.h"
//#import "ViewController@2.h"
//
//#import "ViewController@5.h"
//
//#import "ViewController@3.h"
//#import "ViewController@4.h"
