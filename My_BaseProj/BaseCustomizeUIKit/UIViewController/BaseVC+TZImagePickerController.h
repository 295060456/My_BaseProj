//
//  BaseVC+TZImagePickerController.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (TZImagePickerController)
<
TZImagePickerControllerDelegate
>
#pragma mark —— BaseVC+TZImagePickerController
@property(nonatomic,strong)TZImagePickerController *imagePickerVC;
///点选的图片
-(void)GettingPicBlock:(MKDataBlock)block;
///访问相册 —— 选择图片
-(void)choosePic;
///访问摄像头
-(void)camera:(NSString *)doSth;

@end

NS_ASSUME_NONNULL_END
