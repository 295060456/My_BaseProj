//
//  UBLUserInfo.m
//  UBallLive
//
//  Created by Jobs on 2020/11/18.
//

#import "UBLUserInfo.h"

@interface UBLUserInfoModel ()

@end

@implementation UBLUserInfoModel

@end

@interface UBLUserInfo ()

@end

@implementation UBLUserInfo

static UBLUserInfo *static_userInfo = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_userInfo) {
            static_userInfo = UBLUserInfo.new;
        }
    }return static_userInfo;
}
#pragma mark —— lazyLoad
-(UBLUserInfoModel *)userInfoModel{
    if (!_userInfoModel) {
        _userInfoModel = UBLUserInfoModel.new;
    }return _userInfoModel;
}


@end
