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

static char *BaseVC_TZImagePickerController_imagePickerVC = "BaseVC_TZImagePickerController_imagePickerVC";
static char *BaseVC_TZImagePickerController_tzImagePickerControllerType = "BaseVC_TZImagePickerController_tzImagePickerControllerType";
static char *BaseVC_TZImagePickerController_picBlock = "BaseVC_TZImagePickerController_picBlock";
static char *BaseVC_TZImagePickerController_maxImagesCount = "BaseVC_TZImagePickerController_maxImagesCount";
static char *BaseVC_TZImagePickerController_columnNumber = "BaseVC_TZImagePickerController_columnNumber";
static char *BaseVC_TZImagePickerController_index = "BaseVC_TZImagePickerController_index";
static char *BaseVC_TZImagePickerController_isPushPhotoPickerVc = "BaseVC_TZImagePickerController_isPushPhotoPickerVc";
static char *BaseVC_TZImagePickerController_selectedAssets = "BaseVC_TZImagePickerController_selectedAssets";
static char *BaseVC_TZImagePickerController_selectedPhotos = "BaseVC_TZImagePickerController_selectedPhotos";
static char *BaseVC_TZImagePickerController_photo = "BaseVC_TZImagePickerController_photo";
static char *BaseVC_TZImagePickerController_asset = "BaseVC_TZImagePickerController_asset";

@dynamic imagePickerVC;
@dynamic tzImagePickerControllerType;
@dynamic picBlock;
@dynamic maxImagesCount;
@dynamic columnNumber;
@dynamic index;
@dynamic isPushPhotoPickerVc;
@dynamic selectedAssets;
@dynamic selectedPhotos;
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
            self.imagePickerVC.allowPickingOriginalPhoto = YES;
            self.imagePickerVC.allowPickingGif = YES;
            self.imagePickerVC.sortAscendingByModificationDate = YES;
            self.imagePickerVC.showSelectBtn = NO;
            self.imagePickerVC.allowCrop = YES;
            self.imagePickerVC.needCircleCrop = YES;
            //图片裁剪 方式方法_1
//            NSInteger left = 30;
//            NSInteger widthHeight = self.view.mj_w - 2 * left;
//            NSInteger top = (self.view.mj_h - widthHeight) / 2;
//            self.imagePickerVC.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
//            self.imagePickerVC.scaleAspectFillCrop = YES;

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
        }return nil;
    }];
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)TZImagePickerController *imagePickerVC;
//分类里面只能写self.属性，所以每次都优先走get方法再走set
-(TZImagePickerController *)imagePickerVC{
    TZImagePickerController *imagePickerController = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_imagePickerVC);
    if (!imagePickerController) {
        switch (self.tzImagePickerControllerType){
            case TZImagePickerControllerType_1:{
                imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImagesCount
                                                                                       delegate:self];
            }break;
            case TZImagePickerControllerType_2:{
                imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImagesCount
                                                                                   columnNumber:self.columnNumber
                                                                                       delegate:self];
            }break;
            case TZImagePickerControllerType_3:{
                imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImagesCount
                                                                                   columnNumber:self.columnNumber
                                                                                       delegate:self
                                                                              pushPhotoPickerVc:YES];
            }break;
            case TZImagePickerControllerType_4:{
                imagePickerController = [[TZImagePickerController alloc] initWithSelectedAssets:self.selectedAssets
                                                                                 selectedPhotos:self.selectedPhotos
                                                                                          index:self.index];
            }break;
            case TZImagePickerControllerType_5:{
                imagePickerController = [[TZImagePickerController alloc] initCropTypeWithAsset:self.asset
                                                                                         photo:self.photo
                                                                                    completion:^(UIImage *cropImage,
                                                                                                 PHAsset *asset) {
                }];
            }break;

            default:
                NSAssert(imagePickerController,@"imagePickerController 创建出现错误");
                break;
        }
            
        @weakify(self)
        [imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,
                                                          NSArray *assets,
                                                          BOOL isSelectOriginalPhoto) {
            @strongify(self)
            if (self.picBlock) {
                self.picBlock(photos);
            }
        }];
        objc_setAssociatedObject(self,
                                 BaseVC_TZImagePickerController_imagePickerVC,
                                 imagePickerController,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return imagePickerController;
}

-(void)setImagePickerVC:(TZImagePickerController *)imagePickerVC{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_imagePickerVC,
                             imagePickerVC,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSInteger maxImagesCount;
-(NSInteger)maxImagesCount{
    NSInteger MaxImagesCount = [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_maxImagesCount) integerValue];
    MaxImagesCount = MaxImagesCount != 0 ? : 1;
    return MaxImagesCount;
}

-(void)setMaxImagesCount:(NSInteger)maxImagesCount{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_maxImagesCount,
                             [NSNumber numberWithInteger:maxImagesCount],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)NSInteger columnNumber;
-(NSInteger)columnNumber{
    return [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_columnNumber) integerValue];
}

- (void)setColumnNumber:(NSInteger)columnNumber{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_columnNumber,
                             [NSNumber numberWithInteger:columnNumber],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)NSInteger index;
-(NSInteger)index{
    return [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_index) integerValue];
}

-(void)setIndex:(NSInteger)index{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_index,
                             [NSNumber numberWithInteger:index],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)BOOL isPushPhotoPickerVc;
-(BOOL)isPushPhotoPickerVc{
    return [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_isPushPhotoPickerVc) boolValue];
}

- (void)setIsPushPhotoPickerVc:(BOOL)isPushPhotoPickerVc{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_isPushPhotoPickerVc,
                             [NSNumber numberWithBool:isPushPhotoPickerVc],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray *selectedAssets;
-(void)setSelectedAssets:(NSMutableArray *)selectedAssets{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_selectedAssets,
                             selectedAssets,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
#pragma mark —— @property(nonatomic,strong)NSMutableArray *selectedPhotos;
-(void)setSelectedPhotos:(NSMutableArray *)selectedPhotos{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_selectedPhotos,
                             selectedPhotos,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
#pragma mark —— @property(nonatomic,strong)UIImage *photo;
-(UIImage *)photo{
    UIImage *Photo = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_photo);
    if (!Photo) {
        
    }return Photo;
}

-(void)setPhoto:(UIImage *)photo{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_photo,
                             photo,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)PHAsset *asset;
-(PHAsset *)asset{
    PHAsset *ASset = objc_getAssociatedObject(self, BaseVC_TZImagePickerController_asset);
    if (!ASset) {
        
    }return ASset;
}

-(void)setAsset:(PHAsset *)asset{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_asset,
                             asset,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)TZImagePickerControllerType tzImagePickerControllerType;
-(TZImagePickerControllerType)tzImagePickerControllerType{
    return [objc_getAssociatedObject(self, BaseVC_TZImagePickerController_tzImagePickerControllerType) integerValue];
}

-(void)setTzImagePickerControllerType:(TZImagePickerControllerType)tzImagePickerControllerType{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_tzImagePickerControllerType,
                             [NSNumber numberWithInteger:tzImagePickerControllerType],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock picBlock;
-(MKDataBlock)picBlock{
    return objc_getAssociatedObject(self, BaseVC_TZImagePickerController_picBlock);
}

-(void)setPicBlock:(MKDataBlock)picBlock{
    objc_setAssociatedObject(self,
                             BaseVC_TZImagePickerController_picBlock,
                             picBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
