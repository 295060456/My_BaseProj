//
//  MKShootVC.m
//  Shooting
//
//  Created by Jobs on 2020/8/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKShootVC.h"
#import "GPUImageTools.h"
#import "CustomerGPUImagePlayerVC.h"//视频预览 VC

#import "MyCell.h"
#import "MovieCountDown.h"

#import "MKShootVC+VM.h"

@interface MKShootVC ()

#pragma mark —— UI
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *overturnBtn;//镜头翻转
@property(nonatomic,strong)UIButton *flashLightBtn;//闪光灯
@property(nonatomic,strong)UIButton *countDownBtn;//开始录制的时候是否允许有倒计时;默认无
@property(nonatomic,strong)UIButton *deleteFilmBtn;//删除视频
@property(nonatomic,strong)UIButton *sureFilmBtn;//保存视频
@property(nonatomic,strong)UIButton *previewBtn;
@property(nonatomic,strong)UIView *indexView;
@property(nonatomic,strong)JhtBannerView *bannerView;
@property(nonatomic,strong)CustomerAVPlayerView *AVPlayerView;
@property(nonatomic,strong)MovieCountDown *movieCountDown;
@property(nonatomic,strong)WGradientProgress *__block gradProg;
@property(nonatomic,strong)WGradientProgressView *progressView;

@property(nonatomic,assign)CGFloat safetyTime;//小于等于这个时间点的录制的视频不允许被保存，而是应该被遗弃
@property(nonatomic,assign)CGFloat __block time;
@property(nonatomic,strong)NSArray *timeArr;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,assign)BOOL isCameraCanBeUsed;//鉴权的结果 —— 摄像头是否可用？
@property(nonatomic,assign)BOOL isMicrophoneCanBeUsed;//鉴权的结果 —— 麦克风是否可用？
@property(nonatomic,assign)BOOL ispPhotoAlbumCanBeUsed;//鉴权的结果 —— 相册是否可用
@property(nonatomic,assign)BOOL __block isClickMyGPUImageView;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,copy)MKDataBlock MKShootVCBlock;

@end

@implementation MKShootVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MKShootVC *vc = MKShootVC.new;
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
        self.time = 60;// 最大可录制时间（秒），预设值
        self.safetyTime = 5;//小于等于这个时间点的录制的视频不允许被保存，而是应该被遗弃
        self.isCameraCanBeUsed = NO;
        self.isMicrophoneCanBeUsed = NO;
        self.ispPhotoAlbumCanBeUsed = NO;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:kIMG(@"MKShootVC")];
    
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.gk_navRightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.flashLightBtn],
                                       [[UIBarButtonItem alloc] initWithCustomView:self.overturnBtn],
                                       [[UIBarButtonItem alloc] initWithCustomView:self.countDownBtn]];
    self.gk_navTitle = @"";
    [self hideNavLine];
    
    [self.view addSubview:self.gpuImageTools.GPUImageView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //鉴权 开启摄像头、麦克风
    [self check];
    if (self.MKShootVCBlock) {
        self.MKShootVCBlock(@YES);
    }
    self.isClickMyGPUImageView = NO;
    self.gk_navigationBar.hidden = NO;
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.gpuImageTools LIVE];
    self.recordBtn.alpha = 1;
    self.gradProg.alpha = 1;
    self.progressView.alpha = 1;
    self.bannerView.alpha = 1;
    self.indexView.alpha = 1;
    [self.view bringSubviewToFront:self.gk_navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.MKShootVCBlock) {
        self.MKShootVCBlock(@NO);
    }
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}
#pragma mark —— 切换滤镜功能
-(void)changeFilter{
    TypeFilter typeFilter = [NSObject getRandomNumberFrom:filterGaussBlur
                                                       to:filterGif];
    self->_gpuImageTools.typeFilter = typeFilter;
}

