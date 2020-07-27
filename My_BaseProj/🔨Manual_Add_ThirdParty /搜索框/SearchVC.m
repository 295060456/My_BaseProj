//
//  SearchVC.m
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "SearchVC.h"
#import "SearchVC+VM.h"
#import "SearchBar.h"

@interface SearchTBVCell ()

@end

@interface SearchVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)SearchBar *searchBar;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation SearchVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                    withStyle:(ComingStyle)comingStyle
                requestParams:(nullable id)requestParams
                      success:(MKDataBlock)block
                     animated:(BOOL)animated{
    SearchVC *vc = SearchVC.new;
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
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.gk_navigationBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.searchBar.alpha = 1;
    self.tableView.alpha = 1;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark —— UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTBVCell *cell = [SearchTBVCell cellWith:tableView];
    if (self.dataMutArr.count) {
        [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    }return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SearchTBVCell cellHeightWithModel:self.dataMutArr[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:NO];
}
#pragma mark —— lazyLoad
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero
                                                 style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithPatternImage:kIMG(@"builtin-wallpaper-0")];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.searchBar.mas_bottom);
        }];
    }return _tableView;
}

-(SearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = SearchBar.new;
        _searchBar.dataMutArr = self.dataMutArr;//本地搜索
        _searchBar.textField.keyboardType = UIKeyboardTypeDecimalPad;
        [self.view addSubview:_searchBar];
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(rectOfStatusbar());
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(SCALING_RATIO(50));
        }];
        [self.view bringSubviewToFront:_searchBar];
        @weakify(self)
        [_searchBar clickBlock:^(id data) {//btn点击事件
            @strongify(self)
            if (self.navigationController) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        [_searchBar actionBlock:^(CJTextField *data,//textField 他的text是最终结果 ?
                                  SearchBar *data2,//searchBar
                                  NSString *data3,//即将输入的字符
                                  NSString *data4) {//调的方法
            @strongify(self)
            if ([data4 isEqualToString:@"CJTextFieldDeleteDelegate_cjTextFieldDeleteBackward"]) {//直接按键盘删除键
                //此时的textField.text为变动后的值
                if (data.text.length > 0) {//输入框有值
                    [self networking_type:data.text];
                }else{ //输入框无值 到顶了
                    [self.dataMutArr removeAllObjects];
                    [self.tableView reloadData];
                }
            }else if ([data4 isEqualToString:@"CJTextFieldDeleteDelegate_textFieldDidEndEditing"]){//确定了输入框的目前值，然后按下done键
                //此时的textField.text为变动前的值
                NSString *str = [data.text stringByAppendingString:data3];
                [self networking_type:str];
            }else if ([data4 isEqualToString:@"CJTextFieldDeleteDelegate_textFieldDidEndEditing"]){//停止编辑模式，确定一个输入框的值，按下搜索键
                //此时的textField.text为变动前的值
                NSString *str = [data.text stringByAppendingString:data3];
                [self networking_type:str];
            }else{//正常的正向输入        CJTextFieldDeleteDelegate_shouldChangeCharactersInRange

            }
        }];
    }return _searchBar;
}

-(NSMutableArray *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
    }return _dataMutArr;
}

@end

@implementation SearchTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    SearchTBVCell *cell = (SearchTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[SearchTBVCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:ReuseIdentifier
                                             margin:SCALING_RATIO(0)];
        [UIView cornerCutToCircleWithView:cell.contentView
                          AndCornerRadius:5.f];
        [UIView colourToLayerOfView:cell.contentView
                         WithColour:KGreenColor
                     AndBorderWidth:.1f];
        cell.backgroundColor = KLightGrayColor;;
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 50;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{

}

@end
