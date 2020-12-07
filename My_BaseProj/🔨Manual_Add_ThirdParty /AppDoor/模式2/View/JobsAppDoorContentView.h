//
//  JobsAppDoorContentView.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoorInputViewBaseStyleModel.h"
#import "DoorInputView.h"

#define Cor1 [kBlackColor colorWithAlphaComponent:0.6f]
#define Cor2 [kWhiteColor colorWithAlphaComponent:0.7f]

NS_ASSUME_NONNULL_BEGIN
@interface JobsAppDoorContentViewModel : NSObject

@property(nonatomic,assign)CGFloat contentViewLeftHeight;// 竖形按钮在左边
@property(nonatomic,assign)CGFloat contentViewRightHeight;// 竖形按钮在右边

@end

@interface JobsAppDoorContentView : UIView

@property(nonatomic,strong)NSMutableArray <DoorInputViewBaseStyle *>*loginDoorInputViewBaseStyleMutArr;
@property(nonatomic,strong)NSMutableArray <DoorInputViewBaseStyle *>*registerDoorInputViewBaseStyleMutArr;

-(void)richElementsInViewWithModel:(JobsAppDoorContentViewModel *_Nullable)appDoorContentViewModel;//外层数据渲染
-(void)actionBlockJobsAppDoorContentView:(MKDataBlock)jobsAppDoorContentViewBlock;//监测输入字符回调 和 激活的textField 和 toRegisterBtn/abandonLoginBtn点击事件

@end

NS_ASSUME_NONNULL_END
