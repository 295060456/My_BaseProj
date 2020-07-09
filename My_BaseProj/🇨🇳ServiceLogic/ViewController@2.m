//
//  ViewController@2.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@2.h"
#import "HistoryDataListTBV.h"
#import "HistoryDataListTBVCell.h"

///视频框架
//#import <libavformat/avformat.h>
//#import <libavcodec/avcodec.h>
//#import <libswscale/swscale.h>
//#import <libavutil/avutil.h>
//#import <libswresample/swresample.h>
//#import <libavdevice/avdevice.h>
//#import <libavfilter/avfilter.h>

@interface ViewController_2 (){
}

@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIView *mainView;
@property(nonatomic,strong)HistoryDataListTBV *historyDataListTBV;
@property(nonatomic,strong)NSMutableArray *dataMutArr;
@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)DataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation ViewController_2

- (void)dealloc {
    
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}


+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                    withStyle:(ComingStyle)comingStyle
                requestParams:(nullable id)requestParams
                      success:(DataBlock)block
                     animated:(BOOL)animated{
    ViewController_2 *vc = ViewController_2.new;
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

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        [self value];
    }return self;
}

-(void)value{
    [self.dataMutArr addObject:@"111"];
    [self.dataMutArr addObject:@"222"];
    [self.dataMutArr addObject:@"333"];
    [self.dataMutArr addObject:@"444"];
}

-(void)viewDidLoad{
    self.view.backgroundColor = kRedColor;//RandomColor;
    [self setView:self.mainView];
    [self.mainView addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView).offset(SCALING_RATIO(30));
        make.top.equalTo(self.mainView).offset(SCALING_RATIO(30) + rectOfStatusbar() + rectOfNavigationbar);
        make.right.equalTo(self.mainView).offset(-SCALING_RATIO(30));
        make.height.mas_equalTo((SCALING_RATIO(100)));
    }];
    
//    BaseNavigationVC *nav = (BaseNavigationVC *)self.navigationController;
//    [nav setupEditBtn:self];
    
    //视频相关
//    av_register_all();
//    avcodec_register_all();
//    avformat_network_init();
//    AVFormatContext *avFormatContext = avformat_alloc_context();
//
//    NSString *url = @"rtmp://v1.one-tv.com:1935/live/mpegts.stream";
//    if (avformat_open_input(&avFormatContext, [url UTF8String], NULL, NULL) != 0) {
//        av_log(NULL, AV_LOG_ERROR, "Couldn't open file");
//    }
//
//    if (avformat_find_stream_info(avFormatContext, NULL) < 0) {
//        av_log(NULL, AV_LOG_ERROR, "Couldn't find stream information");
//    } else {
//        av_dump_format(avFormatContext, 0, [url cStringUsingEncoding:NSUTF8StringEncoding], NO);
//    }
}

-(void)btnClickEvent:(UIButton *)sender{
    if (self.dataMutArr.count > 0) {
        //添加到父视图上
        [self.mainView addSubview:self.historyDataListTBV];
        self.historyDataListTBV.frame = CGRectMake(self.btn.mj_x,
                                                   self.btn.mj_y + self.btn.mj_h,
                                                   self.btn.mj_w,
                                                   [HistoryDataListTBVCell cellHeightWithModel:Nil] * self.dataMutArr.count);
        
        [self.historyDataListTBV reloadData];
    }
}

#pragma mark ======== LazyLoad ======
-(UIView *)mainView{
    if (!_mainView) {
        _mainView = UIView.new;
        if (@available(iOS 13.0, *)) {
            _mainView.frame = [SceneDelegate sharedInstance].window.frame;
        }else{
            _mainView.frame = UIApplication.sharedApplication.delegate.window.frame;
        }
    }return _mainView;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = UIButton.new;
        [_btn setTitle:@"我是Btn"
              forState:UIControlStateNormal];
        [_btn setTitleColor:kBlackColor
                   forState:UIControlStateNormal];
        [_btn addTarget:self
                 action:@selector(btnClickEvent:)
       forControlEvents:UIControlEventTouchUpInside];
        [UIView cornerCutToCircleWithView:_btn
                          AndCornerRadius:4];
        [UIView colourToLayerOfView:_btn
                         WithColour:kRedColor
                     AndBorderWidth:1.0f];
    }return _btn;
}

-(NSMutableArray *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
    }return _dataMutArr;
}

-(HistoryDataListTBV *)historyDataListTBV{
    if (!_historyDataListTBV) {
        _historyDataListTBV = [HistoryDataListTBV initWithRequestParams:self.dataMutArr
                                                              triggerBy:self.btn];
        
        @weakify(self)
//        [_historyDataListTBV deleteData:^(id  _Nullable data) {
//            @strongify(self)
//            NSLog(@"%@",data);
//            [self.dataMutArr removeObject:data];
//            [self->_historyDataListTBV reloadData];
//        }];
        [_historyDataListTBV showSelectedData:^(id data, id data2) {
            @strongify(self)
            [self.btn setTitle:(NSString *)data
                      forState:UIControlStateNormal];
            [self.historyDataListTBV removeFromSuperview];
            self->_historyDataListTBV = Nil;
        }];
        _historyDataListTBV.tableFooterView = UIView.new;
    }return _historyDataListTBV;
}

@end