//摄像头鉴权结果不利的UI状况
-(void)checkRes:(BOOL)result{
    result = !result;
    self.overturnBtn.hidden = result;
    self.deleteFilmBtn.hidden = result;
    self.previewBtn.alpha = result;
    self.sureFilmBtn.hidden = result;
    self.recordBtn.hidden = result;
    self.indexView.hidden = result;
}
///重新拍摄
-(void)reShoot{
    
}
///确认删除
-(void)sure{
    
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.previewBtn.alpha = 0;

    [self.recordBtn.progressView reset];
    [self.recordBtn reset];

    [MBProgressHUD wj_showPlainText:@"开始录制"
                               view:getMainWindow()];
    [self delTmpRes];
    
    [self.gradProg reset];
}

-(void)开始录制{
    [self.gpuImageTools vedioShoottingOn];
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.previewBtn.alpha = 0;
    [self.recordBtn vedioShoottingOn];
    [self.gradProg start];
}

-(void)继续录制{
    [self.gpuImageTools vedioShoottingContinue];
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.previewBtn.alpha = 0;
    [self.recordBtn vedioShoottingContinue];
    [self.gradProg resume];
}
///功能性的 删除tmp文件夹下的文件
-(void)delTmpRes{
    BOOL success = [FileFolderHandleTool removeItemAtPath:[FileFolderHandleTool directoryAtPath:self.gpuImageTools.FileUrlByTime]
                                                    error:nil];
    if (success) {
        NSLog(@"删除作品成功");
        [MBProgressHUD wj_showPlainText:@"删除作品成功"
                                   view:getMainWindow()];
    }
}
///继续录制
-(void)shoottingContinue{
    [self.recordBtn tapGRUI:YES];
    [self.gpuImageTools vedioShoottingContinue];
    
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.previewBtn.alpha = 0;
    [self.gradProg resume];
}

-(void)exit{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
    
    if (self.MKShootVCBlock) {
        self.MKShootVCBlock(NSStringFromSelector(_cmd));
    }
}
//鉴权
-(void)check{
    @weakify(self)
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Camera
                                          accessStatus:^id(ECAuthorizationStatus status,
                                                           ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            NSLog(@"已经开启摄像头权限");
            self.isCameraCanBeUsed = YES;
            return nil;
        }else{
            NSLog(@"摄像头不可用:%lu",(unsigned long)status);
            self.isCameraCanBeUsed = NO;
            [self checkRes:self.isCameraCanBeUsed];
            return nil;
        }
    }];

    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Microphone
                                          accessStatus:^id(ECAuthorizationStatus status,
                                                           ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            NSLog(@"已经开启麦克风权限");
            self.isMicrophoneCanBeUsed = YES;
            self.recordBtn.alpha = 1;
            return nil;
        }else{
            NSLog(@"麦克风不可用:%lu",(unsigned long)status);
            self.isMicrophoneCanBeUsed = NO;
            [self checkRes:self.isMicrophoneCanBeUsed];
            return nil;
        }
    }];
    
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Photos
                                          accessStatus:^id(ECAuthorizationStatus status,
                                                           ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            NSLog(@"系统相册可用");
            self.ispPhotoAlbumCanBeUsed = YES;
            return nil;
        }else{
            NSLog(@"系统相册不可用:%lu",(unsigned long)status);
            self.ispPhotoAlbumCanBeUsed = NO;
            return nil;
        }
    }];
}

-(void)ActionMKShootVCBlock:(MKDataBlock)MKShootVCBlock{
    self.MKShootVCBlock = MKShootVCBlock;
}
#pragma mark —— lazyLoad
-(StartOrPauseBtn *)recordBtn{
    if (!_recordBtn) {
        _recordBtn = StartOrPauseBtn.new;
        _recordBtn.backgroundColor = kBlueColor;
        _recordBtn.safetyTime = self.safetyTime;// 单个视频上传最大支持时长为5分钟，最低不得少于30秒
        _recordBtn.time = self.time;// 准备跑多少秒 —— 预设值。本类的init里面设置了是默认值5分钟
        [self.view addSubview:_recordBtn];
        [_recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(80), SCALING_RATIO(80)));
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-SCALING_RATIO(100));
        }];
        [_recordBtn layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_recordBtn
                          AndCornerRadius:SCALING_RATIO(80) / 2];
        @weakify(self)
        //点击手势回调
        [_recordBtn actionTapGRHandleSingleFingerBlock:^(id data) {
//            @strongify(self)
        }];
        //长按手势回调
