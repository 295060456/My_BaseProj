//
//  TestHeader.m
//  lottieDemo
//
//  Created by Lindashuai on 2020/1/19.
//  Copyright © 2020 Lindashuai. All rights reserved.
//

#import "TestTableViewHeader.h"
#import "MJRefreshComponent+Lottie.h"

@interface TestTableViewHeader ()

@property(nonatomic,copy)MKDataBlock testTableViewHeaderBlock;

@end

@implementation TestTableViewHeader

-(instancetype)init{
    if (self = [super init]){
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
    }return self;
}

-(void)endRefresh{
    [self endRefreshing];
}

-(void)beginRefreshing{
    [super beginRefreshing];
    @weakify(self)
    [self setRefreshingBlock:^{
        @strongify(self)
        [NSObject feedbackGenerator];
        if (self.testTableViewHeaderBlock) {
            self.testTableViewHeaderBlock(self);
        }
        [self endRefreshing];
    }];
}

-(void)endRefreshing{
    //模拟耗时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(1.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   ^{
        [super endRefreshing];
    });
}

-(void)actionBlockTestTableViewHeader:(MKDataBlock)testTableViewHeaderBlock{
    _testTableViewHeaderBlock = testTableViewHeaderBlock;
}
#pragma mark - 实时监听控件 scrollViewContentOffset
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    if(self.jsonString.length > 0) {
        CGPoint point;
        id newVelue = [change valueForKey:NSKeyValueChangeNewKey];
        [(NSValue *)newVelue getValue:&point];

        //id newVelue1 = [change objectForKey:NSKeyValueChangeNewKey];
        //CGPoint point1 = ((NSValue *)newVelue1).CGPointValue;//可以取值

        //id newVelue2 = [change objectForKey:@"new"];
        //CGPoint point2 = *((__bridge CGPoint *)(newVelue2));//无法取到值

        self.loadingView.hidden = !(self.pullingPercent);
        CGFloat progress = point.y / ([UIScreen mainScreen].bounds.size.height / 3.0);
        if(self.state != MJRefreshStateRefreshing) {
            self.loadingView.animationProgress = -progress;
        }
    }
}

@end
