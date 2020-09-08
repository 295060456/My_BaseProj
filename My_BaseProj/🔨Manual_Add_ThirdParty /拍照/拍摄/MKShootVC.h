//
//  MKShootVC.h
//  Shooting
//
//  Created by Jobs on 2020/8/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"
#import "StartOrPauseBtn.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKShootVC : BaseVC

@property(nonatomic,strong)GPUImageTools *gpuImageTools;
@property(nonatomic,strong,nullable)__block StartOrPauseBtn *recordBtn;//录制的按钮

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

-(void)ActionMKShootVCBlock:(MKDataBlock)MKShootVCBlock;
///功能性的 删除tmp文件夹下的文件
-(void)delTmpRes;

@end

NS_ASSUME_NONNULL_END
