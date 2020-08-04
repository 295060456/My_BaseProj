//
//  BaseVC+MJRefresh.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+MJRefresh.h"
#import <objc/runtime.h>

@implementation BaseVC (MJRefresh)

static char *BaseVC_MJRefresh_tableViewHeader;
static char *BaseVC_MJRefresh_tableViewFooter;
static char *BaseVC_MJRefresh_refreshBackNormalFooter;

@dynamic tableViewHeader;
@dynamic tableViewFooter;
@dynamic refreshBackNormalFooter;

///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
}
///上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
}
#pragma mark —— lazyLoad
-(MJRefreshGifHeader *)tableViewHeader{
    MJRefreshGifHeader *TableViewHeader = objc_getAssociatedObject(self, BaseVC_MJRefresh_tableViewHeader);
    if (!TableViewHeader) {
        TableViewHeader =  [MJRefreshGifHeader headerWithRefreshingTarget:self
                                                          refreshingAction:@selector(pullToRefresh)];
        // 设置普通状态的动画图片
        [TableViewHeader setImages:@[kIMG(@"官方")]
                          forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [TableViewHeader setImages:@[kIMG(@"Indeterminate Spinner - Small")]
                          forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
//        [_tableViewHeader setImages:@[kIMG(@"gif_header_1"),
//                                      kIMG(@"gif_header_2"),
//                                      kIMG(@"gif_header_3"),
//                                      kIMG(@"gif_header_4")]
//                           duration:0.4
//                           forState:MJRefreshStateRefreshing];
        NSMutableArray *dataMutArr = NSMutableArray.array;
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            [dataMutArr addObject:kIMG(str)];
        }

        [TableViewHeader setImages:dataMutArr
                           duration:0.7
                           forState:MJRefreshStateRefreshing];
        
        // 设置文字
        [TableViewHeader setTitle:@"Click or drag down to refresh"
                          forState:MJRefreshStateIdle];
        [TableViewHeader setTitle:@"Loading more ..."
                          forState:MJRefreshStateRefreshing];
        [TableViewHeader setTitle:@"No more data"
                          forState:MJRefreshStateNoMoreData];

        // 设置字体
        TableViewHeader.stateLabel.font = [UIFont systemFontOfSize:17];
        // 设置颜色
        TableViewHeader.stateLabel.textColor = KLightGrayColor;
        //震动特效反馈
        [TableViewHeader addObserver:self
                           forKeyPath:@"state"
                              options:NSKeyValueObservingOptionNew
                              context:nil];
        objc_setAssociatedObject(self,
                                 BaseVC_MJRefresh_tableViewHeader,
                                 TableViewHeader,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TableViewHeader;
}

-(MJRefreshAutoGifFooter *)tableViewFooter{
    MJRefreshAutoGifFooter *TableViewFooter = objc_getAssociatedObject(self, BaseVC_MJRefresh_tableViewFooter);
    if (!TableViewFooter) {
        TableViewFooter = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadMoreRefresh)];
        // 设置普通状态的动画图片
        [TableViewFooter setImages:@[kIMG(@"官方")]
                           forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [TableViewFooter setImages:@[kIMG(@"Indeterminate Spinner - Small")]
                           forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
//        [_tableViewFooter setImages:@[kIMG(@"gif_header_1"),
//                                      kIMG(@"gif_header_2"),
//                                      kIMG(@"gif_header_3"),
//                                      kIMG(@"gif_header_4")]
//                           duration:0.4
//                           forState:MJRefreshStateRefreshing];
        
        NSMutableArray *dataMutArr = NSMutableArray.array;
        for (int i = 1; i <= 55; i++) {
            NSString *str = [NSString stringWithFormat:@"gif_header_%d",i];
            [dataMutArr addObject:kIMG(str)];
        }

        [TableViewFooter setImages:dataMutArr
                           duration:0.4
                           forState:MJRefreshStateRefreshing];
        // 设置文字
        [TableViewFooter setTitle:@"Click or drag up to refresh"
                          forState:MJRefreshStateIdle];
        [TableViewFooter setTitle:@"Loading more ..."
                          forState:MJRefreshStateRefreshing];
        [TableViewFooter setTitle:@"No more data"
                          forState:MJRefreshStateNoMoreData];
        // 设置字体
        TableViewFooter.stateLabel.font = [UIFont systemFontOfSize:17];
        // 设置颜色
        TableViewFooter.stateLabel.textColor = KLightGrayColor;
        //震动特效反馈
        [TableViewFooter addObserver:self
                           forKeyPath:@"state"
                              options:NSKeyValueObservingOptionNew
                              context:nil];
        TableViewFooter.hidden = YES;
        objc_setAssociatedObject(self,
                                 BaseVC_MJRefresh_tableViewFooter,
                                 TableViewFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TableViewFooter;
}

-(MJRefreshBackNormalFooter *)refreshBackNormalFooter{
    MJRefreshBackNormalFooter *RefreshBackNormalFooter = objc_getAssociatedObject(self, BaseVC_MJRefresh_refreshBackNormalFooter);
    if (!RefreshBackNormalFooter) {
        RefreshBackNormalFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                                       refreshingAction:@selector(loadMoreRefresh)];
        objc_setAssociatedObject(self,
                                 BaseVC_MJRefresh_refreshBackNormalFooter,
                                 RefreshBackNormalFooter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return RefreshBackNormalFooter;
}


@end
