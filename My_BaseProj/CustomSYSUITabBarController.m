//
//  CustomSYSUITabBarController.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "CustomSYSUITabBarController.h"
#import "BaseNavigationVC.h"

#import "ViewController@1.h"
#import "ViewController@2.h"
#import "ViewController@3.h"
#import "ViewController@4.h"

static NSString * const sampleDescription1 = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
static NSString * const sampleDescription2 = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
static NSString * const sampleDescription3 = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
static NSString * const sampleDescription4 = @"Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit.";

@interface CustomSYSUITabBarController ()
<
LZBTabBarViewControllerDelegate,
EAIntroDelegate
>

@property(nonatomic,strong)NSMutableArray<UIImage *> *customUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray<UIImage *> *customSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray<NSString *> *titleStrMutArr;
@property(nonatomic,strong)NSMutableArray<UIViewController *> *viewControllerMutArr;
@property(nonatomic,strong)BaseNavigationVC *customNavigationVC;
@property(nonatomic,strong)NSMutableArray *mutArr;

@property(nonatomic,strong)EAIntroPage *page1;
@property(nonatomic,strong)EAIntroPage *page2;
@property(nonatomic,strong)EAIntroPage *page3;
@property(nonatomic,strong)EAIntroPage *page4;
@property(nonatomic,strong)EAIntroView *intro;

@end

CGFloat LZB_TABBAR_HEIGHT;

@implementation CustomSYSUITabBarController

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        LZB_TABBAR_HEIGHT = isiPhoneX_series()?80:49;
    }return self;
}

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setUpAllChildViewController];
//    self.intro.alpha = 1;
}

- (void)p_setUpAllChildViewController {
    self.viewControllerMutArr = [NSMutableArray arrayWithObjects:ViewController_1.new,ViewController_2.new,ViewController_3.new,ViewController_4.new,nil];
    self.delegate = self;
    for (int i = 0; i < self.viewControllerMutArr.count; i ++) {
        self.customNavigationVC = [[BaseNavigationVC alloc]initWithRootViewController:(UIViewController *)self.viewControllerMutArr[i]];
        [self.mutArr addObject:self.customNavigationVC];
    }
    self.viewControllers = (NSArray *)self.mutArr;
    for (int i = 0; i <self.titleStrMutArr.count; i++) {
        [self p_setupCustomTBCWithViewController:self.viewControllerMutArr[i]
                                           Title:self.titleStrMutArr[i]
                                     SelectImage:(UIImage *)self.customSelectedImgMutArr[i]
                                   NnSelectImage:(UIImage *)self.customUnselectedImgMutArr[i]];
    }
    self.lzb_tabBar.backgroundColor = kWhiteColor;
    self.isShouldAnimation = YES;
}

-(void)p_setupCustomTBCWithViewController:(UIViewController *)vc
                                  Title:(NSString *)titleStr
                            SelectImage:(UIImage *)selectImage
                          NnSelectImage:(UIImage *)unSelectImage{
    vc.lzb_tabBarItem.selectImage = selectImage;
    vc.lzb_tabBarItem.unSelectImage = unSelectImage;
    vc.lzb_tabBarItem.title = titleStr;//下
    vc.title = titleStr;//上
}
#pragma mark ======== LZBTabBarViewControllerDelegate ======
- (BOOL)lzb_tabBarController:(LZBTabBarViewController *)tabBarController
  shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}
//改1
//点击的时候进行确认是否登录
- (void)lzb_tabBarController:(LZBTabBarViewController *)tabBarController
     didSelectViewController:(UIViewController *)viewController{
    if ([viewController.childViewControllers.firstObject isKindOfClass:[ViewController_1 class]]) {
        //        NSLog(@"%ld",self.selectedIndex);
    }
    else if ([viewController.childViewControllers.firstObject isKindOfClass:[ViewController_2 class]]){
//        [self presentLoginVC];
    }
    else if ([viewController.childViewControllers.firstObject isKindOfClass:[ViewController_3 class]]){
//        [self presentLoginVC];
    }
    else if ([viewController.childViewControllers.firstObject isKindOfClass:[ViewController_4 class]]){
//        [self presentLoginVC];
    }
}
#pragma mark - EAIntroView delegate
- (void)introDidFinish:(EAIntroView *)introView
            wasSkipped:(BOOL)wasSkipped {
    if(wasSkipped) {
        NSLog(@"Intro skipped");
    } else {
        NSLog(@"Intro finished");
    }
}
#pragma mark —— lazyLoad
-(NSMutableArray *)mutArr{
    if (!_mutArr) {
        _mutArr = NSMutableArray.array;
    }return _mutArr;
}

