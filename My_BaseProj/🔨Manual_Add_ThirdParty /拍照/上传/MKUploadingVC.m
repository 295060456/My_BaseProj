//
//  MKUploadingVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "LGiOSBtn.h"
#import "MKUploadingVC.h"
#import "MKUploadingVC+VM.h"

#define InputLimit 40

@interface MKUploadingVC ()
<
UITextViewDelegate
,DZDeleteButtonDelegate
>{
    UIButton *btn;
}

@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)SZTextView *textView;
@property(nonatomic,strong)UILabel *tipsLab;
@property(nonatomic,strong)LGiOSBtn *choosePicBtn;
@property(nonatomic,strong)UIButton *releaseBtn;
@property(nonatomic,assign)int inputLimit;
@property(nonatomic,strong)UIImage *imgData;
@property(nonatomic,assign)BOOL isClickMKUploadingVCView;
@property(nonatomic,strong)NSData *__block vedioData;
@property(nonatomic,strong)AVURLAsset *__block urlAsset;

@property(nonatomic,strong)AWRichText *richText;
@property(nonatomic,strong)AWRichTextLabel *rtLabel;

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:kIMG(@"nodata")];
    self.backView.alpha = 1;
    self.textView.alpha = 1;
    self.choosePicBtn.alpha = 1;
    self.tipsLab.alpha = 1;
    
    if (!_rtLabel) {
        ///构造richtext
        AWRichText *rt = AWRichText.new;
        _richText = rt;
        [self createRichText];
    
        ///创建label
        _rtLabel = rt.createRichTextLabel;
        [self.view addSubview:_rtLabel];
        
        ///计算cell（富文本）高度
        [_richText attributedString];
        _richText.truncatingTokenComp = [[AWRTTextComponent alloc] init].AWText(@"~~~").AWFont([UIFont systemFontOfSize:12]).AWColor(kRedColor);
        ///注意，autolayout中可使用rtMaxWidth这个属性，也可以使用rtFrame
        ///若此处将rtFrame的高度改成一个非零较小的值如60，会有截断效果。
        ///截断字符由truncatingTokenComp决定，如不传，默认为 "..."。
        _rtLabel.rtFrame = CGRectMake(SCREEN_WIDTH / 2,
                                      self.choosePicBtn.mj_y + self.choosePicBtn.mj_h + SCALING_RATIO(10),
                                      SCREEN_WIDTH - 20,
                                      0);
    }
    self.releaseBtn.alpha = 0.4;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isClickMKUploadingVCView = NO;
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
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

-(void)createRichText{
    UIFont *btnFont = nil;
    if (@available(iOS 8.2, *)) {
        btnFont = [UIFont systemFontOfSize:12
                                    weight:UIFontWeightBold];
    } else {
        btnFont = [UIFont systemFontOfSize:12];
    }
    [self addButtonCompWithBtnTitle:@"  已阅读并同意"
                               font:btnFont
                              color:kRedColor
                             target:self
                             action:@selector(btnClickEvent:)];
    [self addLinkCompWithText:@"上传须知"
                      onClick:^{
        NSLog(@"点击到了一个链接");
    }];
}
///发布成功以后做的事情
-(void)afterRelease{
    [self deleteButtonRemoveSelf:self.choosePicBtn];
    [self btnClickEvent:btn];
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
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.releaseBtn.userInteractionEnabled = YES;
        self.releaseBtn.alpha = 1;
        self.releaseBtn.backgroundColor = kRedColor;
    }else{
        self.releaseBtn.userInteractionEnabled = NO;
        self.releaseBtn.alpha = 0.4;
        self.releaseBtn.backgroundColor = KLightGrayColor;
    }
}

-(void)sure{
    [self choosePicBtnClickEvent:nil];
}

-(void)OK{}

-(void)choosePicBtnClickEvent:(UIButton *)sender{
    self.imagePickerVC = Nil;
    [NSObject feedbackGenerator];
    [self choosePic:TZImagePickerControllerType_1];
    @weakify(self)
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
                    NSLog(@"KKK = %@", arg);
                    if ([arg isKindOfClass:UIImage.class]) {
                        self.imgData = (UIImage *)arg;
                        [self.choosePicBtn setImage:[UIImage addImage:[UIImage cropSquareImage:self.imgData]
                                                            withImage:kIMG(@"播放")
                                                    image2Coefficient:3]
                                           forState:UIControlStateNormal];
                        self.choosePicBtn.iconBtn.alpha = 0.7;
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
                                [self alertControllerStyle:SYS_AlertController
                                        showAlertViewTitle:@"请选择视频作品"
                                                   message:nil
                                           isSeparateStyle:NO
                                               btnTitleArr:@[@"确认"]
                                            alertBtnAction:@[@"sure"]
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
    [button setImage:kIMG(@"加号")
            forState:UIControlStateNormal];
    button.iconBtn.alpha = 0;
    button.shaking = NO;
}
#pragma mark - UITextViewDelegate协议中的方法
//将要进入编辑模式
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {return YES;}
//已经进入编辑模式
- (void)textViewDidBeginEditing:(UITextView *)textView {}
//将要结束/退出编辑模式
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {return YES;}
//已经结束/退出编辑模式
- (void)textViewDidEndEditing:(UITextView *)textView {}
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
        [[_choosePicBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self choosePicBtnClickEvent:self->_choosePicBtn];
        }];
        [UIView colourToLayerOfView:_choosePicBtn
                         WithColour:KLightGrayColor
                     AndBorderWidth:0.2f];
        [self.view layoutIfNeeded];
    }return _choosePicBtn;
}

