//
//  ViewController@4.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@4.h"
#import "ArcTBVCell.h"
#define KHeaderHeight 200//这里我们的图片高度暂定为200

@interface ViewController_4 ()<UITableViewDelegate,UITableViewDataSource>{
    
    
}
@property(nonatomic,strong)UITableView *tbv;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,assign)UIStatusBarStyle statusBarStyle;
@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)DataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation ViewController_4

+ (instancetype)pushFromVC:(UIViewController *)rootVC
             requestParams:(nullable id)requestParams
                   success:(DataBlock)block
                  animated:(BOOL)animated{

    ViewController_4 *vc = ViewController_4.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;

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
    }return vc;
}

-(void)viewDidLoad{
    
//    self.view.backgroundColor = KGreenColor;
    
    [self prepareTableView];
    
    [self prepareHeaderView];
    
    _statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19], NSForegroundColorAttributeName:[UIColor redColor]}];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //取消自动调整滚动视图间距 - VC + NAV 会自动调整TBV 的 contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController setNavigationBarHidden:YES];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return _statusBarStyle;
}

-(void)prepareTableView{
    
    _tbv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tbv.dataSource = self;
    
    _tbv.delegate = self;

    _tbv.contentInset = UIEdgeInsetsMake(KHeaderHeight, 0, 0, 0 );

    _tbv.scrollIndicatorInsets = _tbv.contentInset;

    [self.view addSubview:self.tbv];
    
//    [self.tbv mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.view).offset(164);
//
//        make.left.right.equalTo(self.view);
//
//        make.height.mas_equalTo(MAINSCREEN_HEIGHT / 2);
//    }];

}

-(void)prepareHeaderView{
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, KHeaderHeight)];
//    _headerView.backgroundColor = KGreenColor;
    [self.view addSubview:_headerView];
    
    _headerImageView = [[UIImageView alloc]initWithFrame:_headerView.bounds];
    _headerImageView.backgroundColor = kGrayColor;
    
    //设置 contentMode
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    //设置图像裁切
    _headerImageView.clipsToBounds = YES;
    [_headerView addSubview:_headerImageView];
    
    //添加分隔点 一个像素点
    CGFloat lineHeight = 1 / [UIScreen mainScreen].scale;
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, KHeaderHeight - lineHeight, _headerView.mj_w, lineHeight)];
    _lineView.backgroundColor = KLightGrayColor;
//    [_headerView addSubview:_lineView];
    
    //设置图像
//    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:@"http://5b0988e595225.cdn.sohucs.com/images/20180615/0920dd51bb3940fca1c440f15786d566.jpeg"]
//                       placeholderImage:[UIImage imageNamed:@"图片"]];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    
//    NSLog(@"kkk%f",scrollView.contentInset.top);//200
    
    //放大
    if (offset <= 0) {
        NSLog(@"1-%f",offset);
        //调整 headeView 和 headImageView
        _headerView.mj_y = 0;
        _headerView.mj_h = KHeaderHeight - offset;
        _headerImageView.alpha = 1;
    }else{
        NSLog(@"2-%f",offset);
        //整体移动
        _headerView.mj_h = KHeaderHeight;
        //headerView 最小 y 值
        CGFloat min = KHeaderHeight - rectOfNavigationbar - rectOfStatusbar;
        _headerView.mj_y = -MIN(min,offset);
        
        //设置透明度 offset / min == 1 不可见
        CGFloat progress = 1 - (offset / min);
        _headerImageView.alpha = progress;
        
        //根据透明度来修改状态栏的颜色
        _statusBarStyle = (progress < 0.5) ? UIStackViewSpacingUseDefault:UIStatusBarStyleLightContent;
        
        //主动更新状态栏
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    }
    
    //设置图像高度
    _headerImageView.mj_h = _headerView.mj_h;
    
    //设置分割线位置
    _lineView.mj_y = _headerView.mj_h - _lineView.mj_h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [ArcTBVCell cellHeight:NULL];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ArcTBVCell *cell = [ArcTBVCell cellWith:tableView];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 300;
}

//-(UITableView *)tbv{
//
//    if (!_tbv) {
//
//        _tbv = UITableView.new;
//
////        _tbv.style = UITableViewStylePlain;//err
//
//        _tbv.dataSource = self;
//
//        _tbv.delegate = self;
//
//        _tbv.backgroundColor = kRedColor;
//
//        _tbv.contentInset = UIEdgeInsetsMake(KHeaderHeight, 0, 0, 0 );
//
//        _tbv.scrollIndicatorInsets = _tbv.contentInset;
//
//    }
//
//    return _tbv;
//}


@end
