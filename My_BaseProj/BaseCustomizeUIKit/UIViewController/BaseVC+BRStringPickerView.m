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
@dynamic stringPickerView;

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

@end
