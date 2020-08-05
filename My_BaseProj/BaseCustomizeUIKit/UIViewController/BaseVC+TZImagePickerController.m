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
static char *BaseVC_TZImagePickerController_tzImagePickerControllerType;
static char *BaseVC_TZImagePickerController_maxImagesCount;
static char *BaseVC_TZImagePickerController_columnNumber;
static char *BaseVC_TZImagePickerController_isPushPhotoPickerVc;
static char *BaseVC_TZImagePickerController_index;
static char *BaseVC_TZImagePickerController_selectedAssets;
static char *BaseVC_TZImagePickerController_selectedPhotos;
static char *BaseVC_TZImagePickerController_photo;
static char *BaseVC_TZImagePickerController_asset;

@dynamic maxImagesCount;
@dynamic columnNumber;
@dynamic isPushPhotoPickerVc;
@dynamic selectedAssets;
@dynamic selectedPhotos;
@dynamic imagePickerVC;
@dynamic tzImagePickerControllerType;
@dynamic index;
@dynamic photo;
@dynamic asset;
///点选的图片
-(void)GettingPicBlock:(MKDataBlock)block{
    self.picBlock = block;
}
///访问相册 —— 选择图片
-(void)choosePic:(TZImagePickerControllerType)tzImagePickerControllerType{
    self.tzImagePickerControllerType = tzImagePickerControllerType;
    @weakify(self)
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Photos
                                          accessStatus:^id(ECAuthorizationStatus status,
                                                           ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            [self presentViewController:self.imagePickerVC
                                     animated:YES
                                   completion:nil];
            return self.imagePickerVC;
        }else{
            NSLog(@"相册不可用:%lu",(unsigned long)status);
            [self alertControllerStyle:SYS_AlertController
                    showAlertViewTitle:@"获取相册权限"
                               message:nil
                       isSeparateStyle:YES
                           btnTitleArr:@[@"去获取"]
                        alertBtnAction:@[@"pushToSysConfig"]
                          alertVCBlock:^(id data) {
                //DIY
            }];
            return nil;
        }
    }];
}
///访问摄像头
-(void)camera:(NSString *)doSth{
    //先鉴权
    @weakify(self)
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Camera
                                          accessStatus:^id(ECAuthorizationStatus status,
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
                        alertBtnAction:@[@"pushToSysConfig"]
                          alertVCBlock:^(id data) {
                //DIY
            }];
        }
        return nil;
    }];
}
#pragma mark —— lazyLoad
-(TZImagePickerController *)imagePickerVC{
    TZImagePickerController *ImagePickerVC = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_imagePickerVC);
    if (!ImagePickerVC) {
        switch (self.tzImagePickerControllerType) {
            case TZImagePickerControllerType_1:{
                ImagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImagesCount
                                                                                delegate:self];
            }break;
            case TZImagePickerControllerType_2:{
                ImagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImagesCount
                                                                           columnNumber:self.columnNumber
                                                                               delegate:self];
            }break;
            case TZImagePickerControllerType_3:{
                ImagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImagesCount
                                                                           columnNumber:self.columnNumber
                                                                               delegate:self
                                                                      pushPhotoPickerVc:YES];
            }break;
            case TZImagePickerControllerType_4:{
                ImagePickerVC = [[TZImagePickerController alloc] initWithSelectedAssets:self.selectedAssets
                                                                         selectedPhotos:self.selectedPhotos
                                                                                  index:self.index];
            }break;
            case TZImagePickerControllerType_5:{
                ImagePickerVC = [[TZImagePickerController alloc] initCropTypeWithAsset:self.asset
                                                                                 photo:self.photo
                                                                            completion:^(UIImage *cropImage, PHAsset *asset) {
                    
                }];
            }break;
                
            default:
                break;
        }

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

-(NSMutableArray *)selectedAssets{
    NSMutableArray *SelectedAssets = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_selectedAssets);
    if (!SelectedAssets) {
        SelectedAssets = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_selectedAssets,
                                 SelectedAssets,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return SelectedAssets;
}

-(NSMutableArray *)selectedPhotos{
    NSMutableArray *SelectedPhotos = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_selectedPhotos);
    if (!SelectedPhotos) {
        SelectedPhotos = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_selectedPhotos,
                                 SelectedPhotos,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return SelectedPhotos;
}

-(UIImage *)photo{
    UIImage *Photo = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_photo);
    if (!Photo) {
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_photo,
                                 Photo,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Photo;
}

-(PHAsset *)asset{
    PHAsset *Asset = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_asset);
    if (!Asset) {
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_asset,
                                 Asset,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Asset;
}

-(NSInteger)maxImagesCount{
    NSInteger MaxImagesCount = [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_maxImagesCount) integerValue];
    if (MaxImagesCount == 0) {
        MaxImagesCount = 1;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_maxImagesCount,
                                 [NSNumber numberWithInteger:MaxImagesCount],
                                 OBJC_ASSOCIATION_ASSIGN);
    }return MaxImagesCount;
}

-(NSInteger)columnNumber{
    NSInteger ColumnNumber = [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_columnNumber) integerValue];
    if (ColumnNumber == 0) {
        ColumnNumber = 1;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_columnNumber,
                                 [NSNumber numberWithInteger:ColumnNumber],
                                 OBJC_ASSOCIATION_ASSIGN);
    }return ColumnNumber;
}

-(BOOL)isPushPhotoPickerVc{
    BOOL IsPushPhotoPickerVc = [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_isPushPhotoPickerVc) boolValue];
    if (!IsPushPhotoPickerVc) {
        IsPushPhotoPickerVc = YES;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_isPushPhotoPickerVc,
                                 [NSNumber numberWithBool:IsPushPhotoPickerVc],
                                 OBJC_ASSOCIATION_ASSIGN);
    }return IsPushPhotoPickerVc;
}

-(TZImagePickerControllerType)tzImagePickerControllerType{
    NSInteger tZImagePickerControllerType = [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_tzImagePickerControllerType) integerValue];
    if (tZImagePickerControllerType == 0) {
//        tZImagePickerControllerType = 1;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_tzImagePickerControllerType,
                                 [NSNumber numberWithInteger:tZImagePickerControllerType],
                                 OBJC_ASSOCIATION_ASSIGN);
    }return tZImagePickerControllerType;
}

-(NSInteger)index{
    NSInteger Index = [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_index) integerValue];
    if (Index == 0) {
        Index = 1;
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_index,
                                 [NSNumber numberWithInteger:Index],
                                 OBJC_ASSOCIATION_ASSIGN);
    }return Index;
}

@end
