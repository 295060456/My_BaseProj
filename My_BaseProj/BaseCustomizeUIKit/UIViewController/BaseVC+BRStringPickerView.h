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
@property(nonatomic,assign)BRStringPickerMode brStringPickerMode;
@property(nonatomic,copy)MKDataBlock brStringPickerViewBlock;
@property(nonatomic,strong)NSArray *BRStringPickerViewDataMutArr;

-(void)BRStringPickerViewBlock:(MKDataBlock)block;

@end

NS_ASSUME_NONNULL_END
