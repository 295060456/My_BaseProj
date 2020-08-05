//
//  BaseVC+FSCustomButton.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (FSCustomButton)

#pragma mark —— BaseVC+FSCustomButton
@property(nonatomic,strong)FSCustomButton *backBtnCategory;
#pragma mark —— 子类需要覆写
-(void)backBtnClickEvent:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
