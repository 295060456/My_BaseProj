//
//  JobsAppDoorConfig.h
//  JobsAppDoor
//
//  Created by Jobs on 2020/12/7.
//

#import <Foundation/Foundation.h>

#define JobsAppDoorContentViewLeftHeight  SCREEN_HEIGHT / 1.7 // 竖形按钮在左边
#define JobsAppDoorContentViewRightHeight  SCREEN_HEIGHT / 2.5 // 竖形按钮在右边

#define Cor1 [kBlackColor colorWithAlphaComponent:0.6f]
#define Cor2 [kWhiteColor colorWithAlphaComponent:0.7f]

static float ThingsHeight = 50;//边角半圆形控件的高度
static float RegisterBtnWidth = 64;//竖形按钮的宽度
static float InputViewOffset = 20;//输入框承接控件之间的上下间距
static NSString * _Nullable btnTitle1 = @"返\n回\n登\n录";
static NSString * _Nullable btnTitle2 = @"新\n用\n户\n注\n册";

typedef NS_ENUM(NSInteger, CurrentPage) {
    CurrentPage_login = 0,
    CurrentPage_register
};

typedef NS_ENUM(NSInteger, JobsAppDoorBgType){
    JobsAppDoorBgType_Image = 0,//背景只是一张图
    JobsAppDoorBgType_video//背景是视频资源
};

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorConfig : NSObject

@end

NS_ASSUME_NONNULL_END
