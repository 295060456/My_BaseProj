//
//  UBLMailboxVerificationVC.m
//  UBLLive
//
//  Created by Jobs on 2020/11/26.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "UBLMailboxVerificationVC.h"

@interface UBLMailboxVerificationVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,strong)__block NSString *usernameStr;
@property(nonatomic,strong)__block NSString *mailboxAddressStr;

@end

@implementation UBLMailboxVerificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.alpha = 1;
    self.nextBtn.alpha = 1;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UBLRetrievePasswordTBVCell cellHeightWithModel:nil];;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.titleMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UBLRetrievePasswordTBVCell *cell = [UBLRetrievePasswordTBVCell cellWithTableView:tableView];
    [cell richElementsInCellWithModel:@{@"title":self.titleMutArr[indexPath.row],
                                        @"placeHolder":self.placeHolderMutArr[indexPath.row]}];
    @weakify(self)
    [cell actionBlockRetrievePasswordTBVCell:^(id data) {
        @strongify(self)
        NSLog(@"data = %@",data);
        NSDictionary *dic = (NSDictionary *)data;
        if ([dic[@"TextLabelContentText"] isEqualToString:self.titleMutArr[0]]) {
            self.usernameStr = dic[@"ResString"];
        }else if([dic[@"TextLabelContentText"] isEqualToString:self.titleMutArr[1]]){
            self.mailboxAddressStr = dic[@"ResString"];
        }else{}
    }];
    return cell;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = RGBCOLOR(246, 246, 246);
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = UIView.new;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_equalTo(self.titleMutArr.count * [UBLRetrievePasswordTBVCell cellHeightWithModel:nil]);
        }];
    }return _tableView;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = UIButton.new;
        _nextBtn.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"退出登录渐变色底图")];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [self.view addSubview:_nextBtn];
        @weakify(self)
        [[_nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            NSLog(@"点击下一步");
//            [UBLNetWorkManager postRequestWithUrlPath:UBLUrlCheckIdentity
//                                           parameters:@{
//                                               @"":@"",
//                                               @"":@""
//                                           }
//                                             finished:^(UBLNetWorkResult * _Nonnull result) {
//                NSLog(@"result = %@",result);
//                if (!result.error) {
//                    
//                }
//            }];

            [UIViewController comingFromVC:self
                                      toVC:UBLChangePasswordVC.new
                               comingStyle:ComingStyle_PUSH
                         presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                             requestParams:@""
                  hidesBottomBarWhenPushed:YES
                                  animated:YES
                                   success:^(id data) {
                
            }];
        }];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-213);
            make.size.mas_equalTo(CGSizeMake(347, 43));
        }];
        [UIView cornerCutToCircleWithView:_nextBtn AndCornerRadius:3];
    }return _nextBtn;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"用户名"];
        [_titleMutArr addObject:@"邮箱"];
    }return _titleMutArr;
}

-(NSMutableArray<NSString *> *)placeHolderMutArr{
    if (!_placeHolderMutArr) {
        _placeHolderMutArr = NSMutableArray.array;
        [_placeHolderMutArr addObject:@"请输入用户名"];
        [_placeHolderMutArr addObject:@"请输入绑定邮箱号码"];
    }return _placeHolderMutArr;
}

@end
