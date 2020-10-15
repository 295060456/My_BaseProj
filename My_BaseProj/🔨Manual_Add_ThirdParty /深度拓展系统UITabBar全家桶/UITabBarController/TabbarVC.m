//
//  TabbarVC.m
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/29.
//  Copyright © 2017年 xa. All rights reserved.
//

#import "TabbarVC.h"
#import "TabbarVC+UIGestureRecognizerDelegate.h"
#import "ScrollTabBarDelegate.h"

TabbarVC *tabbarVC;

@interface TabbarVC ()
<
UITabBarControllerDelegate,
UIGestureRecognizerDelegate
>

@property(nonatomic,strong)UIPanGestureRecognizer *panGesture;
@property(nonatomic,assign)NSInteger subViewControllerCount;
@property(nonatomic,strong)ScrollTabBarDelegate *tabBarDelegate;

@property(nonatomic,strong)NSMutableArray <NSString *>*lottieImageMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*tabLottieMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*imagesMutArr;
@property(nonatomic,strong)NSMutableArray <UIView *>*UITabBarButtonMutArr;//UITabBarButton 是内部类 直接获取不到，需要间接获取

@end

@implementation TabbarVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init{
    if (self = [super init]) {
        self.delegate = self;
        tabbarVC = self;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}
                                             forState:UIControlStateSelected];
    
    [self scrollTabbar];//手势横向滚动子VC联动Tabbar切换
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self UISetting];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.myTabBar.height += self.myTabBar.offsetHeight;
    self.myTabBar.y = self.view.height - self.myTabBar.height;
    
    for (UITabBarItem *item in self.tabBar.items) {
        if ([item.title isEqualToString:@"首页"]) {
            [item pp_addBadgeWithText:@"99+"];
#pragma mark —— 动画
            [UIView animationAlert:item.badgeView];//图片从小放大
            shakerAnimation(item.badgeView, 2, 20);//重力弹跳动画效果
//            [UIView 视图上下一直来回跳动的动画:item.badgeView];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [UIView animationAlert:subView];//图片从小放大
            [self.UITabBarButtonMutArr addObject:subView];
        }
    }
    
    for (UIView *subView in self.UITabBarButtonMutArr) {
        /*
         * 长按手势是连续的。
         当在指定的时间段（minimumPressDuration）
         按下允许的手指的数量（numberOfTouchesRequired）
         并且触摸不超过允许的移动范围（allowableMovement）时，
         手势开始（UIGestureRecognizerStateBegan）。
         手指移动时，手势识别器转换到“更改”状态，
         并且当任何手指抬起时手势识别器结束（UIGestureRecognizerStateEnded）。
         *
         */
        
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                  action:@selector(LZBTabBarItemLongPress:)];
        longPressGR.delegate = self;

        longPressGR.numberOfTouchesRequired = 1;//手指数
        longPressGR.minimumPressDuration = 1;
    //        longPressGR.allowableMovement;

        [subView addGestureRecognizer:longPressGR];
    }
}
#pragma mark —— 一些私有方法
-(void)addLottieImage:(UIViewController *)vc
          lottieImage:(NSString *)lottieImage{
    vc.view.backgroundColor = [UIColor lightGrayColor];

    LOTAnimationView *lottieView = [LOTAnimationView animationNamed:lottieImage];
    lottieView.frame = [UIScreen mainScreen].bounds;
    lottieView.contentMode = UIViewContentModeScaleAspectFit;
    lottieView.loopAnimation = YES;
    lottieView.tag = 100;
    [vc.view addSubview:lottieView];
}

-(void)lottieImagePlay:(UIViewController *)vc{
    LOTAnimationView *lottieView = (LOTAnimationView *)[vc.view viewWithTag:100];
    if (!lottieView ||
        ![lottieView isKindOfClass:LOTAnimationView.class]) {
        return;
    }
    lottieView.animationProgress = 0;
    [lottieView play];
}

