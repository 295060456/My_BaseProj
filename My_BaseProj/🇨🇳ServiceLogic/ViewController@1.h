//
//  ViewController@1.h
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController_1 : BaseVC

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
