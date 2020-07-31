//
//  CommentPopUpVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CommentPopUpVC.h"
#import "CommentPopUpVC+VM.h"

#import "LoadMoreTBVCell.h"
#import "InfoTBVCell.h"
#import "InputView.h"

#import "NonHoveringHeaderView.h"
#import "HoveringHeaderView.h"
#import "UITableViewHeaderFooterView+Attribute.h"

@interface CommentPopUpVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UIBarButtonItem *closeItem;
@property(nonatomic,strong)InputView *inputView;

@property(nonatomic,strong)MKFirstCommentModel *firstCommentModel;
@property(nonatomic,strong)MKChildCommentModel *childCommentModel;
@property(nonatomic,copy)MKDataBlock CommentPopUpBlock;


@end

@implementation CommentPopUpVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)init{
    if (self = [super init]) {

    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0x242A37);
//    self.view.backgroundColor = kRedColor;
    self.gk_navTitleColor = kWhiteColor;
    self.gk_navBackgroundColor = HEXCOLOR(0x242A37);
    self.gk_navigationBar.backgroundColor = HEXCOLOR(0x242A37);
    self.gk_statusBarHidden = YES;
    self.gk_navTitle = [NSString stringWithFormat:@"%d条评论",self.commentModel.total.intValue];
    self.gk_navLineHidden = YES;
    self.gk_navRightBarButtonItem = self.closeItem;
    self.inputView.alpha = 1;
    self.tableView.alpha = 1;
    [self netWorking_MKCommentQueryInitListGET];
}

-(void)likeBtnClickAction:(RBCLikeButton *)sender{
    //1.记录是否是点赞操作
    BOOL isThump = !sender.isSelected;
    //2.点赞量,正式运用中可自定义(从服务器获取当前的点赞量)
    NSInteger num = sender.thumpNum;
    //3.计算点赞后数值
    if (isThump) {
        //点赞后的点赞数
        num = num + 1;
    }else{
        //取消点赞后的点赞数
        num = num - 1;
    }
    //4.调用点赞动画,设置点赞button的点赞数值
    [sender setThumbWithSelected:isThump thumbNum:num animation:YES];
    //5.网络请求
    if (isThump) {//如果是点赞操作
        //发起网络请求,告知服务器APP进行了点赞操作,服务器返回是否成功的结果为isRequestSuccess
        //服务器返回的点赞按钮状态为status
        RBCLikeButtonStatus status = RBCLikeButtonStatusNoneThumbs;
        //如果status不是"正在取消点赞"和"正在点赞"和"已点赞"的状态时,再执行点赞网络请求
        if (status != RBCLikeButtonStatusCancelThumbsing
            && status != RBCLikeButtonStatusThumbsing
            && status != RBCLikeButtonStatusHadThumbs){
            //改变本地点赞按钮model的点赞状态
            status = RBCLikeButtonStatusThumbsing;
            //开始点赞网络请求
            BOOL isRequestSuccess = YES;//请求成功
            if (!isRequestSuccess) {//如果操作失败(没有网络或接口异常)
                //取消刚才的点赞操作导致的数值变换和点赞按钮的状态变化
                [sender cancelLike];
            }
        }
    }else{//如果是取消点赞操作
        //发起网络请求,告知服务器APP进行了取消点赞操作,服务器的返回结果为isRequestSuccess
        //服务器返回的点赞按钮状态为status
        RBCLikeButtonStatus status = RBCLikeButtonStatusNoneThumbs;
        //如果status不是"正在取消点赞"和"正在点赞"和"已点赞"的状态时,再执行点赞网络请求
        if (status != RBCLikeButtonStatusCancelThumbsing
            && status != RBCLikeButtonStatusThumbsing
            && status != RBCLikeButtonStatusHadThumbs){
            BOOL isRequestSuccess = YES;//请求成功
//            BOOL isRequestSuccess = NO;//请求失败
            status = RBCLikeButtonStatusCancelThumbsing;
            if (!isRequestSuccess) {//如果操作失败(没有网络或接口异常)
                //恢复到点赞之前的点赞数值和点赞按钮的状态变化
                [sender recoverLike];
            }
        }
    }
}

-(void)commentPopUpActionBlock:(MKDataBlock)commentPopUpBlock{
    self.CommentPopUpBlock = commentPopUpBlock;
}

//一级标题的：
-(void)Reply{
    NSLog(@"%@",self.firstCommentModel.content);
}