-(void)scrollTabbar{
    if (!self.isOpenScrollTabbar) {
        // 正确的给予 count
        self.subViewControllerCount = self.viewControllers ? self.viewControllers.count : 0;
        // 代理
        self.tabBarDelegate = [[ScrollTabBarDelegate alloc] init];
        self.delegate = self.tabBarDelegate;
        self.panGesture.enabled = !self.isOpenScrollTabbar;
    }
}
#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    [self lottieImagePlay:viewController];
    return YES;
}
//点击事件
- (void)tabBar:(UITabBar *)tabBar
 didSelectItem:(UITabBarItem *)item {
    if ([self.tabBar.items containsObject:item]) {
        NSInteger index = [self.tabBar.items indexOfObject:item];
        [self.tabBar animationLottieImage:(int)index];
        [NSObject playSoundWithFileName:@"Sound.wav"];
        [NSObject feedbackGenerator];
        shakerAnimation(item.badgeView, 2, 20);//重力弹跳动画效果
        [item pp_increase];

        UIView *UITabBarButton = self.UITabBarButtonMutArr[index];
        [UIView animationAlert:UITabBarButton];//图片从小放大
    }
}
#pragma mark —— 手势调用方法
-(void)panHandle:(UIPanGestureRecognizer *)panGesture{
    // 获取滑动点
    CGFloat translationX = [panGesture translationInView:self.view].x;
    CGFloat progress = fabs(translationX)/self.view.frame.size.width;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.tabBarDelegate.interactive = YES;
            CGFloat velocityX = [panGesture velocityInView:self.view].x;
            if (velocityX < 0) {
                if (self.selectedIndex < self.subViewControllerCount - 1) {
                    self.selectedIndex += 1;
                }
            }else {
                if (self.selectedIndex > 0) {
                    self.selectedIndex -= 1;
                }
            }
        }break;
        case UIGestureRecognizerStateChanged:{
            [self.tabBarDelegate.interactionController updateInteractiveTransition:progress];
        }break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:{
            if (progress > 0.3) {
                self.tabBarDelegate.interactionController.completionSpeed = 0.99;
                [self.tabBarDelegate.interactionController finishInteractiveTransition];
            }else{
                //转场取消后，UITabBarController 自动恢复了 selectedIndex 的值，不需要我们手动恢复。
                self.tabBarDelegate.interactionController.completionSpeed = 0.99;
                [self.tabBarDelegate.interactionController cancelInteractiveTransition];
            }
            self.tabBarDelegate.interactive = NO;
        }break;
        default:
            break;
    }
}

-(void)LZBTabBarItemLongPress:(UILongPressGestureRecognizer *)longPressGR{
    switch (longPressGR.state) {
        case UIGestureRecognizerStatePossible:{
            NSLog(@"没有触摸事件发生，所有手势识别的默认状态");
        }break;
        case UIGestureRecognizerStateBegan:{
            //长按手势
            NSInteger currentIndex = [self.UITabBarButtonMutArr indexOfObject:longPressGR.view];
            NSLog(@"一个手势已经开始 但尚未改变或者完成时，当前长按点击序号：%ld",currentIndex);//长按手势的锚点
            [NSObject feedbackGenerator];//震动反馈
            
//            [JobsPullListAutoSizeView initWithTargetView:longPressGR.view
//                                            imagesMutArr:nil
//                                             titleMutArr:[NSMutableArray arrayWithObjects:@"qqq",@"24r",nil]];
        }break;
        case UIGestureRecognizerStateChanged:{
            NSLog(@"手势状态改变");
        }break;
        case UIGestureRecognizerStateEnded:{// = UIGestureRecognizerStateRecognized
            NSLog(@"手势完成");
        }break;
        case UIGestureRecognizerStateCancelled:{
            NSLog(@"手势取消，恢复至Possible状态");
        }break;
        case UIGestureRecognizerStateFailed:{
            NSLog(@"手势失败，恢复至Possible状态");
        }break;
        default:
            break;
    }
}

-(void)UISetting{
    NSMutableArray *mArr = NSMutableArray.array;
    for (int i = 0 ; i < self.childMutArr.count; i++){

        NSString *imageSelected = [NSString stringWithFormat:@"%@_selected",self.imagesMutArr[i]];
        NSString *imageUnselected = [NSString stringWithFormat:@"%@_unselected",self.imagesMutArr[i]];
        
        UIViewController *vc = self.childMutArr[i];
        
        [self addLottieImage:vc
                 lottieImage:self.lottieImageMutArr[i]];

        [vc setTitle:self.titleMutArr[i]];
        vc.tabBarItem.image = [KIMG(imageUnselected) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [KIMG(imageSelected) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
#pragma mark —— 凸起部分判断逻辑和处理 —— 一般的图片
        for (NSNumber *b in self.humpIndex) {
            if (b.intValue == i) {
                [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(-self.myTabBar.humpOffsetY,
                                                               0,
                                                               -self.myTabBar.humpOffsetY / 2,
                                                               0)];//修改图片偏移量，上下，左右必须为相反数，否则图片会被压缩
                [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];//修改文字偏移量
            }
        }
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.title = self.titleMutArr[i];
        [mArr addObject:nav];
    }
    
    self.viewControllers = mArr;
    
#pragma mark —— 凸起部分判断逻辑和处理 —— Lottie 动画
    for (int d = 0; d < self.childMutArr.count; d++) {
        if (self.humpIndex.count) {
            for (NSNumber *b in self.humpIndex) {
                if (d == b.intValue) {
                    [self.tabBar addLottieImage:d
                                        offsetY:- self.myTabBar.humpOffsetY / 2
                                     lottieName:self.tabLottieMutArr[d]];
                }
            }
        }else{
            [self.tabBar addLottieImage:d
                                offsetY:0
                             lottieName:self.tabLottieMutArr[d]];
        }
    }
    
    //初始显示
    if (self.firstUI_selectedIndex < self.viewControllers.count) {
        self.selectedIndex = self.firstUI_selectedIndex;//初始显示哪个
        [self lottieImagePlay:self.childMutArr[self.firstUI_selectedIndex]];
        [self.tabBar animationLottieImage:self.firstUI_selectedIndex];
    }
}
#pragma mark —— lazyLoad
-(CustomTabBar *)myTabBar{
    if (!_myTabBar) {
        _myTabBar = [[CustomTabBar alloc] initWithBgImg:nil];
        [self setValue:_myTabBar
                forKey:@"tabBar"];//KVC 进行替换
        _myTabBar.frame = self.tabBar.bounds;
    }return _myTabBar;
}

-(UIPanGestureRecognizer *)panGesture{
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(panHandle:)];
        [self.view addGestureRecognizer:_panGesture];
    }return _panGesture;
}

