//
//  UBLUserInfo.h
//  UBallLive
//
//  Created by Jobs on 2020/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UBLUserInfoModel : NSObject

@property(nonatomic,copy)NSString *account;
@property(nonatomic,copy)NSString *headImage;
@property(nonatomic,copy)NSString *mobilePhone;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,assign)BOOL sex;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,assign)NSInteger uid;

@end

@interface UBLUserInfo : NSObject

@property(nonatomic,strong)UBLUserInfoModel *userInfoModel;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
