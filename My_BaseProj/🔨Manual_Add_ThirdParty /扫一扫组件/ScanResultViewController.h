//
//  ScanResultViewController.h
//  LBXScanDemo
//
//  Created by lbxia on 15/11/17.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultViewController : BaseVC

+ (instancetype _Nullable )ComingFromVC:(UIViewController *_Nullable)rootVC
                              withStyle:(ComingStyle)comingStyle
                          requestParams:(nullable id)requestParams
                                success:(MKDataBlock _Nullable )block
                               animated:(BOOL)animated;

@end