-(NSMutableArray<NSString *> *)lottieImageMutArr{
    if (!_lottieImageMutArr) {
        _lottieImageMutArr = NSMutableArray.array;
        [_lottieImageMutArr addObject:@"home_priase_animation"];
        [_lottieImageMutArr addObject:@"music_animation"];
        [_lottieImageMutArr addObject:@"record_change"];
        
        [_lottieImageMutArr addObject:@"home_priase_animation"];
        [_lottieImageMutArr addObject:@"music_animation"];
        [_lottieImageMutArr addObject:@"record_change"];
        
        [_lottieImageMutArr addObject:@"home_priase_animation"];
        [_lottieImageMutArr addObject:@"music_animation"];
        [_lottieImageMutArr addObject:@"record_change"];
    }return _lottieImageMutArr;
}

-(NSMutableArray<NSString *> *)tabLottieMutArr{
    if (!_tabLottieMutArr) {
        _tabLottieMutArr = NSMutableArray.array;
        [_tabLottieMutArr addObject:@"tab_home_animate"];
        [_tabLottieMutArr addObject:@"tab_search_animate"];
        [_tabLottieMutArr addObject:@"tab_message_animate"];
        
        [_tabLottieMutArr addObject:@"tab_home_animate"];
        [_tabLottieMutArr addObject:@"tab_search_animate"];
        [_tabLottieMutArr addObject:@"tab_message_animate"];
        
        [_tabLottieMutArr addObject:@"tab_home_animate"];
        [_tabLottieMutArr addObject:@"tab_search_animate"];
        [_tabLottieMutArr addObject:@"tab_message_animate"];
    }return _tabLottieMutArr;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"首页"];
        [_titleMutArr addObject:@"精彩生活"];
        [_titleMutArr addObject:@"发现"];
        
        [_titleMutArr addObject:@"首页"];
        [_titleMutArr addObject:@"精彩生活"];
        [_titleMutArr addObject:@"发现"];
        
        [_titleMutArr addObject:@"首页"];
        [_titleMutArr addObject:@"精彩生活"];
        [_titleMutArr addObject:@"发现"];
    }return _titleMutArr;
}

-(NSMutableArray<NSString *> *)imagesMutArr{
    if (!_imagesMutArr) {
        _imagesMutArr = NSMutableArray.array;
        [_imagesMutArr addObject:@"community"];
        [_imagesMutArr addObject:@"post"];
        [_imagesMutArr addObject:@"My"];
        
        [_imagesMutArr addObject:@"community"];
        [_imagesMutArr addObject:@"post"];
        [_imagesMutArr addObject:@"My"];
        
        [_imagesMutArr addObject:@"community"];
        [_imagesMutArr addObject:@"post"];
        [_imagesMutArr addObject:@"My"];
    }return _imagesMutArr;
}

-(NSMutableArray<NSNumber *> *)humpIndex{
    if (!_humpIndex) {
        _humpIndex = NSMutableArray.array;
    }return _humpIndex;
}

-(NSMutableArray<UIView *> *)UITabBarButtonMutArr{
    if (!_UITabBarButtonMutArr) {
        _UITabBarButtonMutArr = NSMutableArray.array;
    }return _UITabBarButtonMutArr;
}

-(NSMutableArray<UIViewController *> *)childMutArr{
    if (!_childMutArr) {
        _childMutArr = NSMutableArray.array;
    }return _childMutArr;
}


@end
