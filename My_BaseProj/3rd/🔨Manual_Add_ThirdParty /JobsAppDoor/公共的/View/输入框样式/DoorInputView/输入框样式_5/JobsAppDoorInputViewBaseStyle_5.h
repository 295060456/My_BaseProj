//
//  JobsAppDoorInputViewBaseStyle_5.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import "JobsAppDoorInputViewBaseStyle.h"
#import "ZYTextField.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    InputViewStyle_5_1 = 0,
    InputViewStyle_5_2
} InputViewStyle_5;


@interface JobsAppDoorInputViewTFModel : NSObject

@property(nonatomic,strong)NSString *resString;

@end

@interface JobsAppDoorInputViewBaseStyle_5 : JobsAppDoorInputViewBaseStyle

@property(nonatomic,assign)InputViewStyle_5 style_5;

-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel;//外层数据渲染
-(void)actionBlockDoorInputViewStyle_5:(MKDataBlock)doorInputViewStyle_5Block;//监测输入字符回调 和 激活的textField

@end

NS_ASSUME_NONNULL_END
