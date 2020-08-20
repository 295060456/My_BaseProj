//
//  PhotoVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PhotoVC.h"
#import "MKUploadingVC.h"//上传
#import "MKShootVC.h"//拍摄

@interface PhotoVC ()
<
JXCategoryTitleViewDataSource
,JXCategoryListContainerViewDelegate
,JXCategoryViewDelegate
>

@property(nonatomic,strong)JXCategoryTitleView *categoryView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray *childVCMutArr;
@property(nonatomic,strong)MKUploadingVC *uploadingVC;
@property(nonatomic,strong)MKShootVC *shootVC;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation PhotoVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    PhotoVC *vc = PhotoVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

-(instancetype)init{
    if (self = [super init]) {
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    self.categoryView.alpha = 1;
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)sure{

}

-(void)Cancel{
    [self.categoryView selectItemAtIndex:1];
    [self.listContainerView didClickSelectedItemAtIndex:1];
}
#pragma mark JXCategoryTitleViewDataSource
//// 如果将JXCategoryTitleView嵌套进UITableView的cell，每次重用的时候，JXCategoryTitleView进行reloadData时，会重新计算所有的title宽度。所以该应用场景，需要UITableView的cellModel缓存titles的文字宽度，再通过该代理方法返回给JXCategoryTitleView。
//// 如果实现了该方法就以该方法返回的宽度为准，不触发内部默认的文字宽度计算。
//- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView
//               widthForTitle:(NSString *)title{
//
//    return 10;
//}
#pragma mark JXCategoryListContainerViewDelegate
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.titleMutArr.count;
}
/**
 根据index初始化一个对应列表实例，需要是遵从`JXCategoryListContentViewDelegate`协议的对象。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从JXCategoryListContentViewDelegate协议的list实例
 */
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                          initListForIndex:(NSInteger)index{
    return self.childVCMutArr[index];
}
#pragma mark JXCategoryViewDelegate
//传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
didClickSelectedItemAtIndex:(NSInteger)index {
//    if (index == 0) {
//        WeakSelf
//        if ([MKTools mkLoginIsYESWith:weakSelf]) {
//            NSLog(@"");
//            [self.listContainerView didClickSelectedItemAtIndex:index];
//        }else{
//            [self.listContainerView didClickSelectedItemAtIndex:1];
//        }
//    }else{
//        [self.listContainerView didClickSelectedItemAtIndex:index];
//    }
//
     [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView
didScrollSelectedItemAtIndex:(NSInteger)index{
    if (index) {//1
        [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
        self.gk_navigationBar.hidden = NO;
    }else{//0
        //重新拍摄
        switch (VedioTools.sharedInstance.vedioShootType) {
            case VedioShootType_on://开始录制
            case VedioShootType_suspend://暂停录制
            case VedioShootType_continue:{//继续录制
                [self alertControllerStyle:SYS_AlertController
                        showAlertViewTitle:@"丢弃掉当前拍摄的作品？"
                                   message:nil
                           isSeparateStyle:NO
                               btnTitleArr:@[@"确认",@"手滑了"]
                            alertBtnAction:@[@"sure",@"Cancel"]
                              alertVCBlock:^(id data) {
                    //DIY
                }];
            } break;
            default:
                break;
        }
        
        [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
        self.gk_navigationBar.hidden = YES;
    }
}

//传递scrolling事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
scrollingFromLeftIndex:(NSInteger)leftIndex
        toRightIndex:(NSInteger)rightIndex
               ratio:(CGFloat)ratio {
    NSLog(@"");
//    [self.listContainerView scrollingFromLeftIndex:leftIndex
//                                      toRightIndex:rightIndex
//                                             ratio:ratio
//                                     selectedIndex:categoryView.selectedIndex];
}
#pragma mark —— lazyLoad
-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"上传"];
        [_titleMutArr addObject:@"拍摄"];
    }return _titleMutArr;
}

-(NSMutableArray *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        [self.childVCMutArr addObject:self.uploadingVC];
        [self.childVCMutArr addObject:self.shootVC];
    }return _childVCMutArr;
}

-(MKUploadingVC *)uploadingVC{
    if (!_uploadingVC) {
        _uploadingVC = MKUploadingVC.new;
        @weakify(self)
        [_uploadingVC actionMKUploadingBlock:^(id data) {
            @strongify(self)
            [self.categoryView selectItemAtIndex:3];
            [self.listContainerView didClickSelectedItemAtIndex:3];
        }];
    }return _uploadingVC;
}

-(MKShootVC *)shootVC{
    if (!_shootVC) {
        _shootVC = MKShootVC.new;
        @weakify(self)
        [_shootVC ActionMKShootVCBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)data;
                if (num.boolValue) {//进来
                    [UIView animateWithDuration:0.25f
                                     animations:^{
                        [self.categoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.view);
                            make.right.equalTo(self.view.mas_centerX);
                            make.height.mas_equalTo(SCALING_RATIO(0));
                            make.top.equalTo(self.listContainerView).offset(rectOfStatusbar());
                        }];
                    } completion:^(BOOL finished) {
                        
                    }];
                }else{//出去
                    [UIView animateWithDuration:0.25f
                                     animations:^{
                        [self.categoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.view);
                            make.right.equalTo(self.view.mas_centerX);
                            make.height.mas_equalTo(SCALING_RATIO(50));
                            make.top.equalTo(self.listContainerView).offset(rectOfStatusbar());
                        }];
                    } completion:^(BOOL finished) {
                        
                    }];
                }
            }else if ([data isKindOfClass:NSString.class]){
                NSString *str = (NSString *)data;
                if ([str isEqualToString:@"exit"]) {
                    [self.categoryView selectItemAtIndex:0];
                    [self.listContainerView didClickSelectedItemAtIndex:0];
                }
            }
        }];
    }return _shootVC;
}

-(JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView
                                                                      delegate:self];
        _listContainerView.defaultSelectedIndex = 1;//默认从第二个开始显示
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
    }return _listContainerView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = kWhiteColor;
        _lineView.indicatorHeight = 4;
        _lineView.indicatorWidthIncrement = 10;
        _lineView.verticalMargin = 0;
    }return _lineView;
}

-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = JXCategoryTitleView.new;
        _categoryView.backgroundColor = kClearColor;
        _categoryView.titleSelectedColor = kWhiteColor;
        _categoryView.titleColor = kWhiteColor;
        _categoryView.titleFont = [UIFont systemFontOfSize:18];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:28];
        _categoryView.delegate = self;
        _categoryView.titles = self.titleMutArr;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.indicators = @[self.lineView];//
        _categoryView.defaultSelectedIndex = 1;//默认从第二个开始显示
        _categoryView.cellSpacing = -20;
        //关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryView.contentScrollView = self.listContainerView.scrollView;//
        [self.view addSubview:_categoryView];
        [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view.mas_centerX);
            make.height.mas_equalTo(SCALING_RATIO(50));
            make.top.equalTo(self.listContainerView).offset(rectOfStatusbar());
        }];
        [self.view layoutIfNeeded];
    }return _categoryView;
}

@end
