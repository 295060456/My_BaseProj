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

-(NSString *)token{
    if (!_token) {
        _token = @"";
    }return _token;
}

@end

@interface UBLUserInfo ()

@end

@implementation UBLUserInfo

static UBLUserInfo *static_userInfo = nil;
@synthesize userInfoModel = _userInfoModel;

+ (void)load {
    [[UBLUserInfo sharedInstance] readUserInfo];
}

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

- (void)setUserInfoModel:(UBLUserInfoModel *)userInfoModel {
    _userInfoModel = userInfoModel;
    if(_userInfoModel) {
        [self saveUserInfo];
    }else {
        [self deleteUserInfo];
    }
}

- (BOOL)isLogin {
    return self.userInfoModel && self.userInfoModel.token.length > 0;
}

static NSString *userDataKey = @"userDataKey";
- (void)saveUserInfo {
    if(!self.userInfoModel)return;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.userInfoModel.mj_keyValues forKey:userDataKey];
    [defaults synchronize];
}

- (void)deleteUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:userDataKey];
    [defaults synchronize];
}

- (void)readUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = [defaults objectForKey:userDataKey];
    if(!userDict)return;
    self.userInfoModel = [UBLUserInfoModel mj_objectWithKeyValues:userDict];
}

@end
