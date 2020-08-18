//
//  VedioTools.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "VedioTools.h"

@interface VedioTools ()<GPUImageVideoCameraDelegate>

@property(nonatomic,strong)AVMutableComposition *mixComposition;
@property(nonatomic,strong)AVMutableCompositionTrack *audioTrack;
@property(nonatomic,strong)AVMutableCompositionTrack *videoTrack;
@property(nonatomic,strong)AVMutableVideoComposition *videoComp;
@property(nonatomic,strong)AVMutableVideoCompositionInstruction *instruction;
@property(nonatomic,strong)AVAssetTrack *mixVideoTrack;
@property(nonatomic,strong)AVMutableVideoCompositionLayerInstruction *layerInstruction;
@property(nonatomic,strong)AVAssetExportSession *exporter;//视频导出工具
@property(nonatomic,strong)NSURL *mergeFileURL;//这个是干嘛的？

@end

@implementation VedioTools

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

static VedioTools *vedioTools = nil;
+(VedioTools *)sharedInstance{
    @synchronized(self){
        if (!vedioTools) {
            vedioTools = VedioTools.new;
        }
    }return vedioTools;
}

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)actionVedioToolsBlock:(MKDataBlock)VedioToolsBlock{
    self.VedioToolsBlock = VedioToolsBlock;
}
///翻转摄像头
-(void)overturnCamera{
    switch (self.position) {
        case CameraManagerDevicePositionBack: {
            if (self.myGPUVideoCamera.cameraPosition == AVCaptureDevicePositionBack) {
                [self.myGPUVideoCamera pauseCameraCapture];
                self.position = CameraManagerDevicePositionFront;
                [self.myGPUVideoCamera rotateCamera];
                [self.myGPUVideoCamera resumeCameraCapture];
            }
        }
            break;
        case CameraManagerDevicePositionFront: {
            if (self.myGPUVideoCamera.cameraPosition == AVCaptureDevicePositionFront) {
                [self.myGPUVideoCamera pauseCameraCapture];
                self.position = CameraManagerDevicePositionBack;
                [self.myGPUVideoCamera rotateCamera];
                [self.myGPUVideoCamera resumeCameraCapture];
            }
        }
            break;
        default:
            break;
    }
    
    if ([self.myGPUVideoCamera.inputCamera lockForConfiguration:nil] &&
        [self.myGPUVideoCamera.inputCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
        [self.myGPUVideoCamera.inputCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
        [self.myGPUVideoCamera.inputCamera unlockForConfiguration];
    }
}
#pragma mark —— GPUImageVideoCameraDelegate
//实时每一帧的截取 滚动发出
- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer{
//    NSLog(@"");
}
#pragma mark —— 开始录制
-(void)vedioShoottingOn{
    self.vedioShootType = VedioShootType_on;
    self.myGPUVideoCamera.audioEncodingTarget = self.movieWriter;
    [self.movieWriter startRecording];
}
#pragma mark —— 结束录制
-(void)vedioShoottingEnd{
    self.vedioShootType = VedioShootType_end;
    [self.movieWriter finishRecording];
    self.myGPUVideoCamera.audioEncodingTarget = nil;
    [self.urlArray addObject:[NSURL URLWithString:self.FileByUrl]];
    _FileByUrl = nil;//只要一暂停录制，就需要置空，因为是时间戳路径，需要懒加载获取到最新
    
    // 合成
    [MBProgressHUD wj_showPlainText:@"视频合成中......" view:getMainWindow()];
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        @strongify(self)
        VedioTools.sharedInstance.videoSize = VedioTools.sharedInstance.movieWriterSize;
        [VedioTools.sharedInstance mergeAndExportVideos:self.urlArray
                                            withOutPath:[FileFolderHandleTool.tmpDir stringByAppendingString:@"Temp"]];
        //缩略图 ?? 有问题
//        NSString *imgPath = [[FileFolderHandleTool directoryAtPath:self.FileByUrl] stringByAppendingString:@"img"];
//        [VedioTools.sharedInstance getImage:imgPath];
    });
}
#pragma mark —— 暂停录制
-(void)vedioShoottingSuspend{
    self.vedioShootType = VedioShootType_suspend;
    [self.movieWriter finishRecording];
    self.myGPUVideoCamera.audioEncodingTarget = nil;
    [self.urlArray addObject:[NSURL URLWithString:self.FileByUrl]];
    _FileByUrl = nil;//只要一暂停录制，就需要置空，因为是时间戳路径，需要懒加载获取到最新
    _movieWriter = nil;
    NSLog(@"vedioShoottingSuspend");
}
#pragma mark —— 继续录制
-(void)vedioShoottingContinue{
    self.vedioShootType = VedioShootType_continue;
    self.FileByUrl = [FileFolderHandleTool cacheURL:@"mp4"];
    self.myGPUVideoCamera.audioEncodingTarget = self.movieWriter;
    [self.movieWriter startRecording];
}
#pragma mark —— 取消录制
-(void)vedioShoottingOff{
    self.vedioShootType = VedioShootType_off;
    [self.movieWriter finishRecording];
    self.myGPUVideoCamera.audioEncodingTarget = nil;
    _FileByUrl = nil;//只要一暂停录制，就需要置空，因为是时间戳路径，需要懒加载获取到最新
    _movieWriter = nil;
}
///视频合并
-(void)mergeAndExportVideos:(NSArray *)videosPathArray
                withOutPath:(NSString *)outpath{
    if (videosPathArray.count == 0) {
        [MBProgressHUD wj_showPlainText:@"没有可处理视频文件！"
                                   view:getMainWindow()];
        return;
    }
    //创建音频通道容器
    self.audioTrack.enabled = YES;
    //创建视频通道容器
    self.videoTrack.enabled = YES;
    
    CMTime totalDuration = kCMTimeZero;
    for (int i = 0; i < videosPathArray.count; i++) {
        //        AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL URLWithString:videosPathArray[i]]];
        NSDictionary* options = @{AVURLAssetPreferPreciseDurationAndTimingKey:@YES};
        AVAsset* asset = [AVURLAsset URLAssetWithURL:videosPathArray[i] options:options];
        
        NSError *erroraudio = nil;
        //获取AVAsset中的音频 或者视频
        AVAssetTrack *assetAudioTrack = [[asset tracksWithMediaType:AVMediaTypeAudio] firstObject];
        //向通道内加入音频或者视频
        BOOL ba = [self.audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                                      ofTrack:assetAudioTrack
                                       atTime:totalDuration
                                        error:&erroraudio];
        
        NSLog(@"erroraudio:%@%d",erroraudio,ba);
        NSError *errorVideo = nil;
        AVAssetTrack *assetVideoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo]firstObject];
        BOOL bl = [self.videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                                      ofTrack:assetVideoTrack
                                       atTime:totalDuration
                                        error:&errorVideo];
        
        NSLog(@"errorVideo:%@%d",errorVideo,bl);
        totalDuration = CMTimeAdd(totalDuration, asset.duration);
    }
    self.mergeFileURL = [NSURL fileURLWithPath:outpath];

    @weakify(self)
    [self.exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD wj_showPlainText:@"处理完毕...."
                                       view:getMainWindow()];
            @strongify(self)
            switch (self.exporter.status) {
                case AVAssetExportSessionStatusFailed:{
                    NSLog(@"Export failed: %@", [[self.exporter error] localizedDescription]);
                } break;
                case AVAssetExportSessionStatusCancelled:{
                    NSLog(@"Export canceled");
                } break;
                case AVAssetExportSessionStatusCompleted:{
                    NSLog(@"转换成功");
                    //  处理完毕的回调
                    if (self.VedioToolsBlock) {
                        self.VedioToolsBlock(self);
                    }
                } break;
                default:
                    break;
            }
        });
    }];
}
///开启实况视频
-(void)LIVE{
    [self.myGPUVideoCamera addTarget:VedioTools.sharedInstance.myGPUImageView];
    self.position = CameraManagerDevicePositionFront;
}
///通过视频的URL，获得视频缩略图
-(UIImage *)getImage:(NSString *)videoURL{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}
#pragma mark —— LazyLoad
///视频分辨率设置
-(AVFileType)outputFileType{
    if ([NSString isNullString:_outputFileType]) {
        _outputFileType = AVFileTypeMPEG4;//默认MP4格式
    }return _outputFileType;
}

