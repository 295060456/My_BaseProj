//
//  MKShootVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKShootVC.h"
#import "MKShootVC+VM.h"

#import "StartOrPauseBtn.h"
#import "MyCell.h"
#import "VedioTools.h"//视频处理类
#import "CustomerGPUImagePlayerVC.h"//视频预览 VC

#import "YHGPUImageBeautifyFilter.h"
#import "GPUImageVideoCamera.h"
#import "MKGPUImageView.h"
#import "GPUImage.h"

@interface MKShootVC ()
#pragma mark —— UI
@property(nonatomic,strong)UIButton *overturnBtn;//镜头翻转
@property(nonatomic,strong)UIButton *flashLightBtn;//闪光灯
@property(nonatomic,strong)UIButton *deleteFilmBtn;//删除视频
@property(nonatomic,strong)UIButton *sureFilmBtn;//保存视频
@property(nonatomic,strong)UIButton *previewBtn;
@property(nonatomic,strong)__block StartOrPauseBtn *recordBtn;//开始录制
@property(nonatomic,strong)UIView *indexView;
@property(nonatomic,strong)JhtBannerView *bannerView;
@property(nonatomic,strong)CustomerAVPlayerView *AVPlayerView;
@property(nonatomic,strong)AVCaptureDevice *captureDevice;

@property(nonatomic,assign)CGFloat __block time;
@property(nonatomic,assign)BOOL __block isClickMyGPUImageView;
@property(nonatomic,copy)MKDataBlock MKShootVCBlock;

@property(nonatomic,assign)BOOL isCameraCanBeUsed;//鉴权的结果 —— 摄像头是否可用？
@property(nonatomic,assign)BOOL isMicrophoneCanBeUsed;//鉴权的结果 —— 麦克风是否可用？
@property(nonatomic,assign)BOOL ispPhotoAlbumCanBeUsed;//鉴权的结果 —— 相册是否可用
@property(nonatomic,assign)CGFloat safetyTime;//小于等于这个时间点的录制的视频不允许被保存，而是应该被遗弃
@property(nonatomic,strong)NSArray *timeArr;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

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
        self.isCameraCanBeUsed = NO;
        self.isMicrophoneCanBeUsed = NO;
        self.ispPhotoAlbumCanBeUsed = NO;
        self.safetyTime = 30;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:kIMG(@"MKShootVC")];

    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
//    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.overturnBtn];
    self.gk_navRightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.flashLightBtn],
                                       [[UIBarButtonItem alloc] initWithCustomView:self.overturnBtn]];
    
    self.gk_navTitle = @"";
    [self hideNavLine];
    
    //视频管理工具类
    [self MakeVedioTools];

    //如果没有开系统权限 是黑屏 所以不用放在鉴权的block里面，放进去了反而第一次进去的时候会黑屏，第二次进去ok
    [self LIVE];
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
    [VedioTools.sharedInstance.myGPUVideoCamera startCameraCapture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.MKShootVCBlock) {
        self.MKShootVCBlock(@NO);
    }
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;

    //后续要加上去的补充功能
//    self.overturnBtn.alpha = 0;
//    self.deleteFilmBtn.alpha = 0;
//    self.sureFilmBtn.alpha = 0;
//    self.recordBtn.alpha = 0;
//    self.bannerView.alpha = 0;
//    self.indexView.alpha = 0;
}
//
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
//实况视频
-(void)LIVE{
//    [VedioTools.sharedInstance LIVE];
    
    self.recordBtn.alpha = 1;
    self.bannerView.alpha = 1;
    self.indexView.alpha = 1;
    
    [self.view bringSubviewToFront:self.gk_navigationBar];
}