-(void)CopyIt{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.firstCommentModel.content;
    [MBProgressHUD wj_showPlainText:@"复制成功"
                               view:nil];
}

-(void)Report{
//    self.firstCommentModel
}

-(void)Cancel{}
//二级标题的：
-(void)reply{
    NSLog(@"%@",self.childCommentModel.content);
}

-(void)copyIt{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.childCommentModel.content;
    [MBProgressHUD wj_showPlainText:@"复制成功"
                               view:nil];
}

-(void)report{
//    self.childCommentModel;
}

-(void)cancel{}
#pragma mark ===================== 下拉刷新===================================
- (void)pullToRefresh {
    DLog(@"下拉刷新");
    if (self.commentModel.listMytArr.count) {
        [self.commentModel.listMytArr removeAllObjects];
    }
    [self netWorking_MKCommentQueryInitListGET];
}
#pragma mark ===================== 上拉加载更多===================================
- (void)loadMoreRefresh {
    DLog(@"上拉加载更多");
}

-(void)endRefreshing:(BOOL)refreshing{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark —— 点击事件
-(void)closeBtnClickEvent:(UIButton *)sender{
    if (super.block) {
        super.block(sender);
    }
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LoadMoreTBVCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:LoadMoreTBVCell.class]) {
        MKFirstCommentModel *firstCommentModel = self.firstCommentModelMutArr[indexPath.section];
        firstCommentModel.randShow += LoadDataNum;//randShow 初始值是 preMax
        if (firstCommentModel.rand > firstCommentModel.randShow) {//还有数据
            firstCommentModel.PreMax += LoadDataNum;
            firstCommentModel._hasMore = YES;
        }else{//fcm.rand = preMax + 1 + LoadDataNum 数据没了
            firstCommentModel._hasMore = NO;
        }

        if (firstCommentModel._hasMore) {
            if ((firstCommentModel.isFullShow && indexPath.row < firstCommentModel.childMutArr.count) ||
                indexPath.row < firstCommentModel.PreMax) {
                #pragma warning 点击单元格要做的事
                NSLog(@"KKK");
            }else{
                firstCommentModel.isFullShow = !firstCommentModel.isFullShow;
            }
        }else{}
    #warning 使用动画刷屏 在下面几个数据刷新的时候会闪屏
    //        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
    //                 withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadData];
    }else if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:InfoTBVCell.class]){
        InfoTBVCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.childCommentModel = cell.childCommentModel;
        [self alertControllerStyle:SYS_AlertController
              showActionSheetTitle:nil
                           message:nil
                   isSeparateStyle:YES
                       btnTitleArr:@[@"回复",@"复制",@"举报",@"取消"]
                    alertBtnAction:@[@"reply",@"copyIt",@"report",@"cancel"]
                            sender:nil];
    }else{}
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[section];
    if (firstCommentModel.childMutArr.count > firstCommentModel.PreMax &&
        firstCommentModel._hasMore &&
        !firstCommentModel.isFullShow) {
        return firstCommentModel.PreMax + 1;
    }else{
        return firstCommentModel.childMutArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //二级标题数据从这里进去
    MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[indexPath.section];
    MKChildCommentModel *childCommentModel = firstCommentModel.childMutArr[indexPath.row];
    if (firstCommentModel.isFullShow) {//是全显示
        InfoTBVCell *cell = [InfoTBVCell cellWith:tableView];
        [cell richElementsInCellWithModel:childCommentModel];
        @weakify(self)
        [cell action:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:RBCLikeButton.class]) {
                RBCLikeButton *btn = (RBCLikeButton *)data;
                [self likeBtnClickAction:btn];
            }
        }];
        return cell;
    }else{//不是全显示
        if (indexPath.row == firstCommentModel.PreMax &&
            firstCommentModel._hasMore) {//
            LoadMoreTBVCell *cell = [LoadMoreTBVCell cellWith:tableView];
            [cell richElementsInCellWithModel:childCommentModel];
            return cell;
        }else{
            InfoTBVCell *cell = [InfoTBVCell cellWith:tableView];
//            int r = indexPath.row;
//            int d = indexPath.section;
            @weakify(self)
            [cell richElementsInCellWithModel:childCommentModel];
            [cell action:^(id data) {
                @strongify(self)
                if ([data isKindOfClass:NSDictionary.class]) {
                    NSDictionary *dic = (NSDictionary *)data;
                    if ([dic[@"sender"] isKindOfClass:RBCLikeButton.class]) {
                        RBCLikeButton *btn = (RBCLikeButton *)dic[@"sender"];
                        [self likeBtnClickAction:btn];
                    }
                }
            }];
            return cell;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.commentModel.listMytArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return [LoadMoreTBVCell cellHeightWithModel:nil];
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    //一级标题数据从这里进去
    NonHoveringHeaderView *header = nil;
    MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[section];
    {//第一种创建方式
        header = [[NonHoveringHeaderView alloc]initWithReuseIdentifier:NSStringFromClass(NonHoveringHeaderView.class)
                                                              withData:firstCommentModel];
        @weakify(self)
        [header actionBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSDictionary.class]) {//
                NSDictionary *dic = (NSDictionary *)data;
                if ([dic[@"sender"] isMemberOfClass:UIControl.class]){
                    NSLog(@"");
                    UIControl *control = (UIControl *)dic[@"sender"];
                    self.firstCommentModel = dic[@"model"];
                    [self alertControllerStyle:SYS_AlertController
                          showActionSheetTitle:nil
                                       message:nil
                               isSeparateStyle:YES
                                   btnTitleArr:@[@"回复",@"复制",@"举报",@"取消"]
                                alertBtnAction:@[@"Reply",@"CopyIt",@"Report",@"Cancel"]
                                        sender:control];
                }else if ([dic[@"sender"] isMemberOfClass:RBCLikeButton.class]){
                    NSLog(@"");
                    RBCLikeButton *btn = (RBCLikeButton *)dic[@"sender"];
                    [self likeBtnClickAction:btn];
                }else{}
            }
        }];
    }
