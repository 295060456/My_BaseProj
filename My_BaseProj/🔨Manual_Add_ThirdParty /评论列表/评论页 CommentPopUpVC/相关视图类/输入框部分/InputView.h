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

-(void)actionInputViewBlock:(MKDataBlock)inputViewActionBlock;

-(void)actionisInputtingBlock:(MKDataBlock)isInputtingActionBlock;

@end

NS_ASSUME_NONNULL_END