//        [_recordBtn actionLongPressGRBlock:^(id data) {
//            @strongify(self)
//        }];
        //点击后的录制状态回调 是录制还是没录制
        [_recordBtn actionStartOrPauseBtnBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:StartOrPauseBtn.class]) {
                StartOrPauseBtn *btn = (StartOrPauseBtn *)data;
                switch (btn.shottingStatus) {
                    case ShottingStatus_on:{//开始录制
                        if (self.countDownBtn.selected) {
                            [self.movieCountDown 倒计时放大特效];
                        }else{
                            [self 开始录制];
                        }
                    }break;
                    case ShottingStatus_suspend:{//暂停录制
                        [self.gpuImageTools vedioShoottingSuspend];
                        self.deleteFilmBtn.alpha = 1;
                        self.sureFilmBtn.alpha = 1;
                        [self.gradProg pause];
                    }break;
                    case ShottingStatus_continue:{//继续录制
                        if (self.countDownBtn.selected) {
                            [self.movieCountDown 倒计时放大特效];
                        }else{
                            [self 继续录制];
                        }
                    }break;
    //                    case ShottingStatus_off:{//取消录制
    //                        [self.gpuImageTools vedioShoottingOff];
//                        [self.gradProg reset];
    //                    }break;
                    default:
                        break;
                }
            }
        }];
        [_recordBtn actionFinishWorkBlock:^(id data) {
            @strongify(self)
            [self.gpuImageTools vedioShoottingEnd];
        }];
    }return _recordBtn;
}

-(GPUImageTools *)gpuImageTools{
    if (!_gpuImageTools) {
        _gpuImageTools = GPUImageTools.new;
        @weakify(self)
        //点击事件
        [_gpuImageTools actionVedioToolsClickBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:MKGPUImageView.class]) {//鉴权部分
                  MKDataBlock block = ^(NSString *title){
                      NSLog(@"打开失败");
                      @strongify(self)
                      [self alertControllerStyle:SYS_AlertController
                              showAlertViewTitle:title
                                         message:nil
                                 isSeparateStyle:YES
                                     btnTitleArr:@[@"去获取"]
                                  alertBtnAction:@[@"pushToSysConfig"]
                                    alertVCBlock:^(id data) {
                          //DIY
                          NSLog(@"");
                      }];
                  };

                  if (self.isCameraCanBeUsed && //摄像头
                      self.isMicrophoneCanBeUsed &&//麦克风
                      self.ispPhotoAlbumCanBeUsed && //系统相册
                      self.deleteFilmBtn.alpha == 0 &&
                      self.sureFilmBtn.alpha == 0 &&
                      self.previewBtn.alpha == 0 &&
                      self.gpuImageTools.vedioShootType != VedioShootType_on &&
                      self.gpuImageTools.vedioShootType != VedioShootType_continue) {
                      self.isClickMyGPUImageView = !self.isClickMyGPUImageView;
                      //切换滤镜功能
                      [self changeFilter];
                  }else{
                      if (!self.isCameraCanBeUsed &&
                          self.isMicrophoneCanBeUsed &&
                          self.ispPhotoAlbumCanBeUsed) {
                          NSLog(@"仅仅只有摄像头不可用");
                          if (block) {
                              block(@"仅仅只有摄像头不可用");
                          }
                      }else if (self.isCameraCanBeUsed &&
                                self.ispPhotoAlbumCanBeUsed &&
                                !self.isMicrophoneCanBeUsed){
                          NSLog(@"仅仅只有麦克风不可用");
                          if (block) {
                              block(@"仅仅只有麦克风不可用");
                          }
                      }else if (self.isCameraCanBeUsed &&
                                !self.ispPhotoAlbumCanBeUsed &&
                                self.isMicrophoneCanBeUsed){
                          NSLog(@"仅仅只有系统相册不可用");
                          if (block) {
                              block(@"仅仅只有系统相册不可用");
                          }
                      }else if (!self.isCameraCanBeUsed &&
                                !self.ispPhotoAlbumCanBeUsed &&
                                self.isMicrophoneCanBeUsed){
                          NSLog(@"摄像头和系统相册不可用");
                          if (block) {
                              block(@"摄像头和系统相册不可用");
                          }
                      }else if (self.isCameraCanBeUsed &&
                                !self.ispPhotoAlbumCanBeUsed &&
                                !self.isMicrophoneCanBeUsed){
                          NSLog(@"系统相册和麦克风不可用");
                          if (block) {
                              block(@"系统相册和麦克风不可用");
                          }
                      }else if (!self.isCameraCanBeUsed &&
                                self.ispPhotoAlbumCanBeUsed &&
                                !self.isMicrophoneCanBeUsed){
                          NSLog(@"摄像头和麦克风不可用");
                          if (block) {
                              block(@"摄像头和麦克风不可用");
                          }
                      }else if (!self.isCameraCanBeUsed &&
                                !self.isMicrophoneCanBeUsed &&
                                !self.ispPhotoAlbumCanBeUsed){
                          NSLog(@"麦克风、摄像头、系统相册皆不可用");
                          if (block) {
                              block(@"麦克风、摄像头、系统相册皆不可用");
                          }
                      }else{
                          NSLog(@"");
                          //这里做动作
                      }
                  }
              }
        }];
        
        //视频合并处理结束
        [_gpuImageTools vedioToolsSessionStatusCompletedBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:GPUImageTools.class]) {
                {
//                    GPUImageTools *tools = (GPUImageTools *)data;
//                    tools.thumb;//缩略图
                    
                    // GPUImage 只能播放本地视频，不能处理网络流媒体url
        //            [CustomerGPUImagePlayerVC ComingFromVC:weak_self
        //                                       comingStyle:ComingStyle_PUSH
        //                                 presentationStyle:UIModalPresentationFullScreen
        //                                     requestParams:@{
        //                                         @"AVPlayerURL":[NSURL URLWithString:VedioTools.sharedInstance.recentlyVedioFileUrl]//fileURLWithPath
        //                                     }
        //                                           success:^(id data) {}
        //                                          animated:YES];
                    #pragma mark —— AVPlayer
        //            [CustomerAVPlayerVC ComingFromVC:weak_self
        //                                 comingStyle:ComingStyle_PUSH
        //                           presentationStyle:UIModalPresentationFullScreen
        //                               requestParams:@{
        //                                   @"AVPlayerURL":[NSURL fileURLWithPath:VedioTools.sharedInstance.recentlyVedioFileUrl]
        //                               }
        //                                     success:^(id data) {}
        //                                    animated:YES];
                    #pragma mark —— 悬浮窗AVPlayer
    //                self.AVPlayerView.alpha = 1;
                }
                if (self.MKShootVCBlock) {
                    self.MKShootVCBlock(NSStringFromSelector(_cmd));
                }
            }
        }];
    }return _gpuImageTools;
}

