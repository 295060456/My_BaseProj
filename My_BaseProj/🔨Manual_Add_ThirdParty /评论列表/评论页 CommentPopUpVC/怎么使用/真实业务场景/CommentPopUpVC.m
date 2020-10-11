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

#import "CommentPopUpNonHoveringHeaderFooterView.h"
#import "CommentPopUpHoveringHeaderFooterView.h"
#import "UITableViewHeaderFooterView+Attribute.h"

@interface CommentPopUpVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UIBarButtonItem *closeItem;
@property(nonatomic,strong)UIButton *closeBtn;

@property(nonatomic,strong)MKFirstCommentModel *firstCommentModel;
@property(nonatomic,strong)MKChildCommentModel *childCommentModel;
@property(nonatomic,strong)NSString *commentId;
@property(nonatomic,strong)NSString *ID;

@end

@implementation CommentPopUpVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)init{
    if (self = [super init]) {
        self.isClickExitBtn = NO;
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
    self.gk_navLineHidden = YES;
    self.gk_navLeftBarButtonItem = self.closeItem;
    self.inputView.alpha = 1;
    self.tableView.alpha = 1;
    [self netWorking_MKCommentQueryInitListGET];
}
//里面包含了网络请求
-(void)likeBtnClickAction:(RBCLikeButton *)sender{
    //1.记录是否是点赞操作
    BOOL isThump = !sender.isSelected;
    sender.userInteractionEnabled = NO;//防止多次点击
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
            [self netWorking_MKCommentSetPraisePOSTWithCommentId:self.commentId
                                                              ID:self.ID
                                                          sender:sender];
        }
    }else{//如果是取消点赞操作
        //发起网络请求,告知服务器APP进行了取消点赞操作,服务器的返回结果为isRequestSuccess
        //服务器返回的点赞按钮状态为status
        RBCLikeButtonStatus status = RBCLikeButtonStatusNoneThumbs;
        //如果status不是"正在取消点赞"和"正在点赞"和"已点赞"的状态时,再执行点赞网络请求
        if (status != RBCLikeButtonStatusCancelThumbsing
            && status != RBCLikeButtonStatusThumbsing
            && status != RBCLikeButtonStatusHadThumbs){
            [self netWorking_MKCommentSetPraisePOSTWithCommentId:self.commentId
                                                              ID:self.ID
                                                          sender:sender];
        }
    }
}

-(void)commentPopUpActionBlock:(MKDataBlock)commentPopUpBlock{
    self.CommentPopUpBlock = commentPopUpBlock;
}

-(void)SureDeleteSelfComment{
    [self netWorking_MKCommentDelCommentPOSTWithCommentId:self.commentId
                                                       ID:self.ID];
}

-(void)Sure{}
//一级标题的：
-(void)Reply{
    NSLog(@"%@",self.firstCommentModel.content);
    [self.inputView.textField becomeFirstResponder];
    [self netWorking_MKCommentReplyCommentPOSTWithCommentId:self.commentId
                                                         ID:self.ID
                                                    content:self.inputContentStr];
}

-(void)CopyIt{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.firstCommentModel.content;
    [WHToast showErrorWithMessage:@"复制成功"
                         duration:2
                    finishHandler:^{
      
    }];
}

-(void)Report{
//    self.firstCommentModel
}

-(void)Cancel{}
//二级标题的：
-(void)reply{
    NSLog(@"%@",self.childCommentModel.content);
    [self.inputView.textField becomeFirstResponder];
    [self netWorking_MKCommentReplyCommentPOSTWithCommentId:self.commentId
                                                         ID:self.ID
                                                    content:self.inputContentStr];
}

-(void)copyIt{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.childCommentModel.content;
    [WHToast showErrorWithMessage:@"复制成功"
                         duration:2
                    finishHandler:^{
      
    }];
}

-(void)report{
//    self.childCommentModel;
}

-(void)cancel{}
#pragma mark ===================== 下拉刷新===================================
- (void)pullToRefresh {
    NSLog(@"下拉刷新");
    if (self.commentModel.listMytArr.count) {
        [self.commentModel.listMytArr removeAllObjects];
    }
    [self netWorking_MKCommentQueryInitListGET];
}
#pragma mark ===================== 上拉加载更多===================================
- (void)loadMoreRefresh {
    NSLog(@"上拉加载更多");
}

