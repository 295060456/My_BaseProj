//
//  DoorVC.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "UBLDoor.h"
#import "CustomZFPlayerControlView.h"
#import "UBLRetrievePasswordVC.h"
#import "UBLUserInfo.h"

typedef NS_ENUM(NSInteger, DoorBgType){
    doorBgType_Image = 0,//背景只是一张图
    doorBgType_video//背景是视频资源
};

NS_ASSUME_NONNULL_BEGIN
//注册和登录共用一个控制器DoorVC；忘记密码单独一个控制器
@interface UBLDoorVC : BaseViewController

//@property(nonatomic,strong,nullable)UBLLoginContentView *loginContentView;//登录页面

@property(nonatomic,strong)UBLUserInfoModel *userInfoModel;

-(void)overUI;

@end

NS_ASSUME_NONNULL_END