-(void)MakeVedioTools{
    [self.view addSubview:VedioTools.sharedInstance.myGPUImageView];
    @weakify(self)
    [VedioTools.sharedInstance actionVedioToolsClickBlock:^(id data) {
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
                  }];
              };

              if (self.isCameraCanBeUsed &&
                  self.isMicrophoneCanBeUsed &&
                  self.deleteFilmBtn.alpha == 0 &&
                  self.sureFilmBtn.alpha == 0 &&
                  self.previewBtn.alpha == 0 &&
                  VedioTools.sharedInstance.vedioShootType != VedioShootType_on &&
                  VedioTools.sharedInstance.vedioShootType != VedioShootType_continue) {
                  self.isClickMyGPUImageView = !self.isClickMyGPUImageView;
                  [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = !self.isClickMyGPUImageView;

                  self.gk_navigationBar.hidden = self.isClickMyGPUImageView;
                  self.recordBtn.alpha = !self.isClickMyGPUImageView;
                  self.deleteFilmBtn.alpha = !self.isClickMyGPUImageView;
                  self.previewBtn.alpha = !self.isClickMyGPUImageView;
              }else{
                  if (!self.isCameraCanBeUsed &&
                      self.isMicrophoneCanBeUsed) {
                      NSLog(@"仅仅只有摄像头不可用");
                      if (block) {
                          block(@"仅仅只有摄像头不可用");
                      }
                  }else if (self.isCameraCanBeUsed &&
                            !self.isMicrophoneCanBeUsed){
                      NSLog(@"仅仅只有麦克风不可用");
                      if (block) {
                          block(@"仅仅只有麦克风不可用");
                      }
                  }else if (!self.isCameraCanBeUsed &&
                            !self.isMicrophoneCanBeUsed){
                      NSLog(@"麦克风 和 摄像头 皆不可用");
                      if (block) {
                          block(@"麦克风 和 摄像头 皆不可用");
                      }
                  }else{
                      NSLog(@"");
                      //这里做动作
                  }
              }
          }
    }];
    
    [VedioTools.sharedInstance vedioToolsSessionStatusCompletedBlock:^(id data) {
//        @strongify(self)
//处理完毕的回调
//视频处理完毕后，你想干嘛？！
        if ([data isKindOfClass:VedioTools.class]) {
            
        }
    }];
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
#pragma mark —— 开始录制
-(void)shootting_on{
    NSLog(@"开始录制");
    self.gk_navigationBar.hidden = YES;
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.indexView.alpha = 0;
    self.previewBtn.alpha = 0;
//创建本地缓存的文件夹，位置于沙盒中tmp
//给定一个路径 self.FileByUrl 需要他的父节点
    if ([FileFolderHandleTool isExistsAtPath:[FileFolderHandleTool directoryAtPath:VedioTools.sharedInstance.FileUrlByTime]]) {//存在则清除旗下所有的东西
        //先清除缓存
        [FileFolderHandleTool cleanFilesWithPath:[FileFolderHandleTool directoryAtPath:VedioTools.sharedInstance.FileUrlByTime]];
    }else{//不存在即创建
        ///创建文件夹：
        [FileFolderHandleTool createDirectoryAtPath:VedioTools.sharedInstance.FileUrlByTime
                                              error:nil];
    }
//准备工作已完成，现在开始进数据流
    [VedioTools.sharedInstance vedioShoottingOn];
}
#pragma mark —— 结束录制
-(void)shootting_end{
    NSLog(@"结束录制");
    @weakify(self)
    [VedioTools.sharedInstance vedioShoottingEnd];//包含合成视频
    //对相册进行鉴权操作
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Photos
                                              accessStatus:^id(ECAuthorizationStatus status,
                                                               ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            NSLog(@"已经开启相册权限");
            self.ispPhotoAlbumCanBeUsed = YES;
//创建本App的独属相册
            //在个人相册里面创建一个以本App名字的相册 视频文件以时间戳名命名
            [FileFolderHandleTool createAlbumFolder:HDAppDisplayName
                                  ifExitFolderBlock:^(id data) {
                //已经存在这个文件夹
                //保存tmp文件夹下的视频文件到系统相册
                [FileFolderHandleTool saveRes:[NSURL URLWithString:VedioTools.sharedInstance.recentlyVedioFileUrl]];
            }
                                  completionHandler:^(id data,//success ? fail
                                                      id data2) {// error
                if ([data isKindOfClass:NSNumber.class]) {
                    NSNumber *num = (NSNumber *)data;
                    if (num.boolValue) {//success
                        //保存tmp文件夹下的视频文件到系统相册
                        [FileFolderHandleTool saveRes:[NSURL URLWithString:VedioTools.sharedInstance.recentlyVedioFileUrl]];
                    }else{//fail
                        if ([data2 isKindOfClass:NSError.class]) {
                            NSError *err = (NSError *)data2;
                            NSLog(@"err = %@",err);
                        }
                    }
                }
            }];
            return nil;
        }else{
            NSLog(@"相册不可用:%lu",(unsigned long)status);
            [self alertControllerStyle:SYS_AlertController
                    showAlertViewTitle:@"获取系统相册权限"
                               message:nil
                       isSeparateStyle:YES
                           btnTitleArr:@[@"去获取"]
                        alertBtnAction:@[@"pushToSysConfig"]
                          alertVCBlock:^(id data) {
                //DIY
            }];
            return nil;
        }
    }];
}
#pragma mark —— 暂停录制
-(void)shootting_suspend{
    NSLog(@"暂停录制");
    self.gk_navigationBar.hidden = NO;
    self.deleteFilmBtn.alpha = 1;
    self.sureFilmBtn.alpha = 1;
    self.indexView.alpha = 0;
    self.previewBtn.alpha = 1;

    [VedioTools.sharedInstance vedioShoottingSuspend];
}
#pragma mark —— 继续录制
-(void)shootting_continue{
    NSLog(@"继续录制");
    self.gk_navigationBar.hidden = YES;
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.indexView.alpha = 0;
    self.previewBtn.alpha = 0;
    
    [VedioTools.sharedInstance vedioShoottingContinue];
}
#pragma mark —— 取消录制
-(void)shootting_off{
    NSLog(@"取消录制");
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.indexView.alpha = 1;
    self.previewBtn.alpha = 0;
    
    [VedioTools.sharedInstance vedioShoottingOff];
}