-(UIButton *)overturnBtn{
    if (!_overturnBtn) {
        _overturnBtn = UIButton.new;
        [_overturnBtn setImage:kIMG(@"翻转镜头")
                      forState:UIControlStateNormal];
        [[_overturnBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            x.selected = !x.selected;
            [self.gpuImageTools overturnCamera];
        }];
    }return _overturnBtn;
}

-(UIButton *)flashLightBtn{
    if (!_flashLightBtn) {
        _flashLightBtn = UIButton.new;
        [_flashLightBtn setImage:kIMG(@"闪光灯-关闭")
                      forState:UIControlStateNormal];
        [_flashLightBtn setImage:kIMG(@"闪光灯")
                      forState:UIControlStateSelected];
        [[_flashLightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            x.selected = !x.selected;
            [self.gpuImageTools flashLight:x.selected];
        }];
    }return _flashLightBtn;
}

-(UIButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = UIButton.new;
        [_countDownBtn setImage:kIMG(@"倒计时 关闭状态")
                       forState:UIControlStateNormal];
        [_countDownBtn setImage:kIMG(@"倒计时 开启状态")
                       forState:UIControlStateSelected];
        [[_countDownBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            x.selected = !x.selected;
            self.recordBtn.isCountDown = x.selected;
        }];
    }return _countDownBtn;
}

