//
//  InputView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputView : UIView

@property(nonatomic,strong)ZYTextField *textField;
@property(nonatomic,assign)BOOL isReturnBtnSelect;
@property(nonatomic,strong)NSString *tfContentStr;//键盘失去焦点的时候，会自动清除键盘里面的已经输入的内容

-(void)hideSendBtn;
///发送
-(void)actionInputViewBlock:(MKDataBlock)inputViewActionBlock;
///删除
-(void)actionisInputtingBlock:(MKDataBlock)isInputtingActionBlock;
///当前输入框是否失去焦点（是否活跃）
-(void)actionisInputViewActiveBlock:(MKDataBlock)isInputViewActiveBlock;

@end

NS_ASSUME_NONNULL_END
