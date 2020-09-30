//
//  MKUploadingVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "LGiOSBtn.h"
#import "AgreementView.h"

#import "MKUploadingVC.h"
#import "MKUploadingVC+VM.h"

#define InputLimit 60

@interface MKUploadingVC ()
<
UITextViewDelegate
,DZDeleteButtonDelegate
>

@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)SZTextView *textView;
@property(nonatomic,strong)UILabel *tipsLab;
@property(nonatomic,strong)LGiOSBtn *__block choosePicBtn;
@property(nonatomic,strong)UIButton *releaseBtn;
@property(nonatomic,assign)int inputLimit;
@property(nonatomic,strong)UIImage *imgData;
@property(nonatomic,assign)BOOL isClickMKUploadingVCView;
@property(nonatomic,strong)NSData *__block vedioData;
@property(nonatomic,strong)AVURLAsset *__block urlAsset;

@property(nonatomic,strong)AgreementView *agreementView;

@end

@implementation MKUploadingVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.inputLimit = InputLimit;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:KBuddleIMG(@"Others", nil, @"nodata")];
    self.backView.alpha = 1;
    self.textView.alpha = 1;
    self.choosePicBtn.alpha = 1;
    self.tipsLab.alpha = 1;
    
    self.releaseBtn.alpha = 0.4;
    self.agreementView.alpha = 1;
    [IQKeyboardManager sharedManager].enable = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isClickMKUploadingVCView = NO;
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
//    [self ff];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"");
}
//这个地方必须用下划线属性而不能用self.属性。因为这两个方法反复调用，会触发懒加载
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"");
}

-(void)ff{
    NSMutableArray *dataMutArr = [self autoChoiceRes];
    PHAsset *phAsset = (PHAsset *)dataMutArr.lastObject;
    
    [FileFolderHandleTool getVedioFromPHAsset:phAsset
                                     complete:^(id data) {
        if ([data isKindOfClass:AVURLAsset.class]) {
            self.urlAsset = (AVURLAsset *)data;
            NSURL *url = self.urlAsset.URL;
            self.vedioData = [NSData dataWithContentsOfURL:url];
            [GPUImageTools.new getImage:url.absoluteString];
        }
    }];
}
///进来以后直接选择最后一个资源文件，直接绕开TZ
-(NSMutableArray *)autoChoiceRes{
/*
 PHAsset: 代表照片库中的一个资源，跟 ALAsset 类似，通过 PHAsset 可以获取和保存资源
 PHFetchOptions: 获取资源时的参数，可以传 nil，即使用系统默认值
 PHFetchResult: 表示一系列的资源集合，也可以是相册的集合
 PHAssetCollection: 表示一个相册或者一个时刻，或者是一个「智能相册（系统提供的特定的一系列相册，例如：最近删除，视频列表，收藏等等，如下图所示）
 PHImageManager: 用于处理资源的加载，加载图片的过程带有缓存处理，可以通过传入一个 PHImageRequestOptions 控制资源的输出尺寸，同异步获取，是否获取iCloud图片等
 PHCachingImageManager: 继承 PHImageManager ，对Photos的图片或视频资源提供了加载或生成预览缩略图和全尺寸图片的方法，针对预处理巨量的资源进行了优化。
 PHImageRequestOptions: 如上面所说，控制加载图片时的一系列参数
*/

    //获取所有的系统相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                          subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                          options:nil];
    NSMutableArray <PHFetchResult *>*dataMutArr = NSMutableArray.array;
    //将smartAlbums中的相册添加到数组中(最近添加，相机胶卷,视频...)
    for (PHAssetCollection *collection in smartAlbums) {
        //如果不想显示 ‘最近添加’ ‘收藏’等 可以这样做
        if (collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumRecentlyAdded ||
            collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumFavorites) {
            continue;
        }
        //遍历所有相册，只显示有视频或照片的相册
        PHFetchOptions *fetchOptions = PHFetchOptions.new;
        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d || mediaType == %d", PHAssetMediaTypeImage,PHAssetMediaTypeVideo];
        //按创建时间排序
        fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate"
                                                                       ascending:YES]];
        
        PHFetchResult *assetResults = [PHAsset fetchAssetsInAssetCollection:collection
                                                                    options:fetchOptions];
        if (assetResults.count > 0) {
            [dataMutArr addObject:assetResults];
        }
    }return dataMutArr;
}