-(AVMutableComposition *)mixComposition{
    if (!_mixComposition) {
        //音频视频合成体
        _mixComposition = AVMutableComposition.new;
    }return _mixComposition;
}

-(AVMutableCompositionTrack *)audioTrack{
    if (!_audioTrack) {
        _audioTrack = [self.mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    }return _audioTrack;
}

-(AVMutableCompositionTrack *)videoTrack{
    if (!_videoTrack) {
        _videoTrack = [self.mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    }return _videoTrack;
}

-(AVMutableVideoComposition *)videoComp{
    if (!_videoComp) {
        _videoComp = AVMutableVideoComposition.videoComposition;
        _videoComp.renderSize = self.videoSize;
        _videoComp.frameDuration = CMTimeMake(1, 30);
        _videoComp.instructions = [NSArray arrayWithObject: self.instruction];
    }return _videoComp;
}

-(CGSize)videoSize{
//    return self.videoTrack.naturalSize;
    if (CGSizeEqualToSize(_videoSize,CGSizeZero)) {
        NSLog(@"外层未设置videoSize，走的是默认的Size");
        _videoSize = CGSizeMake(720.0, 1280.0);
    }return _videoSize;
}

-(AVMutableVideoCompositionInstruction *)instruction{
    if (!_instruction) {
        _instruction = AVMutableVideoCompositionInstruction.videoCompositionInstruction;
        _instruction.timeRange = CMTimeRangeMake(kCMTimeZero, self.mixComposition.duration);
        _instruction.layerInstructions = [NSArray arrayWithObject:self.layerInstruction];
    }return _instruction;
}

-(AVAssetTrack *)mixVideoTrack{
    if (!_mixVideoTrack) {
        _mixVideoTrack = [[self.mixComposition tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    }return _mixVideoTrack;
}

-(AVMutableVideoCompositionLayerInstruction *)layerInstruction{
    if (!_layerInstruction) {
        _layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:self.mixVideoTrack];
    }return _layerInstruction;
}

-(AVAssetExportSession *)exporter{
    if (!_exporter) {
        _exporter = [[AVAssetExportSession alloc] initWithAsset:self.mixComposition
                                                     presetName:AVAssetExportPresetMediumQuality];
        _exporter.videoComposition = self.videoComp;
        /*
         exporter.progress
         导出进度
         This property is not key-value observable.
         不支持kvo 监听
         只能用定时器监听了  NStimer
         */
        
        _exporter.outputURL = self.mergeFileURL;//这个是干嘛的？
        _exporter.outputFileType = self.outputFileType;//视频分辨率设置
        _exporter.shouldOptimizeForNetworkUse = YES;
    }return _exporter;
}

-(MKGPUImageView *)myGPUImageView{
    if (!_myGPUImageView) {
        _myGPUImageView = [[MKGPUImageView alloc] initWithFrame:getMainWindow().bounds];
        _myGPUImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;//kGPUImageFillModePreserveAspectRatioAndFill;
        
        @weakify(self)
        // 点击事件回调
        [_myGPUImageView actionMKGPUImageViewBlock:^(id data) {
            @strongify(self)
            if (self.VedioToolsBlock) {
                self.VedioToolsBlock(self->_myGPUImageView);
            }
        }];

        [self.myGPUVideoCamera addTarget:_myGPUImageView];
    }return _myGPUImageView;
}

-(GPUImageVideoCamera *)myGPUVideoCamera{
    if (!_myGPUVideoCamera) {
        _myGPUVideoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:self.sessionPreset
                                                                    cameraPosition:AVCaptureDevicePositionFront];
        _myGPUVideoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        _myGPUVideoCamera.horizontallyMirrorFrontFacingCamera = YES;
        [_myGPUVideoCamera addAudioInputsAndOutputs];
        _myGPUVideoCamera.horizontallyMirrorRearFacingCamera = NO;

        _myGPUVideoCamera.delegate = self;
        if ([_myGPUVideoCamera.inputCamera lockForConfiguration:nil]) {
            //自动对焦
            if ([_myGPUVideoCamera.inputCamera isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                [self.myGPUVideoCamera.inputCamera setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
            }
            //自动曝光
            if ([_myGPUVideoCamera.inputCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
                [self.myGPUVideoCamera.inputCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
            }
            //自动白平衡
            if ([_myGPUVideoCamera.inputCamera isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
                [_myGPUVideoCamera.inputCamera setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
            }
            [_myGPUVideoCamera.inputCamera unlockForConfiguration];
        }
    }return _myGPUVideoCamera;
}

-(GPUImageMovieWriter *)movieWriter{
    if (!_movieWriter) {
        if ([FileFolderHandleTool createFileByUrl:self.FileByUrl
                                            error:nil]) {//如果返回结果为真，说明self.FileByUrl这个路径可用
            _movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:[NSURL fileURLWithPath:self.FileByUrl]//[NSURL URLWithString:self.FileByUrl]
                                                                    size:self.movieWriterSize];
//            _movieWriter.isNeedBreakAudioWhiter = YES;
            _movieWriter.encodingLiveVideo = YES;
            _movieWriter.shouldPassthroughAudio = YES;
            switch (_typeFilter) {
                case filterNone:{
                    [self.myGPUVideoCamera addTarget:_movieWriter];
                }
                    break;
                case filterDilation:{
                    [self.dilationFilter addTarget:_movieWriter];
                }
                    break;
                case filterGif:{
                    [self.gifFilter addTarget:_movieWriter];
                }
                    break;
                case filterBeautify:{
                    [self.beautifyFilter addTarget:_movieWriter];
                }
                    break;
                case filterGaussBlur:{
                    [self.gaussBlurFilter addTarget:_movieWriter];
                }
                    break;
                default:
                    break;
            }
        }else {
            _movieWriter = nil;
            NSLog(@"存储视频的文件夹我都创建失败了，我还录制个屁啊？您说是不是？！！！");
        }
    }return _movieWriter;
}

-(CGSize)movieWriterSize{
    if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset352x288]){
        return CGSizeMake(288.0, 352.0);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset640x480]){
        return CGSizeMake(480.0, 640.0);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset1280x720]){
        return CGSizeMake(720.0, 1280.0);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset1920x1080]){
        return CGSizeMake(1080.0, 1920.0);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset3840x2160]){
        return CGSizeMake(2160.0, 3840);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPresetiFrame960x540]){
        return CGSizeMake(540.0, 960.0);
    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPresetiFrame1280x720]){
        return CGSizeMake(720.0, 1280.0);
    }