-(void)ActionMKShootVCBlock:(MKDataBlock)MKShootVCBlock{
    self.MKShootVCBlock = MKShootVCBlock;
}

-(void)reShoot{}

-(void)sure{
    NSLog(@"删除作品成功");
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.previewBtn.alpha = 0;
#warning 没干完的
    //StartOrPauseBtn 归零
//    self.recordBtn.progressLabel.text = @"开始";
    self.recordBtn.backgroundColor = kBlueColor;
    [self.recordBtn.mytimer invalidate];
    ///功能性的 删除tmp文件夹下的文件
    [FileFolderHandleTool cleanFilesWithPath:[FileFolderHandleTool directoryAtPath:VedioTools.sharedInstance.FileUrlByTime]];
}

-(void)Cancel{}

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
#pragma mark —— 点击事件
-(void)previewBtnClickEvent:(UIButton *)sender{
    //值得注意：想要预览视频必须写文件。因为GPUImageMovieWriter在做合成动作之前，没有把音频流和视频流进行整合，碎片化的信息文件不能称之为一个完整的视频文件
    [VedioTools.sharedInstance vedioShoottingEnd];
    @weakify(self)
    [VedioTools.sharedInstance vedioToolsSessionStatusCompletedBlock:^(id data) {
        //        @strongify(self)
        if ([data isKindOfClass:VedioTools.class]) {
            #pragma mark —— GPUImage
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
            [CustomerAVPlayerVC ComingFromVC:self_weak_
                                 comingStyle:ComingStyle_PUSH
                           presentationStyle:UIModalPresentationFullScreen
                               requestParams:@{
                                   @"AVPlayerURL":[NSURL fileURLWithPath:VedioTools.sharedInstance.recentlyVedioFileUrl]
                               }
                                     success:^(id data) {}
                                    animated:YES];
            #pragma mark —— 悬浮窗AVPlayer
//            self.AVPlayerView.alpha = 1;
        }
    }];
}