///发布成功以后做的事情
-(void)afterRelease{
    [self deleteButtonRemoveSelf:self.choosePicBtn];
    [self btnClickEvent:self.agreementView.agreementBtn];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    self.textView.text = @"";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    self.isClickMKUploadingVCView = !self.isClickMKUploadingVCView;
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = !self.isClickMKUploadingVCView;
}
#pragma mark —— 点击事件
-(void)btnClickEvent:(UIButton *)sender{
    NSLog(@"已阅读并同意上传须知");
    sender.selected = !sender.selected;
}

-(void)sure{
    [self choosePicBtnClickEvent:nil];
}

-(void)KK{
    if (self.imgData && ![NSString isNullString:self.textView.text]) {
        self.releaseBtn.userInteractionEnabled = YES;
        self.releaseBtn.alpha = 1;
        self.releaseBtn.backgroundColor = kRedColor;
    }else{
        self.releaseBtn.userInteractionEnabled = NO;
        self.releaseBtn.alpha = 0.4;
        self.releaseBtn.backgroundColor = KLightGrayColor;
    }
}
///选择相册文件
-(void)choosePicBtnClickEvent:(LGiOSBtn *)sender{
    self.imagePickerVC = Nil;
    [NSObject feedbackGenerator];
    @weakify(self)
    [self choosePic:TZImagePickerControllerType_1 imagePickerVCBlock:^(id data) {
        @strongify(self)
        //回调 这样就可以全部选择视频了
        self.imagePickerVC.allowPickingVideo = YES;
        self.imagePickerVC.allowPickingImage = NO;
        self.imagePickerVC.allowPickingOriginalPhoto = NO;
        self.imagePickerVC.allowPickingGif = NO;
        self.imagePickerVC.allowPickingMultipleVideo = NO;
    }];
    [self GettingPicBlock:^(id firstArg, ...)NS_REQUIRES_NIL_TERMINATION{
        @strongify(self)
        if (firstArg) {
            // 取出第一个参数
            NSLog(@"%@", firstArg);
            // 定义一个指向个数可变的参数列表指针；
            va_list args;
            // 用于存放取出的参数
            id arg = nil;
            // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
            va_start(args, firstArg);
            // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
            if ([firstArg isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)firstArg;
                for (int i = 0; i < num.intValue; i++) {
                    arg = va_arg(args, id);
//                    NSLog(@"KKK = %@", arg);
                    if ([arg isKindOfClass:UIImage.class]) {
                        self.imgData = (UIImage *)arg;
                        [self.choosePicBtn setImage:[UIImage addImage:[UIImage cropSquareImage:self.imgData]
                                                            withImage:KBuddleIMG(@"拍摄", nil, @"播放.png")
                                                    image2Coefficient:3]
                                           forState:UIControlStateNormal];
                        self.choosePicBtn.iconBtn.hidden = NO;
                        [self KK];
                    }else if ([arg isKindOfClass:PHAsset.class]){
                        NSLog(@"");
                        PHAsset *phAsset = (PHAsset *)arg;
                        [FileFolderHandleTool getVedioFromPHAsset:phAsset
                                                         complete:^(id data) {
                            if ([data isKindOfClass:AVURLAsset.class]) {
                                self.urlAsset = (AVURLAsset *)data;
                                NSURL *url = self.urlAsset.URL;
                                self.vedioData = [NSData dataWithContentsOfURL:url];
                            }
                        }];
                    }else if ([arg isKindOfClass:NSString.class]){
                        NSLog(@"");
                    }else if ([arg isKindOfClass:NSArray.class]){
                        NSArray *arr = (NSArray *)arg;
                        if (arr.count == 1) {
                            if ([arr[0] isKindOfClass:PHAsset.class]) {
                                
                            }else if ([arr[0] isKindOfClass:UIImage.class]){
                                [NSObject showSYSAlertViewTitle:@"请选择视频作品"
                                                        message:nil
                                                isSeparateStyle:NO
                                                    btnTitleArr:@[@"确认"]
                                                 alertBtnAction:@[@"sure"]
                                                       targetVC:self
                                                   alertVCBlock:^(id data) {
                                    //DIY
                                }];
                            }else{
                                NSLog(@"");
                            }
                        }else{
                            NSLog(@"");
                        }
                    }else{
                        NSLog(@"");
                    }
                }
            }else{
                NSLog(@"");
            }
            // 清空参数列表，并置参数指针args无效
            va_end(args);
        }
    }];
}
#pragma mark - DZDeleteButtonDelegate
- (void)deleteButtonRemoveSelf:(LGiOSBtn *_Nonnull)button{
    [button setImage:KBuddleIMG(@"Others", nil, @"加号.png")
            forState:UIControlStateNormal];
    button.iconBtn.hidden = YES;
    button.shaking = NO;
    self.imgData = nil;
    [self KK];
}
#pragma mark - UITextViewDelegate协议中的方法
//将要进入编辑模式
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {return YES;}
//已经进入编辑模式
- (void)textViewDidBeginEditing:(UITextView *)textView {}
//将要结束/退出编辑模式
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {return YES;}
//已经结束/退出编辑模式
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self KK];
}
//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView {}
//选中textView 或者输入内容的时候调用
- (void)textViewDidChangeSelection:(UITextView *)textView {}
//从键盘上将要输入到textView 的时候调用
//rangge  光标的位置
//text  将要输入的内容
//返回YES 可以输入到textView中  NO不能
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    return YES;
}
#pragma mark - lazyLoad
-(UIView *)backView{
    if (!_backView) {
        _backView = UIView.new;
        _backView.backgroundColor = COLOR_RGB(33, 38, 50, 1);
        [self.view addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(SCALING_RATIO(16));
            make.height.mas_equalTo(SCALING_RATIO(153));
        }];
    }return _backView;
}

