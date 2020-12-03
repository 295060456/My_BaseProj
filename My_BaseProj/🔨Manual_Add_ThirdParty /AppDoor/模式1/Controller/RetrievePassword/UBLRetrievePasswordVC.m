//
//  UBLRetrievePasswordVC.m
//  UBLLive
//
//  Created by Jobs on 2020/11/25.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "UBLRetrievePasswordVC.h"

static const NSInteger DefaultShow = 1;//默认显示第几号

@interface UBLRetrievePasswordVC ()
<
JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate
>

@property(nonatomic,strong)UBLScheduleView *scheduleView;
@property(nonatomic,strong)JXCategoryTitleView *categoryTitleView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryIndicatorBackgroundView *backgroundView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)UIImageView *selectedBgimgV;

@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*titlesMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*imageNamesMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*selectedImageNamesMutArr;

@end

@implementation UBLRetrievePasswordVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    PrintRetainCount(self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    self.scheduleView.alpha = 1;
    self.categoryTitleView.alpha = 1;
    self.selectedBgimgV.alpha = 1;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark - JXCategoryViewDelegate
-(void)categoryView:(JXCategoryBaseView *)categoryView
didSelectedItemAtIndex:(NSInteger)index {//终值
    [self.listContainerView didClickSelectedItemAtIndex:index];
}
#pragma mark - JXCategoryListContainerViewDelegate
-(id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                         initListForIndex:(NSInteger)index{
    return self.childVCsMutArr[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titlesMutArr.count;
}
#pragma mark —— lazyLoad
-(JXCategoryTitleView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryTitleView.new;
        _categoryTitleView.backgroundColor = kClearColor;
        _categoryTitleView.titleSelectedColor = RGBCOLOR(72, 149,255);
        _categoryTitleView.titleColor = RGBCOLOR(165, 165, 165);
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        _categoryTitleView.titleSelectedFont = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        _categoryTitleView.delegate = self;
        _categoryTitleView.titles = self.titlesMutArr;
        _categoryTitleView.titleColorGradientEnabled = YES;
        _categoryTitleView.indicators = @[self.lineView];
        _categoryTitleView.contentEdgeInsetLeft = 130;
        _categoryTitleView.contentEdgeInsetRight = 130;
        _categoryTitleView.cellWidth = 40;
        _categoryTitleView.defaultSelectedIndex = DefaultShow;//默认从第二个开始显示
        //关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryTitleView.contentScrollView = self.listContainerView.scrollView;//
        _categoryTitleView.contentScrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_categoryTitleView];
        [_categoryTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scheduleView.mas_bottom).offset(10);
            make.height.mas_equalTo(categoryTitleViewHeight);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
        }];
    }return _categoryTitleView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView
                                                                      delegate:self];
        _listContainerView.defaultSelectedIndex = DefaultShow;//默认从第二个开始显示
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.scheduleView.mas_bottom).offset(10 + categoryTitleViewHeight);
        }];
    }return _listContainerView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = RGBCOLOR(105,
                                            144,
                                            239);
        _lineView.indicatorWidth = 30;
    }return _lineView;
}

-(JXCategoryIndicatorBackgroundView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = JXCategoryIndicatorBackgroundView.new;
        _backgroundView.indicatorHeight = 20;
        _backgroundView.indicatorCornerRadius = 0;
        _backgroundView.indicatorColor = kClearColor;
    }return _backgroundView;
}

-(UIImageView *)selectedBgimgV{
    if (!_selectedBgimgV) {
        _selectedBgimgV = UIImageView.new;
        _selectedBgimgV.image = KIMG(@"已选中背景");
        [self.backgroundView addSubview:_selectedBgimgV];
        [_selectedBgimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backgroundView).offset(-20);
            make.bottom.equalTo(self.backgroundView).offset(20);
            make.left.equalTo(self.backgroundView).offset(-20);
            make.right.equalTo(self.backgroundView).offset(20);
        }];
    }return _selectedBgimgV;
}

-(NSMutableArray<NSString *> *)imageNamesMutArr{
    if (!_imageNamesMutArr) {
        _imageNamesMutArr = NSMutableArray.array;
        [_imageNamesMutArr addObject:@"热门未点击"];
        [_imageNamesMutArr addObject:@"足球未点击"];
    }return _imageNamesMutArr;
}

-(NSMutableArray<NSString *> *)selectedImageNamesMutArr{
    if (!_selectedImageNamesMutArr) {
        _selectedImageNamesMutArr = NSMutableArray.array;
        [_selectedImageNamesMutArr addObject:@"热门已点击"];
        [_selectedImageNamesMutArr addObject:@"足球已点击"];
    }return _selectedImageNamesMutArr;
}

-(NSMutableArray<UIViewController *> *)childVCsMutArr{
    if (!_childVCsMutArr) {
        _childVCsMutArr = NSMutableArray.array;
        [_childVCsMutArr addObject:UBLMobilePhoneVerificationVC.new];
        [_childVCsMutArr addObject:UBLMailboxVerificationVC.new];
    }return _childVCsMutArr;
}

-(NSMutableArray<NSString *> *)titlesMutArr{
    if (!_titlesMutArr) {
        _titlesMutArr = NSMutableArray.array;
        [_titlesMutArr addObject:@"手机验证"];
        [_titlesMutArr addObject:@"邮箱验证"];
    }return _titlesMutArr;
}

-(UBLScheduleView *)scheduleView{
    if (!_scheduleView) {
        _scheduleView = UBLScheduleView.new;
        _scheduleView.schedule = 1;
        _scheduleView.backgroundColor = RGBCOLOR(255, 255, 255);
        [self.view addSubview:_scheduleView];
        [_scheduleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(10);
            make.height.mas_equalTo(147);
        }];
    }return _scheduleView;
}

@end
