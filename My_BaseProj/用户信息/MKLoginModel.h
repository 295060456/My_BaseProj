//
//  MKLoginModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/12/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

/// 用户信息数据模型
@interface MKLoginModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*account;
@property(nonatomic,strong)NSString <Optional>*nickName;
@property(nonatomic,strong)NSString <Optional>*tel;
@property(nonatomic,strong)NSString <Optional>*token;
@property(nonatomic,strong)NSString <Optional>*uid;

@property(nonatomic,strong)NSString <Optional>*age;
@property(nonatomic,strong)NSString <Optional>*area;
@property(nonatomic,strong)NSString <Optional>*balance;
@property(nonatomic,strong)NSString <Optional>*constellation;
@property(nonatomic,strong)NSString <Optional>*goldNumber;
@property(nonatomic,strong)NSString <Optional>*remark;


@property(nonatomic,strong)NSString <Optional>*zan;

@property(nonatomic,strong)NSString <Optional>*pin;

@property(nonatomic,strong)NSString <Optional>*fans;
//        account= 15566663333;
//        nickName = "姬敏博472";
//        tel = 15566663333;
//        token = 2a1db0b29fc6e72119647045bda640a7;
//        uid = 1282207141599461377;
@end

NS_ASSUME_NONNULL_END
