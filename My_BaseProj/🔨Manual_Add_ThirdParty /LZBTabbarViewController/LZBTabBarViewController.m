//
//  LZBTabBarViewController.m
//  LZBTabbarViewController
//
//  Created by zibin on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBTabBarViewController.h"
#import <objc/runtime.h>

#define LZB_TABBAR_DEFULT_HEIGHT 49

@interface LZBTabBarViewController ()
<LZBTabBarDelegate>

@property(nonatomic,strong)UIViewController *selectedViewController;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)LZBTabBar *tabbar;

@end

@implementation LZBTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.tabbar];
    self.isShouldAnimation = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setSelectedIndex:self.selectedIndex];
    [self setLzb_tabBarHidden:self.lzb_tabBarHidden
                     animated:NO];
}

#pragma mark- API
- (void)setViewControllers:(NSArray <UIViewController *> *)viewControllers{
    if(viewControllers.count == 0) return;
    //移除之前的
    for (UIViewController *viewController in _viewControllers){
        //注意：在removeFromParentViewController必须先调用willMoveToParentViewController
        [viewController willMoveToParentViewController:nil];
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    }
    
    _viewControllers = viewControllers;
    NSMutableArray *tabBarItems = [NSMutableArray array];
    for (UIViewController *viewController in viewControllers) {
        LZBTabBarItem *tabBarItem = [[LZBTabBarItem alloc] init];
         [tabBarItems addObject:tabBarItem];
         [tabBarItem setTitle:viewController.title];
         viewController.lzb_tabBarController = self;
    }
    [self.tabbar setItems:tabBarItems];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [self setSelectedIndex:selectedIndex
                 animation:self.isShouldAnimation];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
               animation:(BOOL)animation{
    if(selectedIndex >= self.viewControllers.count) return;
    if(self.selectedViewController){
        [self.selectedViewController willMoveToParentViewController:nil];
        [self.selectedViewController.view removeFromSuperview];
        [self.selectedViewController removeFromParentViewController];
    }
    _selectedIndex = selectedIndex;
    self.isShouldAnimation = animation;
    LZBTabBarItem *selectItem = [self.tabbar.items objectAtIndex:selectedIndex];
    [self.tabbar setCurrentSelectItem:selectItem
                            animation:self.isShouldAnimation];
    self.selectedViewController = [self.viewControllers objectAtIndex:selectedIndex];
    [self addChildViewController:self.selectedViewController];
    self.selectedViewController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.selectedViewController.view];
    [self.selectedViewController didMoveToParentViewController:self];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController
                        animation:(BOOL)animation{
    if(![self.viewControllers containsObject:selectedViewController]) return;
    NSInteger index = [self.viewControllers indexOfObject:selectedViewController];
    self.isShouldAnimation = animation;
    [self setSelectedIndex:index
                 animation:self.isShouldAnimation];
}

- (NSInteger)indexForTabBarViewControllerViewControllers:(UIViewController *)viewController{
  if(viewController.navigationController)
      viewController = viewController.navigationController;
    return [self.viewControllers indexOfObject:viewController];
}

-(UIViewController *)lzb_selectedViewController{
    return self.selectedViewController;
}

- (void)setLzb_tabBarHidden:(BOOL)lzb_tabBarHidden
                   animated:(BOOL)animation{
    _lzb_tabBarHidden = lzb_tabBarHidden;
    //定义Block处理隐藏的lzb_tabBarHidden
    __weak LZBTabBarViewController *weakSelf = self;
    void(^blcokHidden)(void) = ^{
        CGSize fullSize = weakSelf.view.bounds.size;
        CGFloat tabBarStartingY = fullSize.height;
        CGFloat contentViewHeight = fullSize.height;
        CGFloat tabBarHeight = CGRectGetHeight(weakSelf.lzb_tabBar.frame);
        if(!lzb_tabBarHidden){//显示
            tabBarStartingY = fullSize.height - tabBarHeight;
            weakSelf.lzb_tabBar.frame = CGRectMake(0,
                                                   tabBarStartingY,
                                                   fullSize.width,
                                                   tabBarHeight);
            weakSelf.lzb_tabBar.hidden = NO;
        }else{
            //不显示
            weakSelf.lzb_tabBar.frame = CGRectMake(0,
                                                   tabBarStartingY,
                                                   fullSize.width,
                                                   tabBarHeight);
        }
        weakSelf.contentView.frame = CGRectMake(0,
                                                0,
                                                fullSize.width,
                                                contentViewHeight);
    };
    //动画完成
    void(^compeletion)(BOOL) = ^(BOOL finish){
        weakSelf.lzb_tabBar.hidden = finish;
    };
    //动画
    if(animation){
        [UIView animateWithDuration:0.25
                         animations:^{
            if(blcokHidden)
                blcokHidden();
        } completion:^(BOOL finished) {
             if(compeletion && finished)
                compeletion(lzb_tabBarHidden);
        }];
    }else{
        if(blcokHidden)
            blcokHidden();
        if(compeletion)
            compeletion(lzb_tabBarHidden);
    }
}

- (void)setLzb_tabBarHidden:(BOOL)lzb_tabBarHidden{
    [self setLzb_tabBarHidden:lzb_tabBarHidden
                     animated:NO];
}
#pragma mark- tabbarDelegate
- (BOOL)lzb_tabBar:(LZBTabBar *)tabBar
shouldSelectItemAtIndex:(NSInteger)index{
    if (index < 0 ||
        index >= self.viewControllers.count) return NO;
    if([self.delegate respondsToSelector:@selector(lzb_tabBarController:shouldSelectViewController:)]){
        if(![self.delegate lzb_tabBarController:self
                     shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
            return NO;
    }
    if(self.selectedViewController == [self.viewControllers objectAtIndex:index]){
        if([self.selectedViewController isKindOfClass:[UINavigationController class]]){
            UINavigationController *selectViewControler = (UINavigationController *)self.selectedViewController;
            //如果不是顶层控制器，就回到顶层
            if(selectViewControler.topViewController != [selectViewControler.viewControllers objectAtIndex:0]){
                [selectViewControler popToRootViewControllerAnimated:YES];
            }
        }return NO;
    }return YES;
}

- (void)lzb_tabBar:(LZBTabBar *)tabBar
didSelectItemAtIndex:(NSInteger)index{
    //播放声音
//    [PlaySound playSoundEffect:@"Sound"
//                          type:@"wav"];
    //震动特效反馈
    [self feedbackGenerator];
    if (index < 0 || index >= self.viewControllers.count)  return;
    [self setSelectedIndex:index
                 animation:self.isShouldAnimation];
    if([self.delegate respondsToSelector:@selector(lzb_tabBarController:didSelectViewController:)]){
        [self.delegate lzb_tabBarController:self
                    didSelectViewController:[self.viewControllers objectAtIndex:index]];
    }
}

#pragma mark —— LazyLoad
- (UIView *)contentView{
  if(_contentView == nil){
      _contentView = [UIView new];
//      _contentView.backgroundColor = [UIColor greenColor];
      _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|
      UIViewAutoresizingFlexibleHeight;
      _contentView.frame = [UIScreen mainScreen].bounds;
  }return _contentView;
}

- (LZBTabBar *)tabbar{
   if(_tabbar == nil){
       _tabbar = LZBTabBar.new;
       _tabbar.tabBarStyleType = LZBTabBarStyleType_middleItemUp;
       _tabbar.autoresizingMask = UIViewAutoresizingFlexibleWidth|
                                  UIViewAutoresizingFlexibleTopMargin|
                                  UIViewAutoresizingFlexibleLeftMargin|
                                  UIViewAutoresizingFlexibleRightMargin|
                                  UIViewAutoresizingFlexibleBottomMargin;
       extern CGFloat LZB_TABBAR_HEIGHT;
       _tabbar.frame = CGRectMake(0,
                                  self.contentView.frame.size.height - LZB_TABBAR_HEIGHT,
                                  [UIScreen mainScreen].bounds.size.width,
                                  LZB_TABBAR_HEIGHT);
       _tabbar.delegate = self;
   }return _tabbar;
}

- (LZBTabBar *)lzb_tabBar{
    return self.tabbar;
}

@end

static const void *LZBTabBarViewControllerItemKey = @"LZBTabBarViewControllerItemKey";

@implementation UIViewController (LZBTabBarViewControllerItem)
- (void)setLzb_tabBarController:(LZBTabBarViewController *)lzb_tabBarController{
   objc_setAssociatedObject(self,
                            LZBTabBarViewControllerItemKey,
                            lzb_tabBarController,
                            OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LZBTabBarViewController *)lzb_tabBarController{
    LZBTabBarViewController *tabBarViewController = objc_getAssociatedObject(self, LZBTabBarViewControllerItemKey);
    if(!tabBarViewController &&
       self.parentViewController)
        tabBarViewController = self.parentViewController.lzb_tabBarController;
    return tabBarViewController;
}

- (void)setLzb_tabBarItem:(LZBTabBarItem *)lzb_tabBarItem{
    LZBTabBarViewController *tabBarViewController = self.lzb_tabBarController;
    if(tabBarViewController == nil) return;
    LZBTabBar *tabBar = tabBarViewController.tabbar;
    //当前这个控制器在tabbar的索引
    NSInteger index = [tabBarViewController indexForTabBarViewControllerViewControllers:self];
    if(index<0 ||
       index >= tabBarViewController.tabbar.items.count) return;
    //替换
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] initWithArray:[tabBar items]];
    [tabBarItems replaceObjectAtIndex:index
                           withObject:lzb_tabBarItem];
    [tabBar setItems:tabBarItems];
}

- (LZBTabBarItem *)lzb_tabBarItem{
    LZBTabBarViewController *tabBarController = [self lzb_tabBarController];
    NSInteger index = [tabBarController indexForTabBarViewControllerViewControllers:self];
    if(index<0 ||
       index >= tabBarController.tabbar.items.count) return nil;
    return [tabBarController.tabbar.items objectAtIndex:index];
}


@end
