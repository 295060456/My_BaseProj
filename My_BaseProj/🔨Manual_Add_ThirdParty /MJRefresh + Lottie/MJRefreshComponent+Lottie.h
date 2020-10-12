//
//  MJRefreshComponent+Lottie.h
//  My_BaseProj
//
//  Created by Jobs on 2020/10/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MJRefresh.h"
#import "MJRefreshComponent.h"
#import <Lottie/Lottie.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshComponent (Lottie)

@property(nonatomic,strong)LOTAnimationView *loadingView;
@property(nonatomic,strong)NSString *jsonString;

@end

NS_ASSUME_NONNULL_END
