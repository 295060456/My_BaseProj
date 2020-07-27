//
//  CreateBarCodeVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateBarCodeVC : BaseVC

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                   withStyle:(ComingStyle)comingStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