-(UIButton *)previewBtn{
    if (!_previewBtn) {
        _previewBtn = UIButton.new;
        _previewBtn.backgroundColor = kCyanColor;
        _previewBtn.alpha = 0;
        [_previewBtn setTitleColor:kRedColor
                          forState:UIControlStateNormal];
        [_previewBtn setTitle:@"预览"
                     forState:UIControlStateNormal];
        [[_previewBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            //值得注意：想要预览视频必须写文件。因为GPUImageMovieWriter在做合成动作之前，没有把音频流和视频流进行整合，碎片化的信息文件不能称之为一个完整的视频文件
            [self.gpuImageTools vedioShoottingEnd];
        }];
        [_previewBtn.titleLabel sizeToFit];
        _previewBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_previewBtn];
        [_previewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.recordBtn);
            make.right.equalTo(self.recordBtn.mas_left).offset(-SCALING_RATIO(10));
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(40), 30));
        }];
        [UIView cornerCutToCircleWithView:_previewBtn
                          AndCornerRadius:8.f];
    }return _previewBtn;
}

-(JhtBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[JhtBannerView alloc] initWithFrame:CGRectMake([NSObject measureSubview:SCREEN_WIDTH * 2 / 3 superview:SCREEN_WIDTH],
//                                                                      SCREEN_HEIGHT - SCALING_RATIO(98),
                                                                      self.gradProg.mj_y + self.gradProg.mj_h,
                                                                      SCREEN_WIDTH * 2 / 3,
                                                                      SCALING_RATIO(40))];
        
        _bannerView.JhtBannerCardViewSize = CGSizeMake(SCREEN_WIDTH * 2 / 9, SCALING_RATIO(40));
        [self.view addSubview:_bannerView];

        [_bannerView setDataArr:self.timeArr];//这个时候就设置了 UIPageControl
        _bannerView.bannerView.pageControl.hidden = YES;
        _bannerView.bannerView.isOpenAutoScroll = NO;
        
        [_bannerView.bannerView reloadData];
        
        @weakify(self)
        /** 滚动ScrollView内部卡片 */
        [_bannerView scrollViewIndex:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)data;
                NSString *str = self.timeArr[num.integerValue];
                self.time = (CGFloat)[NSString getDigitsFromStr:str] * 60;
                [self.recordBtn removeFromSuperview];
                self.recordBtn = nil;
                self.recordBtn.time = self.time;
                self.recordBtn.progressView.cycleTime = self.time;
                self.recordBtn.progressView.safetyTime = self.safetyTime;
                self.gradProg = nil;
                self.gradProg.alpha = 1;
//                self.gradProg.fenceLayer_x = self.safetyTime * SCREEN_WIDTH / self.time;
                NSLog(@"self.time = %f",self.time);
            }
        }];
        /** 点击ScrollView内部卡片 */
        [_bannerView clickScrollViewInsideCardView:^(id data) {
//            @strongify(self)
        }];
//
    }return _bannerView;
}

-(UIView *)indexView{
    if (!_indexView) {
        _indexView = UIView.new;
        _indexView.backgroundColor = kBlackColor;
        [self.view addSubview:_indexView];
        [_indexView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.bannerView.mas_bottom).offset(6);
        }];
        [UIView cornerCutToCircleWithView:_indexView AndCornerRadius:10/2];
    }return _indexView;
}

