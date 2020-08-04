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

static char *BaseVC_BRStringPickerView_stringPickerView;
static char *BaseVC_BRStringPickerView_brStringPickerMode;
static char *BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr;

@dynamic stringPickerView;
@dynamic brStringPickerMode;
@dynamic BRStringPickerViewDataMutArr;

-(void)BRStringPickerViewBlock:(MKDataBlock)block{
    self.brStringPickerViewBlock = block;
}
#pragma mark —— lazyLoad
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

-(BRStringPickerMode)brStringPickerMode{
    NSInteger BrStringPickerMode = [objc_getAssociatedObject(self, BaseVC_BRStringPickerView_brStringPickerMode) integerValue];
    if (BrStringPickerMode == 0) {
//        BrStringPickerMode = 1;
        objc_setAssociatedObject(self,
                                 BaseVC_BRStringPickerView_brStringPickerMode,
                                 [NSNumber numberWithInteger:BrStringPickerMode],
                                 OBJC_ASSOCIATION_ASSIGN);
    }return BrStringPickerMode;
}

-(NSArray *)BRStringPickerViewDataMutArr{
    NSArray *bRStringPickerViewDataMutArr = objc_getAssociatedObject(self, BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr);
    if (!bRStringPickerViewDataMutArr) {
        bRStringPickerViewDataMutArr = NSArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr,
                                 bRStringPickerViewDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return bRStringPickerViewDataMutArr;
}

@end