-(NSMutableArray<NSString *> *)titleStrMutArr{
    if (!_titleStrMutArr) {
        _titleStrMutArr = NSMutableArray.array;
        [_titleStrMutArr addObject:@"CASINO"];
        [_titleStrMutArr addObject:@"POKER"];
        [_titleStrMutArr addObject:@"VIET LOTTO"];
        [_titleStrMutArr addObject:@"PROMOTION"];
    }return _titleStrMutArr;
}

-(NSMutableArray<UIImage *> *)customUnselectedImgMutArr{
    if (!_customUnselectedImgMutArr) {
        _customUnselectedImgMutArr = NSMutableArray.array;
        [_customUnselectedImgMutArr addObject:kIMG(@"Home")];
        [_customUnselectedImgMutArr addObject:kIMG(@"MyStore")];
        [_customUnselectedImgMutArr addObject:kIMG(@"ShoppingCart")];
        [_customUnselectedImgMutArr addObject:kIMG(@"My")];
    }return _customUnselectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)customSelectedImgMutArr{
    if (!_customSelectedImgMutArr) {
        _customSelectedImgMutArr = NSMutableArray.array;
        [_customSelectedImgMutArr addObject:kIMG(@"Home")];
        [_customSelectedImgMutArr addObject:kIMG(@"MyStore")];
        [_customSelectedImgMutArr addObject:kIMG(@"ShoppingCart")];
        [_customSelectedImgMutArr addObject:kIMG(@"My")];
    }return _customSelectedImgMutArr;
}

-(EAIntroPage *)page1{
    if (!_page1) {
        _page1 = EAIntroPage.page;
        _page1.title = @"Hello world";
        _page1.desc = sampleDescription1;
        _page1.bgImage = kIMG(@"bg1");
        _page1.titleIconView = [[UIImageView alloc] initWithImage:kIMG(@"title1")];
    }return _page1;
}

-(EAIntroPage *)page2{
    if (!_page2) {
        _page2 = EAIntroPage.page;
        _page2.title = @"This is page 2";
        _page2.desc = sampleDescription2;
        _page2.bgImage = kIMG(@"bg2");
        _page2.titleIconView = [[UIImageView alloc] initWithImage:kIMG(@"title2")];
    }return _page2;
}

-(EAIntroPage *)page3{
    if (!_page3) {
        _page3 = EAIntroPage.page;
        _page3.title = @"This is page 3";
        _page3.desc = sampleDescription3;
        _page3.bgImage = kIMG(@"bg3");
        _page3.titleIconView = [[UIImageView alloc] initWithImage:kIMG(@"title3")];
    }return _page3;
}

-(EAIntroPage *)page4{
    if (!_page4) {
        _page4 = EAIntroPage.page;
        _page4.title = @"This is page 4";
        _page4.desc = sampleDescription4;
        _page4.bgImage = kIMG(@"bg4");
        _page4.titleIconView = [[UIImageView alloc] initWithImage:kIMG(@"title4")];
    }return _page4;
}

-(EAIntroView *)intro{
    if (!_intro) {
        _intro = [[EAIntroView alloc] initWithFrame:[SceneDelegate sharedInstance].window.bounds
                                           andPages:@[self.page1,
                                                      self.page2,
                                                      self.page3,
                                                      self.page4]];//
        _intro.skipButtonAlignment = EAViewAlignmentCenter;
        _intro.skipButtonY = 80.f;
        _intro.pageControlY = 42.f;
        [_intro setDelegate:self];
        [_intro showInView:[SceneDelegate sharedInstance].window
           animateDuration:0.3f];
    }return _intro;
}


@end
