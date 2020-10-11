
#import "ZYTextField.h"
#import "ZYTextField+HistoryDataList.h"

@interface ZYTextField ()<CAAnimationDelegate>

@property(nonatomic,assign)BOOL isOk;

@property(strong,nonatomic)UILabel *placeholderCacheLabel;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)UIView *grayLineView;
@property(strong,nonatomic)NSAttributedString *cachedPlaceholder;

@end

@implementation ZYTextField

-(instancetype)init{
    if (self = [super init]) {
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.defaultTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15
                                                                             weight:UIFontWeightRegular],
                                       NSForegroundColorAttributeName:COLOR_RGB(33,
                                                                                33,
                                                                                33,
                                                                                1)};
        self.borderStyle = UITextBorderStyleNone;
        self.backgroundColor = kWhiteColor;
        [self modifyClearButtonWithImage:KBuddleIMG(nil,@"ZYTextField",nil, @"closeCircle")];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(kd_textFieldDidBeginEditing:)
                                                     name:UITextFieldTextDidBeginEditingNotification
                                                   object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(kd_textFieldDidEndEditing:)
                                                     name:UITextFieldTextDidEndEditingNotification
                                                   object:self];
    }return self;
}

-(UIView *)grayLineView{
    if (!_grayLineView) {
        _grayLineView = UIView.new;
        _grayLineView.frame = CGRectMake(0,
                                         self.frame.size.height - 1,
                                         self.frame.size.width,
                                         1);
        _grayLineView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        [self addSubview:_grayLineView];
    }return _grayLineView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = UIView.new;
        _lineView.frame = CGRectMake(0,
                                     self.frame.size.height - 1,
                                     0,
                                     1);
        _lineView.backgroundColor = [UIColor greenColor];
        _lineView.layer.anchorPoint = CGPointMake(0, 0.5);
        [self addSubview:_lineView];
    }return _lineView;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOk) {
        self.ZYTextFieldTapGR.enabled = self.isShowHistoryDataList;
        [self setUpUI];
        self.grayLineView.alpha = 1;
        self.lineView.alpha = 1;
    }
}

- (void)setUpUI{
    //字体大小
    self.font = self.ZYtextFont;
    //字体颜色
    self.textColor = self.ZYtextColor;
    //光标颜色
    self.tintColor = self.ZYtintColor;
    //占位符的颜色和大小
    UILabel *placeholderLabel = object_getIvar(self,
                                               class_getInstanceVariable(UITextField.class,
                                                                         "_placeholderLabel"));
    placeholderLabel.textColor = self.ZYplaceholderLabelTextColor_1;
    placeholderLabel.font = self.ZYplaceholderLabelFont_1;
    // 不成为第一响应者
    [self resignFirstResponder];
    self.isOk = YES;
}
/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder{
    // 修改占位文字颜色
    UILabel *placeholderLabel = object_getIvar(self,
                                               class_getInstanceVariable(UITextField.class,
                                                                         "_placeholderLabel"));
    placeholderLabel.textColor = self.ZYplaceholderLabelTextColor_2;
    placeholderLabel.font = self.ZYplaceholderLabelFont_2;
    return [super becomeFirstResponder];
}
/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder{
    // 修改占位文字颜色
    UILabel *placeholderLabel = object_getIvar(self,
                                               class_getInstanceVariable(UITextField.class,
                                                                         "_placeholderLabel"));
    placeholderLabel.textColor = self.ZYplaceholderLabelTextColor_1;
    placeholderLabel.font = self.ZYplaceholderLabelFont_1;
    return [super resignFirstResponder];
}
#pragma mark —— 重写父类方法
-(void)drawPlaceholderInRect:(CGRect)rect {
    // 计算占位文字的 Size
    CGSize placeholderSize = [self.placeholder sizeWithAttributes: @{NSFontAttributeName : self.font}];
    [self.placeholder drawInRect:CGRectMake(0,
                                            (rect.size.height - placeholderSize.height) / 2,
                                            rect.size.width,
                                            rect.size.height)
                  withAttributes:@{NSForegroundColorAttributeName : self.ZYplaceholderLabelTextColor_1,
                                   NSFontAttributeName : self.font}];
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += self.leftViewOffsetX;
    return iconRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super rightViewRectForBounds:bounds];
    iconRect.origin.x -= self.rightViewOffsetX;
    return iconRect;
}
//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + self.offset,
                              bounds.origin.y,
                              bounds.size.width - self.offset,
                              bounds.size.height);
    return inset;
}
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + self.offset,
                              bounds.origin.y,
                              bounds.size.width - self.offset,
                              bounds.size.height);
    return inset;
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + self.offset,
                              bounds.origin.y,
                              bounds.size.width - self.offset,
                              bounds.size.height);
    return inset;
}
//必须在self有具体frame的时候才管用
-(void)setZYTextFieldMasksToBounds:(BOOL)ZYTextFieldMasksToBounds{
    _ZYTextFieldMasksToBounds = ZYTextFieldMasksToBounds;
    if (CGRectEqualToRect(self.bounds, CGRectZero)) {
        NSLog(@"self.frame 为空，绘制失败");
    }else{
        if (_ZYTextFieldMasksToBounds) {
            self.layer.cornerRadius = self.ZYTextFieldCornerRadius;
            self.layer.borderColor = self.ZYTextFieldBorderColor.CGColor;
            self.layer.borderWidth = self.ZYTextFieldBorderWidth;
            self.layer.masksToBounds = ZYTextFieldMasksToBounds;//必须写在最后，否则绘制无效
        }
    }
}
#pragma mark —— lazyLoad
-(UIFont *)ZYtextFont{
    if (!_ZYtextFont) {
        _ZYtextFont = [UIFont systemFontOfSize:17
                                        weight:UIFontWeightRegular];
    }return _ZYtextFont;
}

