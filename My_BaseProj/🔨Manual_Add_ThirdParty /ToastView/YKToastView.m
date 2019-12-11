//
//  YKToastView.m
//  YKMobileCommonUI
//
//  Created by NickJackson on 15/11/5.
//  Copyright © 2015年 Yueke. All rights reserved.
//

#import "YKToastView.h"

#define kYKToastViewFadeinDuration 0.2//渐入动画时间
#define kYKToastViewDisplayDuration 2.5//停留显示时间
#define kYKToastViewFadeoutDuration 0.3//渐出动画时间
#define kYKToastViewTextFont [UIFont systemFontOfSize:15]//提示文本字体
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@class YKToastMaskWindow;

@interface YKToastView(){
    YKToastMaskWindow *maskWindow_;
}

@property(nonatomic,copy)NSString *tipText;
@property(nonatomic,strong)UILabel *tipLabelView;
@property(nonatomic,strong)CABasicAnimation *fadeInAnimation;
@property(nonatomic,strong)CABasicAnimation *fadeOutAnimation;

- (void)forceHide;

@end

@interface YKToastMaskWindow : UIWindow

@property (nonatomic, strong) YKToastView *maskView;

@end

@implementation YKToastMaskWindow

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event{
    [super touchesBegan:touches
              withEvent:event];
    [(YKToastView *)self.maskView forceHide];
}

@end

@implementation YKToastView
#pragma mark - --------------------退出清空--------------------
- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - --------------------初始化--------------------
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initBaseView];
    }return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initBaseView];
    }return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initBaseView];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (_tipLabelView) {
        int edge = 10;
        [_tipLabelView setFrame:UIEdgeInsetsInsetRect(self.bounds,
                                                      UIEdgeInsetsMake(edge,
                                                                       edge,
                                                                       edge,
                                                                       edge))];
    }
}