-(void)sureFilmBtnClickEvent:(UIButton *)sender{
    NSLog(@"结束录制 —— 这个作品我要了");
    //判定规则：小于3秒的被遗弃，不允许被保存
    if (self.recordBtn.currentTime <= self.recordBtn.safetyTime) {
        [MBProgressHUD wj_showPlainText:[NSString stringWithFormat:@"不能保存录制时间低于%.2f秒的视频",self.recordBtn.safetyTime]
                                   view:self.view];
    }else{
        [self shootting_end];
    }
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.indexView.alpha = 1;
    self.previewBtn.alpha = 0;
}

-(void)deleteFilmBtnClickEvent:(UIButton *)sender{
    NSLog(@"删除作品？");
    [self alertControllerStyle:SYS_AlertController
            showAlertViewTitle:@"删除作品？"
                       message:nil
               isSeparateStyle:NO
                   btnTitleArr:@[@"确认",@"取消"]
                alertBtnAction:@[@"sure",@"Cancel"]
                  alertVCBlock:^(id data) {
        //DIY
    }];
}

-(void)backBtnClickEvent:(UIButton *)sender{
    [self alertControllerStyle:SYS_AlertController
          showActionSheetTitle:nil
                       message:nil
               isSeparateStyle:YES
                   btnTitleArr:@[@"重新拍摄",@"退出",@"取消"]
                alertBtnAction:@[@"reShoot",@"exit",@"reShoot"]
                        sender:nil
                  alertVCBlock:^(id data) {
        //DIY
    }];
}
//翻转摄像头
-(void)overturnBtnClickEvent:(UIButton *)sender{
    [VedioTools.sharedInstance overturnCamera];
}
//开启闪光灯
-(void)flashLightBtnClickEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        if (self.captureDevice.hasTorch) {
            if ([self.captureDevice lockForConfiguration:nil]) {
                self.captureDevice.torchMode = AVCaptureTorchModeOn;
                [self.captureDevice unlockForConfiguration];
            }
        }
    }else{
        if (self.captureDevice.hasTorch) {
            [self.captureDevice lockForConfiguration:nil];
            [self.captureDevice setTorchMode: AVCaptureTorchModeOff];
            [self.captureDevice unlockForConfiguration];
        }
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
            [self LIVE];
            return nil;
        }else{
            NSLog(@"摄像头不可用:%lu",(unsigned long)status);
            self.isCameraCanBeUsed = NO;
            [self checkRes:self.isCameraCanBeUsed];
            if (VedioTools.sharedInstance.actionVedioToolsClickBlock) {
                VedioTools.sharedInstance.actionVedioToolsClickBlock(VedioTools.sharedInstance.myGPUImageView);
            }
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
            return nil;
        }else{
            NSLog(@"麦克风不可用:%lu",(unsigned long)status);
            self.isMicrophoneCanBeUsed = NO;
            [self checkRes:self.isMicrophoneCanBeUsed];
            if (VedioTools.sharedInstance.actionVedioToolsClickBlock) {
                VedioTools.sharedInstance.actionVedioToolsClickBlock(VedioTools.sharedInstance.myGPUImageView);
            }
            return nil;
        }
    }];
}
#pragma mark —— lazyLoad
-(UIButton *)overturnBtn{
    if (!_overturnBtn) {
        _overturnBtn = UIButton.new;
        [_overturnBtn setImage:kIMG(@"翻转镜头")
                      forState:UIControlStateNormal];
        [_overturnBtn addTarget:self
                         action:@selector(overturnBtnClickEvent:)
               forControlEvents:UIControlEventTouchUpInside];
    }return _overturnBtn;
}

