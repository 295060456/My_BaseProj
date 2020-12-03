//
//  RegisterContentView.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBLDoorInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLRegisterContentView : UIView

@property(nonatomic,strong)NSMutableArray <UBLDoorInputViewBaseStyle *> *inputViewMutArr;

-(void)showRegisterContentViewWithOffsetY:(CGFloat)offsetY;
-(void)removeRegisterContentViewWithOffsetY:(CGFloat)offsetY;

-(void)actionRegisterContentViewBlock:(MKDataBlock)registerContentViewBlock;//主要是按钮点击事件的回调
-(void)actionRegisterContentViewKeyboardBlock:(MKDataBlock)registerContentViewKeyboardBlock;//键盘响应事件的回调
-(void)actionRegisterContentViewTFBlock:(MKDataBlock)registerContentViewTFBlock;//输入框内容回调

@end

NS_ASSUME_NONNULL_END
