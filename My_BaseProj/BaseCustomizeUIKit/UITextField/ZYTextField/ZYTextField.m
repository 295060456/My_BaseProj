
#import "ZYTextField.h"

@implementation ZYTextField
//通过代码创建
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }return self;
}
//通过xib创建
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUpUI];
}
// 重写此方法
-(void)drawPlaceholderInRect:(CGRect)rect {
    // 计算占位文字的 Size
    CGSize placeholderSize = [self.placeholder sizeWithAttributes:
                              @{NSFontAttributeName : self.font}];
    [self.placeholder drawInRect:CGRectMake(0,
                                            (rect.size.height - placeholderSize.height) / 2,
                                            rect.size.width,
                                            rect.size.height)
                  withAttributes:@{NSForegroundColorAttributeName : kWhiteColor,
                                   NSFontAttributeName : self.font}];
}

- (void)setUpUI{
//    设置border
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 22;
//    self.backgroundColor = Default_FontColor;
//    self.layer.borderColor = [UIColor blackColor].CGColor;
//    self.layer.borderWidth = 1;
    //字体大小
    self.font = [UIFont fontWithName:@"PingFangSC"
                                size: 17];
    //字体颜色
    self.textColor = RGBCOLOR(77,
                              150,
                              132);
    //光标颜色
    self.tintColor = self.textColor;
    //占位符的颜色和大小
    UILabel *placeholderLabel = object_getIvar(self,
                                               class_getInstanceVariable([UITextField class],
                                                                         "_placeholderLabel"));
    placeholderLabel.textColor = RGBCOLOR(167,
                                          167,
                                          167);
    placeholderLabel.font = [UIFont boldSystemFontOfSize:15];
    
    // 不成为第一响应者
    [self resignFirstResponder];
}
/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder{
    // 修改占位文字颜色
    UILabel *placeholderLabel = object_getIvar(self,
                                               class_getInstanceVariable([UITextField class],
                                                                         "_placeholderLabel"));
    placeholderLabel.textColor = self.textColor;
    return [super becomeFirstResponder];
}
/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder{
    // 修改占位文字颜色
    UILabel *placeholderLabel = object_getIvar(self,
                                               class_getInstanceVariable([UITextField class],
                                                                         "_placeholderLabel"));
    placeholderLabel.textColor = COLOR_RGB(131, 145, 175, 1);
    return [super resignFirstResponder];
}
//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + 15,
                              bounds.origin.y,
                              bounds.size.width -15,
                              bounds.size.height);
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + 15,
                              bounds.origin.y,
                              bounds.size.width - 15,
                              bounds.size.height);
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + 15,
                              bounds.origin.y,
                              bounds.size.width - 15,
                              bounds.size.height);
    return inset;
}

@end
