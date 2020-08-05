//
//  BaseVC+BRStringPickerView.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+BRStringPickerView.h"
#import <objc/runtime.h>

@implementation BaseVC (BRStringPickerView)

static char *BaseVC_BRStringPickerView_stringPickerView = "BaseVC_BRStringPickerView_stringPickerView";
static char *BaseVC_BRStringPickerView_brStringPickerMode = "BaseVC_BRStringPickerView_brStringPickerMode";
static char *BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr = "BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr";
static char *BaseVC_BRStringPickerView_brStringPickerViewBlock = "BaseVC_BRStringPickerView_brStringPickerViewBlock";

@dynamic stringPickerView;
@dynamic brStringPickerMode;
@dynamic BRStringPickerViewDataMutArr;
@dynamic brStringPickerViewBlock;

-(void)BRStringPickerViewBlock:(MKDataBlock)block{
    self.brStringPickerViewBlock = block;
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)BRStringPickerView *stringPickerView;
-(BRStringPickerView *)stringPickerView{
    BRStringPickerView *StringPickerView = objc_getAssociatedObject(self, BaseVC_BRStringPickerView_stringPickerView);
    if (!StringPickerView) {
        StringPickerView = [[BRStringPickerView alloc] initWithPickerMode:self.brStringPickerMode];
        if (self.BRStringPickerViewDataMutArr.count > 2) {
            StringPickerView.title = self.BRStringPickerViewDataMutArr[0];
            NSMutableArray *temp = NSMutableArray.array;
            temp = self.BRStringPickerViewDataMutArr.copy;
            [temp removeObjectAtIndex:0];
            StringPickerView.dataSourceArr = temp;
        }
        @weakify(self)
        StringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
//            NSLog(@"选择的值：%@", resultModel.selectValue);
            @strongify(self)
            if (self.brStringPickerViewBlock) {
                self.brStringPickerViewBlock(resultModel);
            }
        };
        objc_setAssociatedObject(self,
                                 BaseVC_BRStringPickerView_stringPickerView,
                                 StringPickerView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return StringPickerView;
}

-(void)setStringPickerView:(BRStringPickerView *)stringPickerView{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_stringPickerView,
                             stringPickerView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)BRStringPickerMode brStringPickerMode;
-(BRStringPickerMode)brStringPickerMode{
    return [objc_getAssociatedObject(self, BaseVC_BRStringPickerView_brStringPickerMode) integerValue];
}

-(void)setBrStringPickerMode:(BRStringPickerMode)brStringPickerMode{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_brStringPickerMode,
                             [NSNumber numberWithInteger:brStringPickerMode],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock brStringPickerViewBlock;
-(MKDataBlock)brStringPickerViewBlock{
    return objc_getAssociatedObject(self, BaseVC_BRStringPickerView_brStringPickerViewBlock);
}

-(void)setBrStringPickerViewBlock:(MKDataBlock)brStringPickerViewBlock{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_brStringPickerViewBlock,
                             brStringPickerViewBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSArray *BRStringPickerViewDataMutArr;
-(NSArray *)BRStringPickerViewDataMutArr{
    NSArray *brStringPickerViewDataMutArr = objc_getAssociatedObject(self, BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr);
    if (!brStringPickerViewDataMutArr) {
        brStringPickerViewDataMutArr = NSArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr,
                                 brStringPickerViewDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return brStringPickerViewDataMutArr;
}

-(void)setBRStringPickerViewDataMutArr:(NSArray *)BRStringPickerViewDataMutArr{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr,
                             BRStringPickerViewDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