-(UIButton *)deleteFilmBtn{
    if (!_deleteFilmBtn) {
        _deleteFilmBtn = UIButton.new;
        _deleteFilmBtn.alpha = 0;
        [_deleteFilmBtn setImage:kIMG(@"删除视频")
                        forState:UIControlStateNormal];
        [[_deleteFilmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"删除作品？");
            [self.gpuImageTools vedioShoottingSuspend];
            [self alertControllerStyle:YX_AlertController
                    showAlertViewTitle:@"删除作品？"
                               message:nil
                       isSeparateStyle:NO
                           btnTitleArr:@[@"确认",@"继续录制"]
                        alertBtnAction:@[@"sure",@"shoottingContinue"]
                          alertVCBlock:^(id data) {
                if ([data isKindOfClass:YXAlertController.class]) {
                    YXAlertController *yxAlertController = (YXAlertController *)data;
                    yxAlertController.layout.doneActionTitleColor = COLOR_HEX(0x1F242F, 0.8);
                    yxAlertController.layout.cancelActionBackgroundColor = COLOR_HEX(0x1F242F, 0.8);
                    yxAlertController.layout.doneActionBackgroundColor = COLOR_HEX(0x1F242F, 0.8);
                    yxAlertController.layout.lineColor = COLOR_HEX(0x1F242F, 0.8);
                    yxAlertController.layout.messageFont = [UIFont systemFontOfSize:14
                                                                             weight:UIFontWeightMedium];
                    yxAlertController.layout.cancelActionTitleFont = [UIFont systemFontOfSize:14
                                                                                       weight:UIFontWeightRegular];
                    yxAlertController.layout.doneActionTitleFont = [UIFont systemFontOfSize:14
                                                                                     weight:UIFontWeightRegular];
                    yxAlertController.layout.topViewBackgroundColor = COLOR_HEX(0x1F242F, 0.8);
                    yxAlertController.layout.titleColor = kWhiteColor;
                    [yxAlertController layoutSettings];
                }
            }];
        }];
        [self.view addSubview:_deleteFilmBtn];
        [_deleteFilmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.recordBtn);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(36), SCALING_RATIO(36)));
            make.right.equalTo(self.recordBtn.mas_left).offset(SCALING_RATIO(-32));
        }];
    }return _deleteFilmBtn;
}

-(UIButton *)sureFilmBtn{
    if (!_sureFilmBtn) {
        _sureFilmBtn = UIButton.new;
        _sureFilmBtn.alpha = 0;
        [_sureFilmBtn setImage:kIMG(@"保存视频")
                        forState:UIControlStateNormal];
        [[_sureFilmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"结束录制 —— 这个作品我要了");
            //判定规则：小于3秒的被遗弃，不允许被保存
            if (self.recordBtn.currentTime <= self.recordBtn.safetyTime) {
                [MBProgressHUD wj_showPlainText:[NSString stringWithFormat:@"不能保存录制时间低于%.2f秒的视频",self.recordBtn.safetyTime]
                                           view:getMainWindow()];
            }else{
                [self.gpuImageTools vedioShoottingEnd];
                [self.recordBtn reset];
            }
            
            self.deleteFilmBtn.alpha = 0;
            self.sureFilmBtn.alpha = 0;
            self.indexView.alpha = 1;
            self.previewBtn.alpha = 0;
        }];
        [self.view addSubview:_sureFilmBtn];
        [_sureFilmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.recordBtn);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(36), SCALING_RATIO(36)));
            make.left.equalTo(self.recordBtn.mas_right).offset(SCALING_RATIO(32));
        }];
    }return _sureFilmBtn;
}

-(CGFloat)time{
    if (_time == 0.0f) {
        _time = 60 * 3;//默认值 3分钟
    }return _time;
}

-(NSArray *)timeArr{
    if (!_timeArr) {
        _timeArr = @[@"拍摄 1 分钟",
                     @"拍摄 3 分钟",
                     @"拍摄 5 分钟",
                     @"拍摄 7 分钟",
                     @"拍摄 10 分钟"
        ];
    }return _timeArr;
}

