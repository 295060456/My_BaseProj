//
//  HighModel.h
//  eva
//
//  Created by 上帝的宠儿 on 2020/7/14.
//  Copyright © 2020 ice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecondClassModel.h"

///子标题一开始最多加载的个数
#define preMax 3
///加载更多数据 一次加载的个数
#define LoadDataNum 1

@interface FirstClassModel : NSObject

@property(nonatomic,strong)NSString *firstClassText;
@property(nonatomic,strong)NSMutableArray <SecondClassModel *>*secClsModelMutArr;

#pragma mask --- define
@property(nonatomic,assign)BOOL _hasMore;
@property(nonatomic,assign)BOOL isFullShow;
///当前二级数据实际个数
@property(nonatomic,assign)int rand;
///当前二级数据显示个数
@property(nonatomic,assign)int randShow;
///显示控制，二级数据默认最多显示多少个
@property(nonatomic,assign)int PreMax;

+ (FirstClassModel *)create:(NSString *)firstClassText;

@end

