//
//  JobsAppDoorInputViewBaseStyle_6.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/20.
//

#import "JobsAppDoorInputViewBaseStyle.h"
#import "JobsAppDoorInputViewBaseStyleModel.h"
#import "ImageCodeView.h"
#import "JobsMagicTextField.h"
#import "AuthCodeLab.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorInputViewBaseStyle_6 : JobsAppDoorInputViewBaseStyle

-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel;//外层数据渲染
-(void)actionBlockDoorInputViewStyle_6:(MKDataBlock)doorInputViewStyle_26Block;//监测输入字符回调 和 激活的textField

@end

NS_ASSUME_NONNULL_END
