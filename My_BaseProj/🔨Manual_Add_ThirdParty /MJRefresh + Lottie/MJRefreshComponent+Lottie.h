//
//  MJRefreshComponent+Lottie.h
//  My_BaseProj
//
//  Created by Jobs on 2020/10/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MJRefresh.h"
#import "MJRefreshComponent.h"

#if __has_include(<lottie-ios/Lottie.h>)
#import <lottie-ios/Lottie.h>
#else
#import "Lottie.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshComponent (Lottie)

@property(nonatomic,strong)LOTAnimationView *loadingView;
@property(nonatomic,strong)NSString *jsonString;

@end

NS_ASSUME_NONNULL_END
