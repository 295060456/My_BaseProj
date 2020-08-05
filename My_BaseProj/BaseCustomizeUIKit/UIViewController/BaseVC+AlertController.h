//
//  BaseVC+AlertController.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (AlertController)
#pragma mark —— BaseVC+AlertController
///
-(void)showLoginAlertView;
///屏幕正中央 isSeparateStyle如果为YES 那么有实质性进展的键位在右侧，否则在左侧
-(void)alertControllerStyle:(AlertControllerStyle)alertControllerStyle
         showAlertViewTitle:(nullable NSString *)title
                    message:(nullable NSString *)message
            isSeparateStyle:(BOOL)isSeparateStyle
                btnTitleArr:(NSArray <NSString *> *)btnTitleArr
             alertBtnAction:(NSArray <NSString *> *)alertBtnActionArr
               alertVCBlock:(MKDataBlock)alertVCBlock;
///
-(void)alertControllerStyle:(AlertControllerStyle)alertControllerStyle
       showActionSheetTitle:(nullable NSString *)title
                    message:(nullable NSString *)message
            isSeparateStyle:(BOOL)isSeparateStyle
                btnTitleArr:(NSArray <NSString *> *)btnTitleArr
             alertBtnAction:(NSArray <NSString *> *)alertBtnActionArr
                     sender:(nullable UIControl *)sender
               alertVCBlock:(MKDataBlock)alertVCBlock;

@end

NS_ASSUME_NONNULL_END