-(UIButton *)flashLightBtn{
    if (!_flashLightBtn) {
        _flashLightBtn = UIButton.new;
        [_flashLightBtn setImage:kIMG(@"闪光灯-关闭")
                      forState:UIControlStateNormal];
        [_flashLightBtn setImage:kIMG(@"闪光灯")
                      forState:UIControlStateSelected];
        [_flashLightBtn addTarget:self
                         action:@selector(flashLightBtnClickEvent:)
               forControlEvents:UIControlEventTouchUpInside];
    }return _flashLightBtn;
}

-(UIButton *)previewBtn{
    if (!_previewBtn) {
        _previewBtn = UIButton.new;
        _previewBtn.backgroundColor = kCyanColor;
        [_previewBtn setTitleColor:kRedColor
                          forState:UIControlStateNormal];
        [_previewBtn setTitle:@"预览"
                     forState:UIControlStateNormal];
        [_previewBtn addTarget:self
                        action:@selector(previewBtnClickEvent:)
              forControlEvents:UIControlEventTouchUpInside];
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
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)data;
                switch (num.intValue) {
                    case ShottingStatus_on:{//开始录制
                        [self shootting_on];
                    }break;
                    case ShottingStatus_suspend:{//暂停录制
                        [self shootting_suspend];
                    }break;
                    case ShottingStatus_continue:{//继续录制
                        [self shootting_continue];
                    }break;
                    case ShottingStatus_off:{//取消录制
                        [self shootting_off];
                    }break;
                        
                    default:
                        break;
                }
            }
        }];
    }return _recordBtn;
}

-(JhtBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[JhtBannerView alloc] initWithFrame:CGRectMake([NSObject measureSubview:SCREEN_WIDTH * 2 / 3 superview:SCREEN_WIDTH],
                                                                      SCREEN_HEIGHT - SCALING_RATIO(98),
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
                self.recordBtn.time = self.time;
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
        [_deleteFilmBtn setImage:kIMG(@"删除")
                        forState:UIControlStateNormal];
        [_deleteFilmBtn addTarget:self
                           action:@selector(deleteFilmBtnClickEvent:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_deleteFilmBtn];
        [_deleteFilmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.recordBtn);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(30), SCALING_RATIO(20)));
            make.left.equalTo(self.recordBtn.mas_right).offset(SCALING_RATIO(10));
        }];
    }return _deleteFilmBtn;
}

-(UIButton *)sureFilmBtn{
    if (!_sureFilmBtn) {
        _sureFilmBtn = UIButton.new;
        _sureFilmBtn.alpha = 0;
        [_sureFilmBtn setImage:kIMG(@"sure")
                        forState:UIControlStateNormal];
        [_sureFilmBtn addTarget:self
                           action:@selector(sureFilmBtnClickEvent:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_sureFilmBtn];
        [_sureFilmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.recordBtn);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(30), SCALING_RATIO(20)));
            make.left.equalTo(self.deleteFilmBtn.mas_right).offset(SCALING_RATIO(10));
        }];
    }return _sureFilmBtn;
}

-(CGFloat)time{
    if (_time == 0.0f) {
        _time = 60 * 3;//默认值 3分钟
    }return _time;
}

- (NSArray *)getData{
    return @[
      @{@"name":@"拍 3 分钟",
        @"time":@"180"},
      @{@"name":@"拍 5 分钟",
        @"time":@"300"},
      @{@"name":@"拍 1 分钟",
        @"time":@"60"}
      ];
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
        _AVPlayerView = [[CustomerAVPlayerView alloc] initWithURL:[NSURL fileURLWithPath:VedioTools.sharedInstance.recentlyVedioFileUrl]
                                                        suspendVC:self_weak_];
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
    }return _AVPlayerView;
}

-(AVCaptureDevice *)captureDevice{
    if (!_captureDevice) {
        _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }return _captureDevice;
}
    

@end
