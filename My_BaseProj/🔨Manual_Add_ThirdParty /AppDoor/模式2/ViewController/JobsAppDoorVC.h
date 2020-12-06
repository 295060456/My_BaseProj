//
//  JobsAppDoor.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "JobsAppDoorContentView.h"
#import "CustomZFPlayerControlView.h"
#import "UBLLogoContentView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JobsAppDoorBgType){
    JobsAppDoorBgType_Image = 0,//背景只是一张图
    JobsAppDoorBgType_video//背景是视频资源
};

@interface JobsAppDoorVC : BaseViewController

@end

NS_ASSUME_NONNULL_END
