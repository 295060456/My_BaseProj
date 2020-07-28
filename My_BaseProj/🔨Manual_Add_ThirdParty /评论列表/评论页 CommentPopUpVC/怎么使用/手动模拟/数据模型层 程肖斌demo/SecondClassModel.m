//
//  LowModel.m
//  eva
//
//  Created by 上帝的宠儿 on 2020/7/14.
//  Copyright © 2020 ice. All rights reserved.
//

#import "SecondClassModel.h"

@interface SecondClassModel ()

@end

@implementation SecondClassModel

+ (SecondClassModel *)create:(NSString *)secondClassText{
    SecondClassModel *lm = [[self alloc]init];
    lm.secondClassText = secondClassText;
    return lm;
}

@end
