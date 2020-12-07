//
//  DoorInputViewBaseStyle_3.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorInputViewBaseStyle.h"
#import "DoorInputViewBaseStyleModel.h"
#import "JobsMagicTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoorInputViewBaseStyle_3 : DoorInputViewBaseStyle

-(void)richElementsInViewWithModel:(DoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel;//外层数据渲染
-(void)actionBlockDoorInputViewStyle_3:(MKDataBlock)doorInputViewStyle_3Block;//监测输入字符回调 和 激活的textField

@end

NS_ASSUME_NONNULL_END
