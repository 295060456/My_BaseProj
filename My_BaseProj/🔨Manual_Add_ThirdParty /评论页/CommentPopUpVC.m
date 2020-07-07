//
//  CommentPopUpVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CommentPopUpVC.h"

#import "ZFJTreeViewKit.h"
#import "MyNodeViewCell.h"

#import "MyNodeModel.h"

@interface CommentPopUpVC ()
<
ZFJTreeViewDelegate
>

@property(nonatomic,weak)ZFJTreeViewConfig *treeViewConfig;
@property(nonatomic,strong)MyNodeModel *myModel;
@property(nonatomic,strong)NSMutableArray *dataArr_1;//一级节点数组
@property(nonatomic,strong)NSMutableArray *dataArr_2;//二级节点数组
@property(nonatomic,strong)NSMutableArray <NSArray <NSArray *>*>*dataArr;//模拟服务器返回的数据源

@end

@implementation CommentPopUpVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //直接置为nil 不走dealloc 但是内存打印是nil
//    [self.treeView removeFromSuperview];
//    self.treeView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.gk_navTitleColor = kBlackColor;
    self.gk_navBackgroundColor = kClearColor;
    self.gk_navigationBar.backgroundColor = kClearColor;
    self.gk_navTitle = @"评论页";
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    [self refreshAndLoadMore];
    [self OK];
}

- (void)viewWillLayoutSubviews {
    //这种做法确实是没有办法，因为没有办法获取到navigationBar里面的_UINavigationBarContentView
    self.gk_navigationBar.frame = CGRectMake(0,
                                             -GK_NAVBAR_HEIGHT,
                                             SCREEN_WIDTH,
                                             SCALING_RATIO(58));
    [self.gk_navigationBar layoutSubviews];
}

-(void)refreshAndLoadMore{
    Ivar ivar = class_getInstanceVariable([ZFJTreeView class], "_tableView");
    UITableView *tableView = object_getIvar(self.treeView, ivar);
    tableView.showsVerticalScrollIndicator = NO;
    tableView.mj_header = self.tableViewHeader;
    tableView.mj_footer = self.tableViewFooter;
    self.tableViewFooter.hidden = NO;
}

- (void)OK {

    MyNodeModel *myModel = [[MyNodeModel alloc] init];
    myModel.title = @"自定义Title";

#pragma mark - 添加一级节点
    if(self.dataArr_1.count != 0){
        [self.dataArr_1 removeAllObjects];
    }
    
    for (int i = 0; i < self.dataArr.count; i++) {//4
        ZFJNodeModel *model_f1 = [[ZFJNodeModel alloc] initWithParentNodeModel:nil];
        model_f1.nodeName = self.dataArr[i][0][0];
        model_f1.height = 55;    //节点高度
//        model_f1.sourceModel = myModel;
        model_f1.nodeCellCls = [MyNodeViewCell class];
        [self.treeView insertNode:model_f1 completed:^(ZFJError *_Nonnull error) {
            NSLog(@"%@", error.message);
        }];
        [self.dataArr_1 addObject:model_f1];
    }
#pragma mark - 添加二级节点
    for (int k = 0; k < self.dataArr_1.count; k++) {//4
        ZFJNodeModel *model_f1 = self.dataArr_1[k];
        NSArray *tempArr = self.dataArr[k][1];
        for (int i = 0; i < tempArr.count; i++) {
            ZFJNodeModel *model_f2 = [[ZFJNodeModel alloc] initWithParentNodeModel:model_f1];
            model_f2.nodeName = self.dataArr[k][1][i];    //[NSString stringWithFormat:@"二级节点%d楼",i];
            model_f2.height = 55;    //节点高度
            //model_f2.sourceModel = myModel;
            model_f2.nodeCellCls = [MyNodeViewCell class];
            [self.treeView insertNode:model_f2 completed:^(ZFJError *_Nonnull error) {
                NSLog(@"%@", error.message);
            }];
            [self.dataArr_2 addObject:model_f2];
        }
    }
}

#pragma mark - ZFJTreeViewDelegate
- (void)treeListView:(ZFJTreeView *)listView
  didSelectNodeModel:(ZFJNodeModel *)model
           indexPath:(NSIndexPath *)indexPath{
    //删除
//    [self.treeView deleteNode:model completed:^(ZFJError * _Nonnull error) {
//        NSLog(@"aaaaaaaaa");
//    }];
    //展开、折叠
    [self.treeView expandChildNodes:model
                          completed:^(ZFJError * _Nonnull error) {
        NSLog(@"%@",error.message);
    }];
    
//    [self.treeView expandAllNodes:YES];
}

#pragma mark —— lazyLoad
-(ZFJTreeViewConfig *)treeViewConfig{
    if (!_treeViewConfig) {
        _treeViewConfig = ZFJTreeViewConfig.new;
        _treeViewConfig.separatorStyle = UITableViewCellSeparatorStyleNone;
        _treeViewConfig.selectionStyle = UITableViewCellSelectionStyleNone;
    }return _treeViewConfig;
}

-(ZFJTreeView *)treeView{
    if (!_treeView) {
        extern CGFloat LZB_TABBAR_HEIGHT;
        _treeView = [[ZFJTreeView alloc] initWithFrame:CGRectMake(0,
                                                                  GK_NAVBAR_HEIGHT,
                                                                  SCREEN_WIDTH,
                                                                  self.liftingHeight - GK_NAVBAR_HEIGHT - LZB_TABBAR_HEIGHT)
                                                config:self.treeViewConfig];
        _treeView.delegate = self;
        [self.view addSubview:_treeView];
        _treeView.backgroundColor = KGreenColor;
    }return _treeView;
}

-(MyNodeModel *)myModel{
    if (!_myModel) {
        _myModel = MyNodeModel.new;
        _myModel.title = @"自定义Title";
    }return _myModel;
}

-(NSMutableArray *)dataArr_1{
    if (!_dataArr_1) {
        _dataArr_1 = NSMutableArray.array;
    }return _dataArr_1;
}

-(NSMutableArray *)dataArr_2{
    if (!_dataArr_2) {
        _dataArr_2 = NSMutableArray.array;
    }return _dataArr_2;
}

-(NSMutableArray<NSArray<NSArray *> *> *)dataArr{
    if (!_dataArr) {
        _dataArr = NSMutableArray.array;
        [_dataArr addObject:@[@[@"我是1楼"],@[@"1楼跟帖_1",@"1楼跟帖_2",@"1楼跟帖_3"]]];
        [_dataArr addObject:@[@[@"我是2楼"],@[@"2楼跟帖_1",@"2楼跟帖_2"]]];
        [_dataArr addObject:@[@[@"我是3楼"],@[]]];
        [_dataArr addObject:@[@[@"我是4楼"],@[@"4楼跟帖_1",@"4楼跟帖_2",@"4楼跟帖_3"]]];
    }return _dataArr;
}

@end