-(SZTextView *)textView{
    if (!_textView) {
        _textView = SZTextView.new;
        _textView.backgroundColor = COLOR_RGB(33, 38, 50, 1);
        _textView.delegate = self;
        _textView.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"主人来两句嘛！~~~"
                                                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightRegular],
                                                                                              NSForegroundColorAttributeName:kWhiteColor}];
        _textView.placeholderTextColor = kWhiteColor;
        _textView.textColor = kWhiteColor;
        _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
        [self.backView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.backView);
            make.height.mas_equalTo(SCALING_RATIO(133));
        }];
    }return _textView;
}

-(UILabel *)tipsLab{
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.textColor = kWhiteColor;//
        _tipsLab.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还可以输入%d个字符",self.inputLimit]
                                                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightRegular],
                                                                                      NSForegroundColorAttributeName:HEXCOLOR(0x242A37)}];
        [self.backView addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.backView).offset(SCALING_RATIO(-6));
            make.top.equalTo(self.textView.mas_bottom).offset(SCALING_RATIO(-6));
        }];
    }return _tipsLab;
}

-(LGiOSBtn *)choosePicBtn{
    if (!_choosePicBtn) {
        _choosePicBtn = LGiOSBtn.new;
        _choosePicBtn.delegate = self;
        [self.view addSubview:_choosePicBtn];
        [_choosePicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(130), SCALING_RATIO(130)));
            make.left.equalTo(self.view).offset(SCALING_RATIO(13));
            make.top.equalTo(self.backView.mas_bottom).offset(SCALING_RATIO(13));
        }];
        @weakify(self)
        [[_choosePicBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self choosePicBtnClickEvent:x];
        }];
        [UIView colourToLayerOfView:_choosePicBtn
                         WithColour:KLightGrayColor
                     AndBorderWidth:0.2f];
        [self.view layoutIfNeeded];
    }return _choosePicBtn;
}