-(CustomerAVPlayerView *)AVPlayerView{
    if (!_AVPlayerView) {
        @weakify(self)
        if (![NSString isNullString:self.gpuImageTools.compressedVedioPathStr]) {
            _AVPlayerView = [[CustomerAVPlayerView alloc] initWithURL:[NSURL fileURLWithPath:self.gpuImageTools.compressedVedioPathStr]
                                                            suspendVC:weak_self];
            _AVPlayerView.isSuspend = YES;//开启悬浮窗效果
            [_AVPlayerView errorCustomerAVPlayerBlock:^{
                @strongify(self)
                [self alertControllerStyle:SYS_AlertController
                        showAlertViewTitle:@"软件内部错误"
                                   message:@"因为某种未知的原因，找不到播放的资源文件"
                           isSeparateStyle:NO
                               btnTitleArr:@[@"确定"]
                            alertBtnAction:@[@"OK"]
                              alertVCBlock:^(id data) {
                    //DIY
                    NSLog(@"");
                }];
            }];
            
            ///点击事件回调 参数1：self CustomerAVPlayerView，参数2：手势 UITapGestureRecognizer & UISwipeGestureRecognizer
            [_AVPlayerView actionCustomerAVPlayerBlock:^(id data,
                                                         id data2) {
                @strongify(self)
                if ([data2 isKindOfClass:UITapGestureRecognizer.class]) {
                    NSLog(@"你点击了我");
                }else if ([data2 isKindOfClass:UISwipeGestureRecognizer.class]){
                    if ([data isKindOfClass:CustomerAVPlayerView.class]) {
                        CustomerAVPlayerView *view = (CustomerAVPlayerView *)data;
                        if ([view.vc isEqual:self]) {
                            if (self.navigationController) {
                                [self.navigationController popViewControllerAnimated:YES];
                            }else{
                                [self dismissViewControllerAnimated:YES
                                                         completion:^{
                                    
                                }];
                            }
                        }
                    }
                }else{}
            }];
            [self.view addSubview:_AVPlayerView];
            [self.view.layer addSublayer:_AVPlayerView.playerLayer];
            [_AVPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(SCALING_RATIO(50));
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2));
                if (self.gk_navigationBar.hidden) {
                    make.top.equalTo(self.view);
                }else{
                    make.top.equalTo(self.gk_navigationBar.mas_bottom);
                }
            }];
        }else{
            NSLog(@"文件资源查找失败,播放终止");
            _AVPlayerView = nil;
        }
    }return _AVPlayerView;
}

-(MovieCountDown *)movieCountDown{
    if (!_movieCountDown) {
        _movieCountDown = MovieCountDown.new;
        _movieCountDown.countDownTextColor = kBlueColor;
        _movieCountDown.aphViewBackgroundColor = KLightGrayColor;
        _movieCountDown.effectView = self.view;
        @weakify(self)
        [_movieCountDown actionMovieCountDownFinishBlock:^(id data) {
            @strongify(self)
            NSLog(@"我死球了");
            [self 开始录制];
        }];
    }return _movieCountDown;
}

-(WGradientProgress *)gradProg{
    if (!_gradProg) {
        _gradProg = WGradientProgress.new;
        _gradProg.isShowRoad = YES;
        _gradProg.isShowFence = YES;
        _gradProg.length_timeInterval = 1;
        _gradProg.fenceLayerColor = kWhiteColor;
        _gradProg.increment = 1 / self.time;
        _gradProg.fenceLayer_x = self.safetyTime * SCREEN_WIDTH / self.time;
        
//        @weakify(self)
        [_gradProg actionWGradientProgressBlock:^(NSNumber *data,
                                                  CAGradientLayer *data2) {
//            @strongify(self)
//            NSLog(@"");
        }];
        
        [self.view addSubview:_gradProg];
        [_gradProg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(5);
            make.top.equalTo(self.recordBtn.mas_bottom).offset(10);
        }];
        [self.view layoutIfNeeded];
        [_gradProg showOnParent];
    }return _gradProg;
}

-(WGradientProgressView *)progressView{
    if (!_progressView) {
        _progressView = WGradientProgressView.new;
        _progressView.titleStr = @"30s";
        _progressView.titleFont = [UIFont systemFontOfSize:6.4
                                                   weight:UIFontWeightRegular];
        [self.view addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.bottom.equalTo(self.gradProg.mas_top);
            make.left.mas_equalTo(self.safetyTime * SCREEN_WIDTH / self.time - 25 / 2);
        }];
    }return _progressView;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = UIButton.new;
        [_backBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                  imageTitleSpace:8];
        [_backBtn setTitleColor:kWhiteColor
                       forState:UIControlStateNormal];
        [_backBtn setTitle:@"返回"
                  forState:UIControlStateNormal];
        [_backBtn setImage:kIMG(@"back_white")
                         forState:UIControlStateNormal];
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self alertControllerStyle:SYS_AlertController
                  showActionSheetTitle:nil
                               message:nil
                       isSeparateStyle:YES
                           btnTitleArr:@[@"重新拍摄",@"退出",@"取消"]
                        alertBtnAction:@[@"reShoot",@"exit",@"reShoot"]
                                sender:nil
                          alertVCBlock:^(id data) {
                //DIY
                NSLog(@"");
            }];
        }];
    }return _backBtn;
}


@end
