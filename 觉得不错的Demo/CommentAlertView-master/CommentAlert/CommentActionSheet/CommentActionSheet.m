//
//  CommentActionSheet.m
//  CommentAlert
//
//  Created by 李立 on 2018/1/8.
//  Copyright © 2018年 李立. All rights reserved.
//

#import "CommentActionSheet.h"

static const CGFloat kMoveAnimationDuration = .25f;

@interface CommentActionSheet ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGRect originalFrame;     // 当前视图的原始位置
#pragma mark - UITouch 滑动
@property (assign, nonatomic) CGPoint startLocation;    // 记录滑动触摸的起始位置

@end

@implementation CommentActionSheet

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.originalFrame = frame;
        [self prepareUI];
    }
    
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self prepareUI];
    }
    
    return self;
}

- (void)prepareUI
{
    // 创建tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self addSubview:self.tableView];
    self.backgroundColor = [UIColor orangeColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark - 滑动动效

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取起始位置
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.superview];
    self.startLocation = location;
    NSLog(@"startLocation:x:%lg, y:%lg", location.x, location.y);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    // 当前触摸点
    CGPoint currentPoint = [touch locationInView:self.superview];
    NSLog(@"currentPoint:x:%lg, y:%lg", currentPoint.x, currentPoint.y);
    // 上一个触摸点
    CGPoint previousPoint = [touch previousLocationInView:self.superview];
    // 当前view的中点
    CGPoint center = self.center;
    // 设置y方向的偏移
    center.y += (currentPoint.y - previousPoint.y);
    // 修改当前view的中点(中点改变view的位置就会改变)
    self.center = center;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取终点位置
    UITouch *touch = [touches anyObject];
    CGPoint endLocation = [touch locationInView:self.superview];
    NSLog(@"endLocation:x:%lg, y:%lg", endLocation.x, endLocation.y);
    // 计算frame
    CGRect rect = self.originalFrame;
    rect.origin.y = self.superview.frame.size.height - self.originalFrame.size.height;
    CGFloat yOffset = endLocation.y - self.startLocation.y;
    BOOL flag = NO;
    // 判断是还原到原位置还是消失
    if (yOffset > self.originalFrame.size.height * 1.0f/3.0f)
    {
        // 消失
        rect.origin.y = self.superview.bounds.size.height;
        flag = YES;
    }
    
    // 执行动画
    [UIView animateWithDuration:kMoveAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        if (flag)
        {
//            [self remove];  // 删除自己
        }
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 如果遇到中断操作（来电...），就移除当前视图
    [self remove];
}


#pragma mark - 移除和呈现操作

- (void)remove
{
    [self removeFromSuperview];
}

@end










