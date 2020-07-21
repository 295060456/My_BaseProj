//
//  MKPublickDataManager.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/12/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKLoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MKPublickDataManager : NSObject

@property(nonatomic, assign)BOOL      isLogin;    //YES.登录中，NO未登录

/// 用户信息
@property (strong,nonatomic) MKLoginModel *mkLoginModel;

#pragma mark - 单例
+ (MKPublickDataManager *) sharedPublicDataManage;
@end

NS_ASSUME_NONNULL_END
