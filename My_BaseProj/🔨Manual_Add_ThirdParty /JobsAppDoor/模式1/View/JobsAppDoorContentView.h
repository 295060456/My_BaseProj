//
//  JobsAppDoorContentView.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobsAppDoorInputViewBaseStyleModel.h"
#import "JobsAppDoorInputView.h"
#import "JobsAppDoorConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorContentView : UIView

@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyle *>*loginDoorInputViewBaseStyleMutArr;
@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyle *>*registerDoorInputViewBaseStyleMutArr;

-(void)richElementsInViewWithModel:(id _Nullable)contentViewModel;//外层数据渲染
-(void)actionBlockJobsAppDoorContentView:(MKDataBlock)jobsAppDoorContentViewBlock;//监测输入字符回调 和 激活的textField 和 toRegisterBtn/abandonLoginBtn点击事件

@end

NS_ASSUME_NONNULL_END
