//
//  JobsAppDoorInputViewBaseStyleModel.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorInputViewBaseStyleModel.h"

@interface JobsAppDoorInputViewBaseStyleModel ()

@end

@implementation JobsAppDoorInputViewBaseStyleModel

-(UIFont *)titleStrFont{
    if (!_titleStrFont) {
        _titleStrFont = [UIFont systemFontOfSize:14
                                          weight:UIFontWeightRegular];
    }return _titleStrFont;
}

-(UIColor *)titleStrCor{
    if (!_titleStrCor) {
        _titleStrCor = kBlackColor;
    }return _titleStrCor;
}

@end
