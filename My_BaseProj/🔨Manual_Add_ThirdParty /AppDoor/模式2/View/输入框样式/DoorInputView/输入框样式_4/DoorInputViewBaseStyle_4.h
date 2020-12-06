//
//  DoorInputViewBaseStyle_4.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorInputViewBaseStyle.h"
#import "DoorInputViewBaseStyleModel.h"
#import "ImageCodeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoorInputViewBaseStyle_4 : DoorInputViewBaseStyle

-(void)richElementsInViewWithModel:(DoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel;//外层数据渲染
-(void)actionBlockDoorInputViewStyle_4:(MKDataBlock)doorInputViewStyle_4Block;//监测输入字符回调 和 激活的textField

@end

NS_ASSUME_NONNULL_END
