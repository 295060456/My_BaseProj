//
//  NSObject+SYSAlertController.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SYSAlertController)

///屏幕正中央 isSeparateStyle如果为YES 那么有实质性进展的键位在右侧，否则在左侧
+(void)showSYSAlertViewTitle:(nullable NSString *)title
                     message:(nullable NSString *)message
             isSeparateStyle:(BOOL)isSeparateStyle
                 btnTitleArr:(NSArray <NSString*>*)btnTitleArr
              alertBtnAction:(NSArray <NSString*>*)alertBtnActionArr
                    targetVC:(UIViewController *)targetVC
                alertVCBlock:(MKDataBlock)alertVCBlock;

+(void)showSYSActionSheetTitle:(nullable NSString *)title
                       message:(nullable NSString *)message
               isSeparateStyle:(BOOL)isSeparateStyle
                   btnTitleArr:(NSArray <NSString*>*)btnTitleArr
                alertBtnAction:(NSArray <NSString*>*)alertBtnActionArr
                      targetVC:(UIViewController *)targetVC
                        sender:(nullable UIControl *)sender
                  alertVCBlock:(MKDataBlock)alertVCBlock;

+(void)showLoginAlertViewWithTargetVC:(UIViewController *)targetVC;

-(void)defaultFunc;


@end

NS_ASSUME_NONNULL_END
