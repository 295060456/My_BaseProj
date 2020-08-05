//
//  BaseVC+MJRefresh.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (MJRefresh)

#pragma mark —— BaseVC+MJRefresh
@property(nonatomic,strong)MJRefreshAutoGifFooter *tableViewFooter;
@property(nonatomic,strong)MJRefreshGifHeader *tableViewHeader;
@property(nonatomic,strong)MJRefreshBackNormalFooter *refreshBackNormalFooter;
///下拉刷新
-(void)pullToRefresh;
///上拉加载更多
- (void)loadMoreRefresh;

@end

NS_ASSUME_NONNULL_END