//    {//第二种创建方式
//        //viewForHeaderInSection 悬停与否
//        Class headerClass = NonHoveringHeaderView.class;
//    //    Class headerClass = HoveringHeaderView.class;
//
//        header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(headerClass)];
//    }
    
    header.tableView = tableView;
    header.section = section;

    return header;
}
#pragma mark —— lazyLoad
-(__kindof InputView *)inputView{
    if (!_inputView) {
        _inputView = InputView.new;
        _inputView.backgroundColor = HEXCOLOR(0x20242F);
        @weakify(self)
        [_inputView inputViewActionBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UITextField.class]) {
                UITextField *tf = (UITextField *)data;
                self.inputContentStr = tf.text;
                [self netWorking_MKCommentVideoPOST];
                
                if (self.CommentPopUpBlock) {
                    self.CommentPopUpBlock(@1);
                }
            }
        }];
        [self.view addSubview:_inputView];
        [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(SCALING_RATIO(62));
        }];
    }return _inputView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = HEXCOLOR(0x242A37);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:NonHoveringHeaderView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(NonHoveringHeaderView.class)];
        [_tableView registerClass:HoveringHeaderView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(HoveringHeaderView.class)];
        _tableView.mj_header = self.tableViewHeader;
        _tableView.mj_footer = self.tableViewFooter;
        _tableView.mj_footer.hidden = NO;
        _tableView.tableFooterView = UIView.new;
        _tableView.ly_emptyView = [EmptyView emptyViewWithImageStr:@"Indeterminate Spinner - Small"
                                                          titleStr:@"没有评论"
                                                         detailStr:@"来发布第一条吧"];
        if (self.commentModel.listMytArr.count) {
            [_tableView ly_hideEmptyView];
        }else{
            [_tableView ly_showEmptyView];
        }
        [self.view addSubview:_tableView];
        extern CGFloat LZB_TABBAR_HEIGHT;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.gk_navigationBar.mas_bottom);
            make.bottom.equalTo(self.inputView.mas_top);
        }];
    }return _tableView;
}

-(UIBarButtonItem *)closeItem{
    if (!_closeItem) {
        UIButton *btn = UIButton.new;
        btn.frame = CGRectMake(0,
                               0,
                               44,
                               44);
        [btn setImage:kIMG(@"Close")
             forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(closeBtnClickEvent:)
      forControlEvents:UIControlEventTouchUpInside];
        _closeItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }return _closeItem;
}

-(NSMutableArray<MKFirstCommentModel *> *)firstCommentModelMutArr{
    if (!_firstCommentModelMutArr) {
        _firstCommentModelMutArr = NSMutableArray.array;
    }return _firstCommentModelMutArr;
}



@end