-(void)endRefreshing:(BOOL)refreshing{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark —— 点击事件
-(void)closeBtnClickEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
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
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:LoadMoreTBVCell.class]) {//加载更多
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
    }else if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:InfoTBVCell.class]){// 有内容
        InfoTBVCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.childCommentModel = cell.childCommentModel;
        self.commentId = self.childCommentModel.commentId;
        self.ID = self.childCommentModel.ID;
        @weakify(self)
        [cell action:^(id data) {
            @strongify(self)
            [self likeBtnClickAction:cell.LikeBtn];
        }];
        [NSObject showSYSActionSheetTitle:nil
                                  message:nil
                          isSeparateStyle:YES
                              btnTitleArr:@[@"回复",@"复制",@"举报",@"取消"]
                           alertBtnAction:@[@"reply",@"copyIt",@"report",@"cancel"]
                                 targetVC:self
                                   sender:nil
                             alertVCBlock:^(id data) {
            //DIY
        }];
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
            }];return cell;
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
    CommentPopUpNonHoveringHeaderFooterView *header = nil;
    MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[section];
    {//第一种创建方式
        header = [[CommentPopUpNonHoveringHeaderFooterView alloc]initWithReuseIdentifier:NSStringFromClass(CommentPopUpNonHoveringHeaderFooterView.class)
                                                              withData:firstCommentModel];
        @weakify(self)
        [header actionBlockNonHoveringHeaderView:^(id data) {
            self.commentId = firstCommentModel.commentId;
            self.ID = firstCommentModel.ID;
            @strongify(self)
            if ([data isKindOfClass:NSDictionary.class]) {//
                NSDictionary *dic = (NSDictionary *)data;
                if ([dic[@"sender"] isMemberOfClass:UIControl.class]){
                    if ([[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid isEqualToString:firstCommentModel.userId]) {
                        [NSObject showSYSAlertViewTitle:@"确认删除自己的评论？"
                                                message:nil
                                        isSeparateStyle:NO
                                            btnTitleArr:@[@"确认",@"手滑啦"]
                                         alertBtnAction:@[@"SureDeleteSelfComment",@"Cancel"]
                                               targetVC:self
                                           alertVCBlock:^(id data) {
                            //DIY
                        }];
                    }else{
                        UIControl *control = (UIControl *)dic[@"sender"];
                        self.firstCommentModel = dic[@"model"];
                        [NSObject showSYSActionSheetTitle:nil
                                                  message:nil
                                          isSeparateStyle:YES
                                              btnTitleArr:@[@"回复",@"复制",@"举报",@"取消"]
                                           alertBtnAction:@[@"Reply",@"CopyIt",@"Report",@"Cancel"]
                                                 targetVC:self
                                                   sender:control
                                             alertVCBlock:^(id data) {
                            //DIY
                        }];
                    }
                }else if ([dic[@"sender"] isMemberOfClass:RBCLikeButton.class]){
                    NSLog(@"");
                    RBCLikeButton *btn = (RBCLikeButton *)dic[@"sender"];
                    [self likeBtnClickAction:btn];
                }else{}
            }
        }];
    }
    
//
//
    
//    {//第二种创建方式
//        //viewForHeaderInSection 悬停与否
//        Class headerClass = CommentPopUpNonHoveringHeaderView.class;
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
        ///发送
        [_inputView actionInputViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:ZYTextField.class]) {
                ZYTextField *tf = (ZYTextField *)data;
                if (!self.closeBtn.selected) {
                    //校验空字符串
                    if (![NSString isNullString:tf.text]) {
                        self.inputContentStr = tf.text;
                        //如果登录,那么直接发送
                        if (1) {
                            [self netWorking_MKCommentVideoPOST];
                        }
                    }else{
                        [NSObject showSYSAlertViewTitle:@"总的说点什么吧"
                                                message:nil
                                        isSeparateStyle:NO
                                            btnTitleArr:@[@"好哒"]
                                         alertBtnAction:@[@"Sure"]
                                               targetVC:self
                                           alertVCBlock:^(id data) {
                            //DIY
                        }];
                    }
                }
            }
        }];
        ///删除
        [_inputView actionisInputtingBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:ZYTextField.class]) {
                ZYTextField *tf = (ZYTextField *)data;
                if (self.CommentPopUpBlock) {
                    self.CommentPopUpBlock(tf);
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
        [_tableView registerClass:CommentPopUpNonHoveringHeaderFooterView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(CommentPopUpNonHoveringHeaderFooterView.class)];
        [_tableView registerClass:HoveringHeaderView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(CommentPopUpHoveringHeaderFooterView.class)];
        _tableView.mj_header = self.mjRefreshGifHeader;
        _tableView.mj_footer = self.mjRefreshAutoGifFooter;
        _tableView.mj_footer.hidden = NO;
        _tableView.tableFooterView = UIView.new;
//        _tableView.mj_footer.automaticallyHidden = NO;//默认根据数据来源 自动显示 隐藏footer，这个功能可以关闭
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
        _closeItem = [[UIBarButtonItem alloc] initWithCustomView:self.closeBtn];
    }return _closeItem;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = UIButton.new;
        _closeBtn.frame = CGRectMake(0,
                                     0,
                                     44,
                                     44);
        [_closeBtn setImage:KIMG(@"Close")
                   forState:UIControlStateNormal];
        [_closeBtn addTarget:self
                      action:@selector(closeBtnClickEvent:)
            forControlEvents:UIControlEventTouchUpInside];
    }return _closeBtn;
}

-(NSMutableArray<MKFirstCommentModel *> *)firstCommentModelMutArr{
    if (!_firstCommentModelMutArr) {
        _firstCommentModelMutArr = NSMutableArray.array;
    }return _firstCommentModelMutArr;
}



@end
