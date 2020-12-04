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

NS_ASSUME_NONNULL_BEGIN
@interface JobsAppDoorContentViewModel : NSObject

@property(nonatomic,assign)CGFloat contentViewLeftHeight;// 竖形按钮在左边
@property(nonatomic,assign)CGFloat contentViewRightHeight;// 竖形按钮在右边

@end

@interface JobsAppDoorContentView : UIView

@property(nonatomic,strong)UIButton *toRegisterBtn;//去注册

-(void)richElementsInViewWithModel:(JobsAppDoorContentViewModel *_Nullable)appDoorContentViewModel;//外层数据渲染
-(void)actionBlockJobsAppDoorContentView:(MKDataBlock)jobsAppDoorContentViewBlock;

@end

NS_ASSUME_NONNULL_END