- (void)initBaseView{
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    self.tipLabelView.alpha = 1;
    [self setClipsToBounds:YES];
    [self.layer setCornerRadius:5];
}
#pragma mark —— lazyLoad
-(UILabel *)tipLabelView{
    if (!_tipLabelView) {
        int edge = 10;
        _tipLabelView = [[UILabel alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds,
                                                                             UIEdgeInsetsMake(edge,
                                                                                              edge,
                                                                                              edge,
                                                                                              edge))];
        [_tipLabelView setBackgroundColor:[UIColor clearColor]];
        [_tipLabelView setTextAlignment:NSTextAlignmentCenter];
        [_tipLabelView setTextColor:[UIColor whiteColor]];
        [_tipLabelView setFont:kYKToastViewTextFont];
        _tipLabelView.numberOfLines = INT_MAX;
        [self addSubview:_tipLabelView];
    }return _tipLabelView;
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        if (_tipLabelView) {
            [_tipLabelView setText:self.tipText];
        }
    }
}
#pragma mark - --------------------功能函数-------------------
- (void)showInView:(UIView *)view{
    if (!maskWindow_) {
        maskWindow_ = [[YKToastMaskWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        maskWindow_.windowLevel = UIWindowLevelStatusBar + 1;
        [maskWindow_ setBackgroundColor:[UIColor clearColor]];
    }
    maskWindow_.maskView = self;
    [maskWindow_ makeKeyAndVisible];
    view = maskWindow_;
    [self setCenter:CGPointMake(view.bounds.size.width/2.0,
                                view.bounds.size.height/2.0)];
    self.layer.opacity = 0.0;
    [view addSubview:self];
    [self fadeInAnimationAfterDelay:kYKToastViewDisplayDuration];
}

- (void)showInView:(UIView *)view
   withDisplayTime:(NSTimeInterval)iSecond{
    if (!maskWindow_) {
        maskWindow_ = [[YKToastMaskWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        maskWindow_.windowLevel = UIWindowLevelStatusBar + 1;
        [maskWindow_ setBackgroundColor:[UIColor clearColor]];
    }
    maskWindow_.maskView = self;
    [maskWindow_ makeKeyAndVisible];
    view = maskWindow_;
    [self setCenter:CGPointMake(view.bounds.size.width/2.0,
                                view.bounds.size.height/2.0)];
    self.layer.opacity = 0.0;
    [view addSubview:self];
    [self fadeInAnimationAfterDelay:iSecond];
}

- (void)fadeInAnimationAfterDelay:(NSTimeInterval)delay{
    [CATransaction begin];
    @weakify(self)
    [CATransaction setCompletionBlock:^{
        @strongify(self)
        [self performSelector:@selector(FadeOut_Animation)
                   withObject:nil
                   afterDelay:kYKToastViewDisplayDuration];
    }];
    [self.layer addAnimation:self.fadeInAnimation
                      forKey:@"fadeIn"];
}

- (void)FadeOut_Animation{
    maskWindow_.maskView = nil;
    [CATransaction begin];
    @weakify(self)
    [CATransaction setCompletionBlock:^{
        @strongify(self)
        [self forceHide];
    }];
    [self.layer addAnimation:self.fadeOutAnimation
                      forKey:@"fadeOut"];
}
#pragma mark —— lazyLoad
-(CABasicAnimation *)fadeInAnimation{
    if (!_fadeInAnimation) {
        _fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [_fadeInAnimation setDuration:kYKToastViewFadeinDuration];
        [_fadeInAnimation setFromValue:[NSNumber numberWithFloat:0.0]];
        [_fadeInAnimation setToValue:[NSNumber numberWithFloat:1.0]];
        [_fadeInAnimation setRemovedOnCompletion:NO];
        [_fadeInAnimation setFillMode:kCAFillModeForwards];
        [_fadeInAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [self.layer addAnimation:_fadeInAnimation
                          forKey:@"fadeIn"];
        [CATransaction commit];
    }return _fadeInAnimation;
}

-(CABasicAnimation *)fadeOutAnimation{
    if (!_fadeOutAnimation) {
        _fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [_fadeOutAnimation setDuration:kYKToastViewFadeoutDuration];
        [_fadeOutAnimation setFromValue:[NSNumber numberWithFloat:1.0]];
        [_fadeOutAnimation setToValue:[NSNumber numberWithFloat:0.0]];
        [_fadeOutAnimation setRemovedOnCompletion:NO];
        [_fadeOutAnimation setFillMode:kCAFillModeForwards];
        [_fadeOutAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [CATransaction commit];
    }return _fadeOutAnimation;
}

#pragma mark - --------------------接口API--------------------
#pragma mark 强制消失
- (void)forceHide{
    maskWindow_.maskView = nil;
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(FadeOut_Animation)
                                               object:nil];
    [self removeFromSuperview];
    [maskWindow_ resignKeyWindow];
    [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
}

#pragma mark Toast样式提示自定义内容
+ (void)showToastText:(NSString *)text
               inView:(UIView *)view{
    if (![NSString isNullString:text]){
        YKToastView *toastTipView = [[YKToastView alloc] initWithFrame:CGRectMake(0,
                                                                                  0,
                                                                                  250,
                                                                                  44)];
        CGSize textSize = CGSizeZero;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            CGRect frame = [text boundingRectWithSize:CGSizeMake(250 - 30, 320)
                                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes:@{NSFontAttributeName:kYKToastViewTextFont}
                                              context:nil];
            textSize = frame.size;
        }else{
            //ios6 paul
            //        textSize = [text sizeWithFont:kYKToastViewTextFont constrainedToSize:CGSizeMake(250-30, 320) lineBreakMode:UILineBreakModeTailTruncation];
        }
        if (textSize.height > 20) {
            int viewHeight = 15 + textSize.height + 15;
            CGRect toastFrame = toastTipView.frame;
            toastFrame.size.height = viewHeight;
            toastTipView.frame = toastFrame;
        }
        toastTipView.tipText = text;
        [toastTipView showInView:view];
    }
}

#pragma mark Toast样式提示自定义内容
+ (void)showToastText:(NSString *)text
               inView:(UIView *)view
      withDisplayTime:(NSTimeInterval)iSecond{
    if (![NSString isNullString:text]){
        YKToastView *toastTipView = [[YKToastView alloc] initWithFrame:CGRectMake(0,
                                                                                  0,
                                                                                  250,
                                                                                  44)];
        CGSize textSize = CGSizeZero;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            CGRect frame = [text boundingRectWithSize:CGSizeMake(250 - 30, 320)
                                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes:@{NSFontAttributeName:kYKToastViewTextFont}
                                              context:nil];
            textSize = frame.size;
        }else{
            //ios6 paul
            //        textSize = [text sizeWithFont:kYKToastViewTextFont constrainedToSize:CGSizeMake(250-30, 320) lineBreakMode:UILineBreakModeTailTruncation];
        }
        if (textSize.height > 20) {
            int viewHeight = 15 + textSize.height + 15;
            CGRect toastFrame = toastTipView.frame;
            toastFrame.size.height = viewHeight;
            toastTipView.frame = toastFrame;
        }
        toastTipView.tipText = text;
        [toastTipView showInView:view withDisplayTime:iSecond];
    }
}

#pragma mark Toast样式在Window上提示自定义内容
+ (void)showToastText:(NSString *)text{
    if (![NSString isNullString:text]) {
        [YKToastView showToastText:text
                            inView:[[[UIApplication sharedApplication] delegate] window]];
    }
}

+ (void)showToastText:(NSString *)text
      withDisplayTime:(NSTimeInterval)iSecond{
    if (![NSString isNullString:text]) {
        [YKToastView showToastText:text
                            inView:[[[UIApplication sharedApplication] delegate] window]
                   withDisplayTime:iSecond];
    }
}

+ (void)showToastTextInRandomLocation:(NSString *)text{
    if (![NSString isNullString:text]){
        YKToastView *toastTipView = [[YKToastView alloc] initWithFrame:CGRectMake(0,
                                                                                  0,
                                                                                  250,
                                                                                  44)];
        CGSize textSize = CGSizeZero;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            CGRect frame = [text boundingRectWithSize:CGSizeMake(250 - 30, 320)
                                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes:@{NSFontAttributeName:kYKToastViewTextFont}
                                              context:nil];
            textSize = frame.size;
        }else{
            //ios6 paul
            //      CGSize textSize = [text sizeWithFont:kYKToastViewTextFont constrainedToSize:CGSizeMake(250-30, 320) lineBreakMode:UILineBreakModeTailTruncation];
        }
        if (textSize.height > 20) {
            int viewHeight = 15 + textSize.height + 15;
            CGRect toastFrame = toastTipView.frame;
            toastFrame.size.height = viewHeight;
            toastTipView.frame = toastFrame;
        }
        toastTipView.tipText = text;
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        static NSUInteger lastIndex = 0;
        //Paul
        //    lastIndex = (++lastIndex) % 8;
        ++lastIndex;
        lastIndex = lastIndex % 8;
        [toastTipView setCenter:CGPointMake(window.bounds.size.width/2.0, 100 + lastIndex * 50)];
        toastTipView.layer.opacity = 0.0;
        [window addSubview:toastTipView];
        [toastTipView fadeInAnimationAfterDelay:4];
    }
}


@end

