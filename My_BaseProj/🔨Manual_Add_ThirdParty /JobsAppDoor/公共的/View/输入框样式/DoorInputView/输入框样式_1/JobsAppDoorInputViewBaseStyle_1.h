//
//  JobsAppDoorInputViewBaseStyle_1.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorInputViewBaseStyle.h"
#import "JobsAppDoorInputViewBaseStyleModel.h"
#import "UIButton+CountDownBtn.h"
#import "JobsMagicTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorInputViewBaseStyle_1 : JobsAppDoorInputViewBaseStyle

-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel;//外层数据渲染
-(void)actionBlockDoorInputViewStyle_1:(MKDataBlock)doorInputViewStyle_1Block;//监测输入字符回调 和 激活的textField

@end

NS_ASSUME_NONNULL_END