-(UIButton *)releaseBtn{
    if (!_releaseBtn) {
        _releaseBtn = UIButton.new;
        [_releaseBtn setTitle:@"确认发布"
                     forState:UIControlStateNormal];
        _releaseBtn.uxy_acceptEventInterval = 1;
        //默认先关
        _releaseBtn.userInteractionEnabled = NO;
        _releaseBtn.alpha = 0.4;
        _releaseBtn.backgroundColor = KLightGrayColor;
        @weakify(self)
        [[_releaseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.agreementView.agreementBtn.selected &&
                ![NSString isNullString:self.textView.text] &&
                self.imgData) {
                NSLog(@"发布成功");
                //这里先鉴定是否已经登录？
                if (!YES) {
                    // 已经登录才可以上传视频
                    //对视频的大小进行控制 单个视频上传最大支持300M
                    
        //            8bit(位) = 1Byte(字节)
        //            1024Byte(字节) = 1KB
        //            1024KB = 1MB
        //            1024MB = 1GB
                    
        //            视频上传格式：
        //            最终支持所有格式上传，目前优先支持mp4和webm格式。如不符合上传格式要求，前期则半透明悬浮提示“请上传mp4或webm格式的视频文件”。
                    
                    if (sizeof(self.vedioData) <= 300 * 1024 * 1024) {
                        [self videosUploadNetworkingWithData:self.vedioData
                                                videoArticle:self.textView.text
                                                    urlAsset:self.urlAsset];
                    }else{
                        [MBProgressHUD wj_showPlainText:@"单个文件大小需要在300M以内"
                                                   view:self.view];
                    }
                }else{
        //            @weakify(self)
                    //登录流程
                }
            }else{
                if (!self.imgData) {
                    [NSObject showSYSAlertViewTitle:@"您还没选择需要上传的视频呢~~~"
                                            message:nil
                                    isSeparateStyle:NO
                                        btnTitleArr:@[@"确定"]
                                     alertBtnAction:@[@"sure"]
                                           targetVC:self
                                       alertVCBlock:^(id data) {
                        //DIY
                    }];
                }else if ([NSString isNullString:self.textView.text]){
                    [NSObject showSYSAlertViewTitle:@"主人，写点什么吧~~~"
                                            message:nil
                                    isSeparateStyle:NO
                                        btnTitleArr:@[@"确定"]
                                     alertBtnAction:@[@""]
                                           targetVC:self
                                       alertVCBlock:^(id data) {
                        //DIY
                    }];
                }else{}
            }
        }];
        [self.view addSubview:_releaseBtn];
        [_releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2.5, SCALING_RATIO(30)));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.choosePicBtn.mas_bottom).offset(SCALING_RATIO(50));
        }];
        [UIView cornerCutToCircleWithView:_releaseBtn
                          AndCornerRadius:SCALING_RATIO(6)];
    }return _releaseBtn;
}

-(AgreementView *)agreementView{
    if (!_agreementView) {
        _agreementView = AgreementView.new;
        @weakify(self)
        [_agreementView actionAgreementViewBtnBlock:^(id data) {
            @strongify(self)
            [self btnClickEvent:data];
        }];
        
        [_agreementView actionAgreementViewLinkBlock:^(id data) {
            @strongify(self)
            NSLog(@"点击到了一个链接");
        }];
        
        [self.view addSubview:_agreementView];
        [_agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(140, 20));
            make.bottom.equalTo(self.releaseBtn.mas_top).offset(-5);
        }];
    }return _agreementView;
}

@end