-(AWRTViewComponent *)addButtonCompWithBtnTitle:(NSString *)title
                                           font:(UIFont *)font
                                          color:(UIColor *)color
                                         target:(id)target
                                         action:(SEL)action{
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 22)];
    [btn setImage:kIMG(@"unsure") forState:UIControlStateNormal];
    [btn setImage:kIMG(@"sure") forState:UIControlStateSelected];
    btn.titleLabel.font = font;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:HEXCOLOR(0xaaa) forState:UIControlStateHighlighted];
    [btn setBackgroundColor:kClearColor];
    btn.layer.cornerRadius = 5;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    AWRTViewComponent *viewComp = ((AWRTViewComponent *)[self.richText addComponentFromPoolWithType:AWRTComponentTypeView])
    .AWView(btn)
    .AWFont([UIFont systemFontOfSize:12])
    .AWBoundsDepend(@(AWRTAttchmentBoundsDependContent))
    .AWAlignment(@(AWRTAttachmentAlignCenter))
    .AWPaddingRight(@1);
    
    return viewComp;
}

-(AWRTTextComponent *)addTextCompWithText:(NSString *)text{
    AWRTTextComponent *textComp = ((AWRTTextComponent *)[self.richText addComponentFromPoolWithType:AWRTComponentTypeText])
    .AWText(text)
    .AWColor(KBrownColor)
    .AWShadowColor(KLightGrayColor)
    .AWShadowOffset([NSValue valueWithCGSize:CGSizeMake(0, 2)])
    .AWShadowBlurRadius(@(3));
    
    if (@available(iOS 8.2, *)) {
        textComp.AWFont([UIFont systemFontOfSize:14 weight:UIFontWeightBold]);
    } else {
        textComp.AWFont([UIFont systemFontOfSize:14]);
    }
    
    return textComp;
}

-(AWRTTextComponent *)addLinkCompWithText:(NSString *)text
                                  onClick:(void (^)(void))onClick{
    AWRTTextComponent *linkComp = [self addTextCompWithText:text]
    .AWColor(kWhiteColor);
    
#define TOUCHING_MODE (@"touchingLinkMode")
#define DEFAULT_MODE ((NSString *)AWRTComponentDefaultMode)
    
    [linkComp storeAllAttributesToMode:DEFAULT_MODE replace:YES];
    
    [linkComp beginUpdateMode:TOUCHING_MODE block:^{
        linkComp.AWUnderlineStyle(@(NSUnderlineStyleSingle))
        .AWUnderlineColor(HEXCOLOR(0x55F));
    }];
    
    linkComp.touchable = YES;
    linkComp.touchCallback = ^(AWRTComponent *comp, AWRTLabelTouchEvent touchEvent) {
        if (awIsTouchingIn(touchEvent)) {
            comp.currentMode = TOUCHING_MODE;
        }else{
            comp.currentMode = DEFAULT_MODE;
        }
        
        if (touchEvent == AWRTLabelTouchEventEndedIn) {
            if (onClick) {
                onClick();
            }
        }
    };return linkComp;
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

        [[_releaseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self->btn.selected &&
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
                                                   view:getMainWindow()];
                    }
                }else{
        //            @weakify(self)
                    //登录流程
                }
            }else{
                if (!self.imgData) {
                    [self alertControllerStyle:SYS_AlertController
                            showAlertViewTitle:@"您还没选择需要上传的视频呢~~~"
                                       message:nil
                               isSeparateStyle:NO
                                   btnTitleArr:@[@"确定"]
                                alertBtnAction:@[@"sure"]
                                  alertVCBlock:^(id data) {
                        //DIY
                    }];
                }else if ([NSString isNullString:self.textView.text]){
                    [self alertControllerStyle:SYS_AlertController
                            showAlertViewTitle:@"主人，写点什么吧~~~"
                                       message:nil
                               isSeparateStyle:NO
                                   btnTitleArr:@[@"确定"]
                                alertBtnAction:@[@"OK"]
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



@end
