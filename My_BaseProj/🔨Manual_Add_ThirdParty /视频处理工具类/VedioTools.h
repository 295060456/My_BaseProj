//
//  VedioTools.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YHGPUImageBeautifyFilter.h"
#import "GPUImageVideoCamera.h"
#import "MKGPUImageView.h"
#import "GPUImage.h"

typedef enum : NSUInteger {
    VedioShootType_un = 0,//未定义的
    VedioShootType_on,//开始录制
    VedioShootType_suspend,//暂停录制
    VedioShootType_continue,//继续录制
    VedioShootType_off,//取消录制
    VedioShootType_end//结束录制
} VedioShootType;//视频录制的状态

NS_ASSUME_NONNULL_BEGIN

//视频处理类
@interface VedioTools : NSObject
///视频分辨率设置
@property(nonatomic,copy,nullable)AVFileType outputFileType;
@property(nonatomic,assign)CGSize videoSize;
@property(nonatomic,assign)VedioShootType vedioShootType;
@property(nonatomic,strong)NSString *sessionPreset;
@property(nonatomic,strong)NSMutableArray <NSURL *>*urlArray;
@property(nonatomic,assign)CGSize movieWriterSize;
@property(nonatomic,strong)NSString *FileByUrl;

@property(nonatomic,strong)MKGPUImageView *myGPUImageView;//实际上点击的是它，所以点击事件在 myGPUImageView 的回调里面
@property(nonatomic,strong)GPUImageVideoCamera *myGPUVideoCamera;
@property(nonatomic,strong)GPUImageMovieWriter *movieWriter;
@property(nonatomic,strong)GPUImageDilationFilter *dilationFilter;
@property(nonatomic,strong)GPUImageAlphaBlendFilter *gifFilter;
@property(nonatomic,strong)GPUImageGaussianBlurFilter *gaussBlurFilter;
@property(nonatomic,strong)YHGPUImageBeautifyFilter *beautifyFilter;
@property(nonatomic,assign)CameraManagerDevicePosition position;
@property(nonatomic,assign)TypeFilter typeFilter;
@property(nonatomic,copy)MKDataBlock VedioToolsBlock;

+(VedioTools *)sharedInstance;
/// 视频合并
-(void)mergeAndExportVideos:(NSArray *)videosPathArray
                withOutPath:(NSString *)outpath;
///通过视频的URL，获得视频缩略图
-(UIImage *)getImage:(NSString *)videoURL;
-(void)actionVedioToolsBlock:(MKDataBlock)VedioToolsBlock;

#pragma mark —— 开始录制
-(void)vedioShoottingOn;
#pragma mark —— 结束录制
-(void)vedioShoottingEnd;
#pragma mark —— 暂停录制
-(void)vedioShoottingSuspend;
#pragma mark —— 继续录制
-(void)vedioShoottingContinue;
#pragma mark —— 取消录制
-(void)vedioShoottingOff;
///翻转摄像头
-(void)overturnCamera;
///开启实况视频
-(void)LIVE;// 这个方法最开始调

@end

NS_ASSUME_NONNULL_END
