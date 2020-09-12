//
//  ImageCodeView.m
//  XLVerCodeView
//
//  Created by Mac-Qke on 2019/7/9.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "ImageCodeView.h"

#define CODE_LENGTH 4
#define ARCNUMBER arc4random() % 100 / 100.0
#define ARC_COLOR [UIColor colorWithRed:ARCNUMBER green:ARCNUMBER blue:ARCNUMBER alpha:0.2]

@interface ImageCodeView ()

@property(nonatomic,strong)UITapGestureRecognizer *changeCodeTap;

@end

@implementation ImageCodeView

@synthesize CodeStr = _CodeStr;//不加这句会报错

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }return self;
}
///兼容nib使用
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}
///设置默认参数
- (void)setupUI{
    self.backgroundColor = ARC_COLOR;
    self.changeCodeTap.enabled = YES;
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:self.font,
                                              NSForegroundColorAttributeName:self.color}];//计算单个字所需空间
    int width = rect.size.width / self.CodeStr.length - cSize.width;//间距
    int height = rect.size.height - cSize.height;//可浮动高度
    CGPoint point;
    //绘码
    float pX, pY;
    for (int i = 0; i < self.CodeStr.length; i++){
        pX = arc4random() % width + rect.size.width / self.CodeStr.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [self.CodeStr characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        [textC drawAtPoint:point
            withAttributes:@{NSFontAttributeName:self.font,
                             NSForegroundColorAttributeName:self.color}];
    }

    //干扰线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    for(int cout = 0; cout < 10; cout++){
        CGContextSetStrokeColorWithColor(context, [ARC_COLOR CGColor]);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }
}
///随机生成验证码字符串
-(void)getStrCode{
    self.backgroundColor = ARC_COLOR;
    NSMutableString *tmpStr = [[NSMutableString alloc] initWithCapacity:5];
    for (int i = 0; i < CODE_LENGTH; i++) {
        NSInteger index = arc4random() % (self.CodeArr.count - 1);
        [tmpStr appendString:[self.CodeArr objectAtIndex:index]];
    }
    _CodeStr = [NSString stringWithFormat:@"%@",tmpStr];
}
///刷新验证码
-(void)changeCode:(UITapGestureRecognizer *)sender{
    @weakify(self)
    [NSObject getAuthCode_networking:^(id data) {
        @strongify(self)
        if ([data isKindOfClass:NSString.class]) {
            NSString *str = (NSString *)data;
            self.CodeStr = str;
            NSLog(@"我是验证码：%@",self.CodeStr);
            [self setNeedsDisplay];
        }
    }];
}

-(void)setCodeStr:(NSString *)CodeStr{
    _CodeStr = CodeStr;
    [self setNeedsDisplay];
}
#pragma mark —— lazyLoad
-(NSString *)CodeStr{
    if (!_CodeStr) {
        [self getStrCode];
    }return _CodeStr;
}

-(NSArray *)CodeArr{
    if (!_CodeArr) {
        _CodeArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    }return _CodeArr;
}

-(UITapGestureRecognizer *)changeCodeTap{
    if (!_changeCodeTap) {
        _changeCodeTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(changeCode:)];
        [self addGestureRecognizer:_changeCodeTap];
    }return _changeCodeTap;
}

-(UIColor *)color{
    if (!_color) {
        _color = kWhiteColor;
    }return _color;
}

-(UIFont *)font{
    if (!_font) {
        _font = [UIFont systemFontOfSize:9.6
                                  weight:UIFontWeightRegular];
    }return _font;
}

@end