-(UIColor *)ZYtextColor{
    if (!_ZYtextColor) {
        _ZYtextColor = RGBCOLOR(77,
                                150,
                                132);
    }return _ZYtextColor;
}

-(UIColor *)ZYtintColor{
    if (!_ZYtintColor) {
        _ZYtintColor = self.textColor;
    }return _ZYtintColor;
}

-(UIColor *)ZYplaceholderLabelTextColor_1{
    if (!_ZYplaceholderLabelTextColor_1) {
        _ZYplaceholderLabelTextColor_1 = self.textColor;
    }return _ZYplaceholderLabelTextColor_1;
}

-(UIColor *)ZYplaceholderLabelTextColor_2{
    if (!_ZYplaceholderLabelTextColor_2) {
        _ZYplaceholderLabelTextColor_2 = self.textColor;
    }return _ZYplaceholderLabelTextColor_2;
}

-(UIFont *)ZYplaceholderLabelFont_1{
    if (!_ZYplaceholderLabelFont_1) {
        _ZYplaceholderLabelFont_1 = self.font;
    }return _ZYplaceholderLabelFont_1;
}

-(UIFont *)ZYplaceholderLabelFont_2{
    if (!_ZYplaceholderLabelFont_2) {
        _ZYplaceholderLabelFont_2 = self.font;
    }return _ZYplaceholderLabelFont_2;
}

-(CGFloat)offset{
    if (_offset == 0) {
        _offset = 30;
    }return _offset;
}

-(CGFloat)leftViewOffsetX{
    if (_leftViewOffsetX == 0) {
        _leftViewOffsetX = 5;
    }return _leftViewOffsetX;
}

-(CGFloat)rightViewOffsetX{
    if (_rightViewOffsetX == 0) {
        _rightViewOffsetX = 5;
    }return _rightViewOffsetX;
}

-(CGFloat)ZYTextFieldBorderWidth{
    if (_ZYTextFieldBorderWidth == 0) {
        _ZYTextFieldBorderWidth = 1;
    }return _ZYTextFieldBorderWidth;
}

