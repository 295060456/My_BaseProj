//
//  FSReplyController.m
//  JRTTDialog
//
//  Created by 付森 on 2020/4/10.
//  Copyright © 2020 付森. All rights reserved.
//

#import "FSReplyController.h"
#import "FSContainer.h"

@interface FSReplyController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIView *topView;

@property (nonatomic, weak) UIView *bottomView;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) CGFloat originY;

@end

@implementation FSReplyController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc] init];

    self.topView = topView;

    topView.backgroundColor = [UIColor redColor];

    [self.view addSubview:topView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(topViewPan:)];
    
    [self.view addGestureRecognizer:pan];
    
    // 表格
    UITableView *tableView = [[UITableView alloc] init];
    
    self.tableView = tableView;
    
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    UIView *bottomView = [[UIView alloc] init];
    
    self.bottomView = bottomView;
    
    bottomView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:bottomView];
    
    [tableView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat width = self.view.bounds.size.width;
    
    self.topView.frame = CGRectMake(0, 0, width, 50);
    
    self.tableView.frame = CGRectMake(0, 50, width, self.view.bounds.size.height - 100);
    
    CGFloat bottomY = self.view.bounds.size.height - 50;
    
    self.bottomView.frame = CGRectMake(0, bottomY, width, 50);
    
    CAShapeLayer *mask = self.view.layer.mask;
    
    if (mask == nil) {
        
        mask = [[CAShapeLayer alloc] init];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
        
        mask.path = path.CGPath;
        
        self.view.layer.mask = mask;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"FS - %tu", indexPath.row];
    
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString * const headerId = @"header";
//
//    UIView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
//
//    if (header == nil) {
//
//        header = [[UIView alloc] init];
//
//        header.backgroundColor = [UIColor blueColor];
//    }
//
//    return header;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%s",__func__);
    
//    CGFloat panTranslationY = [scrollView.panGestureRecognizer translationInView:scrollView.panGestureRecognizer.view].y;
//
//    NSLog(@"%lf", panTranslationY);
    
    // 下拉 < 0， 上拉 > 0
//    NSLog(@"contentOffset: %@", NSStringFromCGPoint(scrollView.contentOffset));
    
//    return;
    
//    if (scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
//
//        NSLog(@"UIGestureRecognizerStateEnded - scrollViewDidScroll");
//    }
    
//    NSLog(@"state = %tu", scrollView.panGestureRecognizer.state);
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 下拉
    if (offsetY < 0) {

        [scrollView setContentOffset:CGPointZero];

        [self panGesture:scrollView.panGestureRecognizer];
    }
    // 上拉
    else if (offsetY > 0)
    {
        CGFloat transformTY = self.view.transform.ty;

//        NSLog(@"transformTY:%lf", transformTY);

        if (transformTY > 0) {

            [scrollView setContentOffset:CGPointZero];

            [self panGesture:scrollView.panGestureRecognizer];
        }
        else if (transformTY == 0)
        {
//            NSLog(@"transformTY == 0");
        }
        else
        {
//            NSLog(@"transformTY:%lf", transformTY);
        }
    }
    
}

static CGFloat beginDraggingOffsetY = 0;

// 开始拖动时的回调
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"%s", __func__);
    
    beginDraggingOffsetY = scrollView.contentOffset.y;
    
//    NSLog(@"beginDraggingOffsetY: %lf", beginDraggingOffsetY);
}

//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    NSLog(@"%s", __func__);
//}

/*
 一、向下拉：
 1、从tableview.contentOffset.y == 0时开始下拉
 2、从tableview.contentOffset.y > 0时开始下拉
 */

- (void)panGesture:(UIPanGestureRecognizer *)pan
{
    // 手势位移
    CGFloat panTranslationY = [pan translationInView:pan.view].y;
    
    /// 下拉 offset > 0， 上拉 offset < 0
//    NSLog(@"panTranslationY:%lf", panTranslationY);
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
//        NSLog(@"tableViewOffsetY = %lf", self.tableView.contentOffset.y);
        
        // 下拉
        if (panTranslationY > 0) {

            CGFloat tableViewOffsetY = self.tableView.contentOffset.y;

            if (tableViewOffsetY == 0) {
                
                CGFloat detalY = panTranslationY - beginDraggingOffsetY;
                
//                NSLog(@"detalY:%lf", detalY);
                detalY = detalY < 0 ? 0 : detalY;
                
                self.view.transform = CGAffineTransformMakeTranslation(0, detalY);
            }
        }
        else if (panTranslationY < 0)
        {
            self.view.transform = CGAffineTransformIdentity;
            
//            NSLog(@"来---");
        }
        else
        {
//            NSLog(@"panTranslationY < 0");
            
            self.view.transform = CGAffineTransformIdentity;
        }
        
    }
    else if (pan.state == UIGestureRecognizerStateEnded)
    {
//        NSLog(@"UIGestureRecognizerStateEnded");
    }
}

- (void)setupContainViewAlpha:(CGFloat)alpha
{
    self.presentationController.containerView.alpha = alpha;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([object isEqual:self.tableView.panGestureRecognizer] && [keyPath isEqualToString:@"state"]) {
        
        id newValue = [change objectForKey:NSKeyValueChangeNewKey];
        
        if ([newValue integerValue] == UIGestureRecognizerStateEnded) {
            
            [self panEnd];
        }
    }
}

- (void)panEnd
{
    if (self.view.transform.ty < self.view.bounds.size.height * 0.4) {
        
        [UIView animateWithDuration:0.25 animations:^{
           self.view.transform = CGAffineTransformIdentity;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.view.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
            
            self.presentationController.containerView.alpha = 0.05;
            
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:NULL];
        }];
    }
}

- (void)topViewPan:(UIPanGestureRecognizer *)pan
{
    CGFloat panTranslationY = [pan translationInView:pan.view].y;
    
//    NSLog(@"panTranslationY = %lf", panTranslationY);
    
    if (panTranslationY < 0) {
        panTranslationY = 0;
    }
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        self.view.transform = CGAffineTransformMakeTranslation(0, panTranslationY);
    }
    else if (pan.state == UIGestureRecognizerStateEnded)
    {
        [self panEnd];
    }
}

- (void)dealloc
{
    [self.tableView.panGestureRecognizer removeObserver:self forKeyPath:@"state"];
}

@end
