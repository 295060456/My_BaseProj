//
//  HighModel.m
//  eva
//
//  Created by 上帝的宠儿 on 2020/7/14.
//  Copyright © 2020 ice. All rights reserved.
//

#import "FirstClassModel.h"

@interface FirstClassModel ()

@end

@implementation FirstClassModel
+ (FirstClassModel *)create:(NSString *)firstClassText{
    FirstClassModel *fcm = [[self alloc]init];
    fcm.firstClassText = firstClassText;
//    arc4random()是一个真正的伪随机算法，不需要随机数种子。
//    产生一个[0,100)的数字
//    NSInteger rand = arc4random() % 5 + 1;
    
//    if (firstClassText.intValue % 2) {
//        fcm.rand = preMax + 1 + 5;//9
//    }else{
//        fcm.rand = preMax;//3
//    }
    fcm.randShow = preMax;
    fcm.rand = preMax + 1 + 5;//6
    fcm.PreMax = preMax;
    
    for(NSInteger idx = 1; idx <= fcm.rand; idx ++){
        if (idx != 0) {
            NSString *show = [NSString stringWithFormat:@"%@----%ld", firstClassText, idx];
            SecondClassModel *lm = [SecondClassModel create:show];
            [fcm.secClsModelMutArr addObject:lm];
        }
    }
    fcm._hasMore = fcm.secClsModelMutArr.count > preMax;
    return fcm;
}

@synthesize secClsModelMutArr = _secClsModelMutArr;
-(void)setSecClsModelMutArr:(NSMutableArray<SecondClassModel *> *)secClsModelMutArr{
    if(![secClsModelMutArr isKindOfClass:NSArray.class]){
        _secClsModelMutArr = nil;
    }else{
        for(NSDictionary *d in secClsModelMutArr){
            if(![d isKindOfClass:NSDictionary.class]){continue;}
            SecondClassModel *lm = SecondClassModel.new;
            [lm setValuesForKeysWithDictionary:d];
            [self.secClsModelMutArr addObject:lm];
        }
    }
}
#pragma mark —— lazyLoad
- (NSMutableArray <SecondClassModel *>*)secClsModelMutArr{
    if(!_secClsModelMutArr){
        _secClsModelMutArr = NSMutableArray.array;
    }return _secClsModelMutArr;
}

@end