-(UIColor *)ZYTextFieldBorderColor{
    if (!_ZYTextFieldBorderColor) {
        _ZYTextFieldBorderColor = kBlackColor;
    }return _ZYTextFieldBorderColor;
}
#pragma mark - UITextFieldTextDidBeginEditingNotification
- (void)kd_textFieldDidBeginEditing:(NSNotification *)notification {
    CAKeyframeAnimation *kfAnimation11 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size.width"];
    kfAnimation11.fillMode = kCAFillModeForwards;
    kfAnimation11.removedOnCompletion = NO;
    kfAnimation11.values = @[@0,@(self.bounds.size.width)];
    kfAnimation11.duration = 0.25f;
    kfAnimation11.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_lineView.layer addAnimation:kfAnimation11 forKey:@"kKDLienViewWidth"];
    
    if (![self.text isEqualToString:@""]) {
        return;
    }
    if (!_placeholderCacheLabel) {
        [self addSubview:self.placeholderCacheLabel];
        _placeholderCacheLabel.attributedText = self.attributedPlaceholder;
        self.cachedPlaceholder = self.attributedPlaceholder;
    }
    self.placeholder = nil;
    _placeholderCacheLabel.hidden = NO;

    CAKeyframeAnimation *kfAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfAnimation1.fillMode = kCAFillModeForwards;
    kfAnimation1.removedOnCompletion = NO;
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.1, 1.1, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    kfAnimation1.values = @[[NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3]];
    
    CAKeyframeAnimation *kfAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.origin"];
    kfAnimation2.fillMode = kCAFillModeForwards;
    kfAnimation2.removedOnCompletion = NO;
    kfAnimation2.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(0, 52)]];//这里调整高度
    
    CAAnimationGroup *grouoAnimation = [CAAnimationGroup animation];
    grouoAnimation.animations = @[kfAnimation1,kfAnimation2];
    grouoAnimation.fillMode = kCAFillModeForwards;
    grouoAnimation.removedOnCompletion = NO;
    grouoAnimation.duration = 0.25;
    grouoAnimation.delegate = self;
    [_placeholderCacheLabel.layer addAnimation:grouoAnimation forKey:@"kKDOutAnimation"];
    
}
#pragma mark - UITextFieldTextDidEndEditingNotification
- (void)kd_textFieldDidEndEditing:(NSNotification *)notification {
    CAKeyframeAnimation *kfAnimation11 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    kfAnimation11.fillMode = kCAFillModeForwards;
    kfAnimation11.removedOnCompletion = NO;
    kfAnimation11.values = @[@1,@0];
    kfAnimation11.duration = 0.25f;
    kfAnimation11.delegate = self;
    [_lineView.layer addAnimation:kfAnimation11 forKey:@"kKDLienViewOpactity"];
    
    CAKeyframeAnimation *kfAnimation12 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    kfAnimation12.fillMode = kCAFillModeForwards;
    kfAnimation12.removedOnCompletion = NO;
    kfAnimation12.values = @[@0,@1];
    kfAnimation12.duration = 0.25f;
    kfAnimation12.delegate = self;
    [_grayLineView.layer addAnimation:kfAnimation12 forKey:@"kKDGrayLienViewOpactity"];

    if (![self.text isEqualToString:@""]) {
        return;
    }
    
    CAKeyframeAnimation *kfAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfAnimation1.fillMode = kCAFillModeForwards;
    kfAnimation1.removedOnCompletion = NO;
    CATransform3D scale1 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.1, 1.1, 1);
    CATransform3D scale3 = CATransform3DMakeScale(1.0, 1.0, 1);
    kfAnimation1.values = @[[NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3]];
    
    CAKeyframeAnimation *kfAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"bounds.origin"];
    kfAnimation2.fillMode = kCAFillModeForwards;
    kfAnimation2.removedOnCompletion = NO;
    kfAnimation2.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 22)],[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    
    CAAnimationGroup *grouoAnimation = [CAAnimationGroup animation];
    grouoAnimation.animations = @[kfAnimation1,kfAnimation2];
    grouoAnimation.fillMode = kCAFillModeForwards;
    grouoAnimation.removedOnCompletion = NO;
    grouoAnimation.duration = 0.25;
    grouoAnimation.delegate = self;
    [_placeholderCacheLabel.layer addAnimation:grouoAnimation forKey:@"kZYYInAnimation"];
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim
                finished:(BOOL)flag{
    if (flag) {
        if (anim == [_placeholderCacheLabel.layer animationForKey:@"kZYYInAnimation"] ) {
            _placeholderCacheLabel.hidden = YES;
            self.attributedPlaceholder = self.cachedPlaceholder;
        } else if (anim == [_lineView.layer animationForKey:@"kZYYLienViewOpactity"]) {
            CGRect frame = _lineView.frame;
            frame.size.width = 0;
            _lineView.frame = frame;
            _lineView.alpha = 1;
            _grayLineView.alpha = 0;
            [_lineView.layer removeAllAnimations];
        }
    }
}
#pragma mark - Setter & Getter
- (UILabel *)placeholderCacheLabel {
    if (!_placeholderCacheLabel) {
        _placeholderCacheLabel = UILabel.new;
//        _placeholderCacheLabel.backgroundColor = kRedColor;
        _placeholderCacheLabel.layer.anchorPoint = CGPointZero;
        _placeholderCacheLabel.frame = CGRectMake(0,
                                                  0,
                                                  self.bounds.size.width,
                                                  self.bounds.size.height);
    }return _placeholderCacheLabel;
}

@end
