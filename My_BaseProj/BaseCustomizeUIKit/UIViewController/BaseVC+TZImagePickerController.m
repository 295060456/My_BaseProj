//
//  BaseVC+TZImagePickerController.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+TZImagePickerController.h"
#import "BaseVC+AlertController.h"
#import <objc/runtime.h>

@implementation BaseVC (TZImagePickerController)

static char *BaseVC_TZImagePickerController_imagePickerVC;
@dynamic imagePickerVC;
///点选的图片
-(void)GettingPicBlock:(MKDataBlock)block{
    self.picBlock = block;
}
///访问相册 —— 选择图片
-(void)choosePic{
    @weakify(self)
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Photos
                                          accessStatus:^(ECAuthorizationStatus status,
                                                         ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            [self presentViewController:self.imagePickerVC
                                     animated:YES
                                   completion:nil];
        }else{
            NSLog(@"相册不可用:%lu",(unsigned long)status);
            [self alertControllerStyle:SYS_AlertController
                    showAlertViewTitle:@"获取相册权限"
                               message:nil
                       isSeparateStyle:YES
                           btnTitleArr:@[@"去获取"]
                        alertBtnAction:@[@"pushToSysConfig"]];
        }
    }];
}
///访问摄像头
-(void)camera:(NSString *)doSth{
    //先鉴权
    @weakify(self)
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Camera
                                          accessStatus:^(ECAuthorizationStatus status,
                                                         ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            //允许访问摄像头后需要做的操作
            [self performSelector:NSSelectorFromString(doSth)
                       withObject:Nil];
        }else{
            NSLog(@"摄像头不可用:%lu",(unsigned long)status);
            [self alertControllerStyle:SYS_AlertController
                    showAlertViewTitle:@"获取摄像头权限"
                               message:nil
                       isSeparateStyle:YES
                           btnTitleArr:@[@"去获取"]
                        alertBtnAction:@[@"pushToSysConfig"]];
        }
    }];
}
#pragma mark —— lazyLoad
-(TZImagePickerController *)imagePickerVC{
    TZImagePickerController *ImagePickerVC = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_imagePickerVC);
    if (!ImagePickerVC) {
        ImagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:9
                                                                        delegate:self];
        @weakify(self)
        [ImagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,
                                                          NSArray *assets,
                                                          BOOL isSelectOriginalPhoto) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(photos);
            }
        }];
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_imagePickerVC,
                                 ImagePickerVC,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ImagePickerVC;
}


@end
