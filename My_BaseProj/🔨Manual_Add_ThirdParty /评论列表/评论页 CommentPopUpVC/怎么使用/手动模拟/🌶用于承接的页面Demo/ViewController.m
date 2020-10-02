
//
//  ViewController.m
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ViewController.h"
#import "LoadMoreTBVCell.h"
#import "InfoTBVCell.h"

#import "CommentPopUpNonHoveringHeaderView.h"
#import "HoveringHeaderView.h"
#import "UITableViewHeaderFooterView+Attribute.h"

#import "FirstClassModel.h"
#import "SecondClassModel.h"

@interface ViewController ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UITableView *tableView;
///所有数据一次性全部请求完
@property(nonatomic,strong)NSMutableArray <FirstClassModel *>*sources;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.tableView.alpha = 1;
    NSLog(@"");
}

-(void)headerIsTapEvent:(CommentPopUpNonHoveringHeaderView *)sender{
    //疑惑 传tag无效
    NSLog(@"%p",sender);
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LoadMoreTBVCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadMoreTBVCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:LoadMoreTBVCell.class]) {
        FirstClassModel *fcm = self.sources[indexPath.section];
        fcm.randShow += LoadDataNum;//randShow 初始值是 preMax
        if (fcm.rand > fcm.randShow) {//还有数据
            
            self.sources[indexPath.section].PreMax += LoadDataNum;
            
            fcm._hasMore = YES;
        }else{//fcm.rand = preMax + 1 + LoadDataNum 数据没了
            fcm._hasMore = NO;
        }

        if (fcm._hasMore) {
            if ((fcm.isFullShow && indexPath.row < fcm.secClsModelMutArr.count) ||
                indexPath.row < self.sources[indexPath.section].PreMax) {
                #pragma warning 点击单元格要做的事
                NSLog(@"KKK");
            }else{
                fcm.isFullShow = !fcm.isFullShow;
            }
        }else{}
    #warning 使用动画刷屏 在下面几个数据刷新的时候会闪屏
    //        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
    //                 withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadData];
    }else{}
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    if (self.sources[section].secClsModelMutArr.count > self.sources[section].PreMax &&
        self.sources[section]._hasMore &&
        !self.sources[section].isFullShow) {
        return self.sources[section].PreMax + 1;
    }else{
        return self.sources[section].secClsModelMutArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sources[indexPath.section].isFullShow) {//是全显示
        InfoTBVCell *cell = [InfoTBVCell cellWith:tableView];
        [cell richElementsInCellWithModel:self.sources[indexPath.section].secClsModelMutArr[indexPath.row].secondClassText];
        return cell;
    }else{//不是全显示
        if (indexPath.row == self.sources[indexPath.section].PreMax &&
            self.sources[indexPath.section]._hasMore) {//
            LoadMoreTBVCell *cell = [LoadMoreTBVCell cellWith:tableView];
            [cell richElementsInCellWithModel:nil];
            return cell;
        }else{
            InfoTBVCell *cell = [InfoTBVCell cellWith:tableView];
//            int r = indexPath.row;
//            int d = indexPath.section;
            [cell richElementsInCellWithModel:self.sources[indexPath.section].secClsModelMutArr[indexPath.row].secondClassText];
            return cell;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sources.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return [LoadMoreTBVCell cellHeightWithModel:nil];
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    
    CommentPopUpNonHoveringHeaderView *header = nil;
    
    {//第一种创建方式
        header = [[CommentPopUpNonHoveringHeaderView alloc]initWithReuseIdentifier:NSStringFromClass(CommentPopUpNonHoveringHeaderView.class)
                                                              withData:@(section)];


    
        [header.result addTarget:self
                          action:@selector(headerIsTapEvent:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    
//    {//第二种创建方式
//        //viewForHeaderInSection 悬停与否
//        Class headerClass = CommentPopUpNonHoveringHeaderView.class;
//    //    Class headerClass = HoveringHeaderView.class;
//
//        header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(headerClass)];
//    }
    
    header.tableView = tableView;
    header.section = section;
    header.textLabel.text = self.sources[section].firstClassText;

    return header;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.mj_footer.automaticallyHidden = NO;//默认根据数据来源 自动显示 隐藏footer，这个功能可以关闭
        [_tableView registerClass:CommentPopUpNonHoveringHeaderView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(CommentPopUpNonHoveringHeaderView.class)];
        [_tableView registerClass:HoveringHeaderView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(HoveringHeaderView.class)];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return _tableView;
}

- (NSMutableArray <FirstClassModel *>*)sources{
    if(!_sources){
        _sources = NSMutableArray.array;
        for(NSInteger idx = 1; idx <= 50; idx ++){
            NSString *str = [NSString stringWithFormat:@"%ld", idx];
            FirstClassModel *hm = [FirstClassModel create:str];
            [_sources addObject:hm];
        }
    }return _sources;
}


@end
