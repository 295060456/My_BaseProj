//
//  DoorInputViewBaseStyle_1.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorInputViewBaseStyle.h"
#import "DoorInputViewBaseStyleModel.h"
#import "UIButton+CountDownBtn.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoorInputViewBaseStyle_1 : DoorInputViewBaseStyle

-(void)richElementsInViewWithModel:(DoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel;//外层数据渲染
-(void)actionBlockDoorInputViewStyle_1:(MKDataBlock)doorInputViewStyle_1Block;//监测输入字符回调 和 激活的textField

@end

NS_ASSUME_NONNULL_END