///以下这两款 is unavailable: not available on iOS
//    else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset960x540]){
//        return CGSizeMake(540.0, 960.0);
//    }else if ([self.sessionPreset isEqualToString:AVCaptureSessionPreset320x240]) {
//        return CGSizeMake(240.0, 320.0);
//    }
    else{
        return CGSizeZero;
    }return CGSizeZero;
}

-(NSString *)sessionPreset{
    if ([NSString isNullString:_sessionPreset]) {
        _sessionPreset = AVCaptureSessionPreset1280x720;//默认值
    }return _sessionPreset;
}

-(NSMutableArray<NSURL *> *)urlArray{
    if (!_urlArray) {
        _urlArray = NSMutableArray.array;
    }return _urlArray;
}
/// 以当前时间戳生成缓存路径 NSTemporaryDirectory()
-(NSString *)FileByUrl{//每时每刻都在变的，因为是时间戳路径
    if (!_FileByUrl) {
        // 在临时文件夹储存视频文件
        
        /*** 文件夹 用FileFolderHandleTool调
         
         沙盒的主目录：homeDir，
         沙盒中Documents：documentsDir，
         沙盒中Library：libraryDir，
         沙盒中Libarary/Preferences的目录：preferencesDir
         沙盒中Library/Caches的目录：cachesDir，
         沙盒中tmp的目录：tmpDir
         
         */
        _FileByUrl = [FileFolderHandleTool cacheURL:@"mp4"];//NSTemporaryDirectory()
    }return _FileByUrl;
}

@end
