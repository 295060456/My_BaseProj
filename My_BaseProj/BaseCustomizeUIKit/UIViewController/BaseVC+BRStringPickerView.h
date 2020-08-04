//
//  BaseVC+BRStringPickerView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (BRStringPickerView)

#pragma mark —— BaseVC+BRStringPickerView
@property(nonatomic,strong)BRStringPickerView *stringPickerView;

-(void)BRStringPickerViewBlock:(MKDataBlock)block;

@end

NS_ASSUME_NONNULL_END
