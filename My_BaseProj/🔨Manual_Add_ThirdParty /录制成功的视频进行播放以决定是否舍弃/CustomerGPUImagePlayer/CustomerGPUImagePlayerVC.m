//
//  CustomerGPUImagePlayerVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CustomerGPUImagePlayerVC.h"
#import "MKGPUImageView.h"

@interface CustomerGPUImagePlayerVC ()<GPUImageMovieDelegate>

@property(nonatomic,strong)GPUImageMovie *movie;//播放
@property (nonatomic,strong)GPUImageFilter *filter;//滤镜
@property (nonatomic,strong)MKGPUImageView *filterView;//播放视图
@property (nonatomic,strong)GPUImageMovieWriter *writer;//保存

@property(nonatomic,strong)NSURL *AVPlayerURL;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation CustomerGPUImagePlayerVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    CustomerGPUImagePlayerVC *vc = CustomerGPUImagePlayerVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    
    vc.AVPlayerURL = requestParams[@"AVPlayerURL"];
    
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

    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    [self playVideo];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

/**
 播放视频，实时添加滤镜
 */
- (void)playVideo{
    /**
     *
     *  http://tx2.a.yximgs.com/upic/2016/07/01/21/BMjAxNjA3MDEyMTM4MjhfNzIwMjExNF84NTc1MTQ1NjJfMl8z.mp4?tag=1-1467534669-w-0-25bdx25jov-5a63ad5ba6299f84
     */
//    NSURL *sampleURL = [[NSBundle mainBundle]URLForResource:@"demo" withExtension:@"mp4" subdirectory:nil];
//    NSData *data3 = [NSData dataWithContentsOfFile:self.AVPlayerURL.absoluteString];
//    NSURL *sampleURL = [NSURL URLWithDataRepresentation:data3 relativeToURL:nil];
 
    
    
    NSURL *sampleURL = [NSURL fileURLWithPath:self.AVPlayerURL.absoluteString];
    
    /**
     *  初始化 movie
     */
    _movie = [[GPUImageMovie alloc] initWithURL:sampleURL];
    
    /**
     *  是否重复播放
     */
    _movie.shouldRepeat = NO;
    
    /**
     *  控制GPUImageView预览视频时的速度是否要保持真实的速度。
     *  如果设为NO，则会将视频的所有帧无间隔渲染，导致速度非常快。
     *  设为YES，则会根据视频本身时长计算出每帧的时间间隔，然后每渲染一帧，就sleep一个时间间隔，从而达到正常的播放速度。
     */
    _movie.playAtActualSpeed = YES;
    
    /**
     *  设置代理 GPUImageMovieDelegate，只有一个方法 didCompletePlayingMovie
     */
    _movie.delegate = self;
    
    /**
     *  This enables the benchmarking mode, which logs out instantaneous and average frame times to the console
     *
     *  这使当前视频处于基准测试的模式，记录并输出瞬时和平均帧时间到控制台
     *
     *  每隔一段时间打印： Current frame time : 51.256001 ms，直到播放或加滤镜等操作完毕
     */
    _movie.runBenchmark = YES;
    
    /**
     *  添加卡通滤镜
     */
    _filter = [[GPUImageToonFilter alloc] init];
    [_movie addTarget:_filter];
    
    /**
     *  添加显示视图
     */
    
    [_filter addTarget:self.filterView];
    
    [self.view addSubview:_filterView];
    
    /**
     *  视频处理后输出到 GPUImageView 预览时不支持播放声音，需要自行添加声音播放功能
     *
     *  开始处理并播放...
     */
    [_movie startProcessing];
    
    
}

#pragma mark —— GPUImageMovieDelegate
- (void)didCompletePlayingMovie {
    NSLog(@"播放完成");
    
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.mov"];
    unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    
    NSLog(@"pathToMovie:  %@",pathToMovie);
    
    _writer =[[GPUImageMovieWriter alloc]initWithMovieURL:movieURL size:CGSizeMake(320,480)];
    
    _writer.encodingLiveVideo = NO;
    _writer.shouldPassthroughAudio = NO;
    [_filter addTarget:_writer];
    
    
    
    [_movie enableSynchronizedEncodingUsingMovieWriter:_writer];
    _movie.audioEncodingTarget = _writer;
    
    
    
    
    [_writer startRecording];
    [_writer setCompletionBlock:^{
        NSLog(@"完成！！！");
    }];
    [_writer setFailureBlock:^(NSError *error){
        NSLog(@"失败！！！ %@",error);
    }];
}


- (MKGPUImageView *)filterView {
    if (!_filterView) {
        _filterView = [[MKGPUImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
    }
    return _filterView;
}

@end
