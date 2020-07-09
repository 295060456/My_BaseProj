//
//  ViewController@3.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@3.h"
#import "WaterMark.h"
#import "HotLabel.h"

@interface ViewController_3 (){
    
}

@property(nonatomic,strong)WaterMark *waterMark;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)HotLabel *hotLabel;
@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)DataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation ViewController_3

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                    withStyle:(ComingStyle)comingStyle
                requestParams:(nullable id)requestParams
                      success:(DataBlock)block
                     animated:(BOOL)animated{
    ViewController_3 *vc = ViewController_3.new;
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

-(void)viewDidLoad{
    self.view.backgroundColor = RandomColor;
    [self makeWaterMark];
//    [self makeHotLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES
                                             animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO
                                             animated:animated];
}

-(void)makeHotLabel{
    NSArray *dataArr = @[@"1",@"22",@"333",@"4444",@"55555",@"666666",@"7777777",@"88888888",@"999999999",@"AAAAAAAAAA",@"BBBBBBBBBBB",@"CCCCCCCCCCCC"];
//    [dataArr mutableCopy];
    [self.view addSubview:self.hotLabel];
//    [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.right.equalTo(self.view).offset(-50);
////        make.left.equalTo(self.view).offset(50);
//        make.left.right.equalTo(self.view);
//        make.top.mas_equalTo(rectOfNavigationbar + rectOfStatusbar);
//    }];
    self.hotLabel.frame = CGRectMake(50, 80, 414, 800);
    self.hotLabel.backgroundColor = kCyanColor;
    [self.view layoutIfNeeded];
    //这个时候才拿到父控件的frame值,否则无法运算
    [self.hotLabel hotLabelWithDataArr:dataArr];
}

-(HotLabel *)hotLabel{
    if (!_hotLabel) {
        _hotLabel = [[HotLabel alloc]initWithTopOffset:20
                                             eachOffset:10];
        
        @weakify(self)
        [_hotLabel actionBlock:^(id data) {
            @strongify(self)
            UILabel *lab = (UILabel *)data;
            [self.hotLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(lab.mj_y + lab.mj_h + 20);
            }];
            [self.view layoutIfNeeded];
        }];
    } return _hotLabel;
}


-(void)makeWaterMark{
    [self.view addSubview:self.waterMark];
    self.waterMark.frame = CGRectMake(100, 100, 200, 400);//先要给个frame
    self.waterMark.backgroundColor = kRedColor;
    self.imgView.frame = CGRectMake(100, 500, 300, 300);
    self.imgView.backgroundColor = kBlueColor;
    [self.view addSubview:self.imgView];
    self.imgView.image = [UIView getImageFromView:self.waterMark];
}

-(WaterMark *)waterMark{
    if (!_waterMark) {
        _waterMark = [[WaterMark alloc]initWithLableWidth:50
                                              LableHeight:30
                                        LableOffset_level:10
                                     LableOffset_vertical:5];
        
        
    }return _waterMark;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = UIImageView.new;
    }return _imgView;
}



@end
