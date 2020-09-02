//
//  UIButton+CountDownBtn.m
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIButton+CountDownBtn.h"
#import <objc/runtime.h>

@implementation UIButton (CountDownBtn)

static char *UIButton_CountDownBtn_nsTimerManager = "UIButton_CountDownBtn_nsTimerManager";
static char *UIButton_CountDownBtn_titleBeginStr = "UIButton_CountDownBtn_titleBeginStr";
static char *UIButton_CountDownBtn_titleRuningStr = "UIButton_CountDownBtn_titleRuningStr";
static char *UIButton_CountDownBtn_titleEndStr = "UIButton_CountDownBtn_titleEndStr";
static char *UIButton_CountDownBtn_titleColor = "UIButton_CountDownBtn_titleColor";
static char *UIButton_CountDownBtn_bgCountDownColor = "UIButton_CountDownBtn_bgCountDownColor";
static char *UIButton_CountDownBtn_bgEndColor = "UIButton_CountDownBtn_bgEndColor";
static char *UIButton_CountDownBtn_layerBorderColor = "UIButton_CountDownBtn_layerBorderColor";
static char *UIButton_CountDownBtn_titleLabelFont = "UIButton_CountDownBtn_titleLabelFont";
static char *UIButton_CountDownBtn_layerCornerRadius = "UIButton_CountDownBtn_layerCornerRadius";
static char *UIButton_CountDownBtn_layerBorderWidth = "UIButton_CountDownBtn_layerBorderWidth";
static char *UIButton_CountDownBtn_showTimeType = "UIButton_CountDownBtn_showTimeType";
static char *UIButton_CountDownBtn_count = "UIButton_CountDownBtn_count";
static char *UIButton_CountDownBtn_countDownBlock = "UIButton_CountDownBtn_countDownBlock";

@dynamic nsTimerManager;
@dynamic titleBeginStr;
@dynamic titleRuningStr;
@dynamic titleEndStr;
@dynamic titleColor;
@dynamic bgCountDownColor;
@dynamic bgEndColor;
@dynamic layerBorderColor;
@dynamic titleLabelFont;
@dynamic layerCornerRadius;
@dynamic layerBorderWidth;
@dynamic showTimeType;
@dynamic count;
@dynamic countDownBlock;

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self setTitle:self.titleBeginStr
          forState:UIControlStateNormal];
    
    self.layer.borderColor = self.layerBorderColor.CGColor;
    self.layer.cornerRadius = self.layerCornerRadius;
    self.titleLabel.font = self.titleLabelFont;
    self.layer.borderWidth = self.layerBorderWidth;
    [self setTitleColor:self.titleColor forState:UIControlStateNormal];
    [self.titleLabel sizeToFit];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

-(void)actionCountDownBlock:(MKDataBlock)countDownBlock{
    self.countDownBlock = countDownBlock;
}
//倒计时方法:
-(void)timeFailBeginFrom:(NSInteger)timeCount{
    [self setTitle:self.titleBeginStr
          forState:UIControlStateNormal];
    self.count = timeCount;
    self.enabled = NO;
    //创建方式——1
//    [NSTimerManager nsTimeStart:self.nsTimerManager.nsTimer
//                    withRunLoop:nil];
    //创建方式——2
    [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
    
}
//
-(void)timerRuning{
    self.enabled = NO;
    NSString *countStr;
    NSString *str;
    switch (self.showTimeType) {
        case ShowTimeType_SS:{
            //不做任何处理
            str = [NSString stringWithFormat:@"%@%ld秒",self.titleRuningStr,self.count];
        }break;
        case ShowTimeType_MMSS:{
            countStr = [self getMMSSFromStr:[NSString stringWithFormat:@"%ld",self.count]];
            str = [self.titleRuningStr stringByAppendingString:countStr];
        }break;
        case ShowTimeType_HHMMSS:{
            countStr = [self getHHMMSSFromStr:[NSString stringWithFormat:@"%ld",self.count]];
            str = [self.titleRuningStr stringByAppendingString:countStr];
        }break;
        default:
            str = @"异常值";
            break;
    }
    [self setTitle:str
          forState:UIControlStateNormal];
    self.backgroundColor = self.bgCountDownColor;
}

-(void)timerDestroy{
    self.enabled = YES;
    [self setTitle:self.titleEndStr
          forState:UIControlStateNormal];
    self.backgroundColor = self.bgEndColor;
    [self.nsTimerManager nsTimeDestroy];
}
//传入 秒  得到 xx:xx:xx
-(NSString *)getHHMMSSFromStr:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds / 3600];//format of hour
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds % 3600) / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];//format of time
//    NSLog(@"format_time : %@",format_time);
    return format_time;
}
//传入 秒  得到  xx分钟xx秒
-(NSString *)getMMSSFromStr:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@分钟%@秒",str_minute,str_second];//format of time
    NSLog(@"format_time : %@",format_time);
    return format_time;
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)NSTimerManager *nsTimerManager;
-(NSTimerManager *)nsTimerManager{
    NSTimerManager *timerManager = objc_getAssociatedObject(self, UIButton_CountDownBtn_nsTimerManager);
    if (!timerManager) {
        timerManager = NSTimerManager.new;
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_nsTimerManager,
                                 timerManager,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    timerManager.timerStyle = TimerStyle_anticlockwise;
    timerManager.anticlockwiseTime = self.count;
    
    @weakify(self)
    [timerManager actionNSTimerManagerRunningBlock:^(id data) {
        @strongify(self)
        NSLog(@"你好");
        [self timerRuning];
        if (self.countDownBlock) {
            self.countDownBlock(@1);
        }
    }];
    
    [timerManager actionNSTimerManagerFinishBlock:^(id data) {
        [self timerDestroy];
    }];
    
    return timerManager;
}

-(void)setNsTimerManager:(NSTimerManager *)nsTimerManager{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_nsTimerManager,
                             nsTimerManager,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)NSString *titleBeginStr;
-(NSString *)titleBeginStr{
    NSString *TitleBeginStr = objc_getAssociatedObject(self, UIButton_CountDownBtn_titleBeginStr);
    if (!TitleBeginStr) {
        TitleBeginStr = @"开始";
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_titleBeginStr,
                                 TitleBeginStr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TitleBeginStr;
}

-(void)setTitleBeginStr:(NSString *)titleBeginStr{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_titleBeginStr,
                             titleBeginStr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)NSString *titleRuningStr;//倒计时过程中显示的非时间文字
-(NSString *)titleRuningStr{
    NSString *TitleRuningStr = objc_getAssociatedObject(self, UIButton_CountDownBtn_titleRuningStr);
    if (!TitleRuningStr) {
        TitleRuningStr = @"开始1";
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_titleRuningStr,
                                 TitleRuningStr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TitleRuningStr;
}

-(void)setTitleRuningStr:(NSString *)titleRuningStr{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_titleRuningStr,
                             titleRuningStr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *titleEndStr;
-(NSString *)titleEndStr{
    NSString *TitleEndStr = objc_getAssociatedObject(self, UIButton_CountDownBtn_titleEndStr);
    if (!TitleEndStr) {
        TitleEndStr = @"结束";
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_titleEndStr,
                                 TitleEndStr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TitleEndStr;
}

-(void)setTitleEndStr:(NSString *)titleEndStr{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_titleEndStr,
                             titleEndStr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *titleColor;
-(UIColor *)titleColor{
    UIColor *TitleColor = objc_getAssociatedObject(self, UIButton_CountDownBtn_titleColor);
    if (!TitleColor) {
        TitleColor = [UIColor redColor];
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_titleColor,
                                 TitleColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TitleColor;
}

-(void)setTitleColor:(UIColor *)titleColor{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_titleColor,
                             titleColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *bgCountDownColor;//倒计时的时候此btn的背景色
-(UIColor *)bgCountDownColor{
    UIColor *BgCountDownColor = objc_getAssociatedObject(self, UIButton_CountDownBtn_bgCountDownColor);
    if (!BgCountDownColor) {
        BgCountDownColor = [UIColor redColor];
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_bgCountDownColor,
                                 BgCountDownColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BgCountDownColor;
}

-(void)setBgCountDownColor:(UIColor *)bgCountDownColor{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_bgCountDownColor,
                             bgCountDownColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *bgEndColor;//倒计时完全结束后的背景色
-(UIColor *)bgEndColor{
    UIColor *BgEndColor = objc_getAssociatedObject(self, UIButton_CountDownBtn_bgEndColor);
    if (!BgEndColor) {
        BgEndColor = [UIColor redColor];
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_bgEndColor,
                                 BgEndColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BgEndColor;
}

-(void)setBgEndColor:(UIColor *)bgEndColor{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_bgEndColor,
                             bgEndColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *layerBorderColor;
-(UIColor *)layerBorderColor{
    UIColor *LayerBorderColor = objc_getAssociatedObject(self, UIButton_CountDownBtn_layerBorderColor);
    if (!LayerBorderColor) {
        LayerBorderColor = [UIColor redColor];
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_layerBorderColor,
                                 LayerBorderColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return LayerBorderColor;
}

-(void)setLayerBorderColor:(UIColor *)layerBorderColor{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_layerBorderColor,
                             layerBorderColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIFont *titleLabelFont;
-(UIFont *)titleLabelFont{
    UIFont *TitleLabelFont = objc_getAssociatedObject(self, UIButton_CountDownBtn_titleLabelFont);
    if (!TitleLabelFont) {
        TitleLabelFont = [UIFont systemFontOfSize:12];////////////////
        objc_setAssociatedObject(self,
                                 UIButton_CountDownBtn_titleLabelFont,
                                 TitleLabelFont,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TitleLabelFont;
}

-(void)setTitleLabelFont:(UIFont *)titleLabelFont{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_titleLabelFont,
                             titleLabelFont,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)CGFloat layerCornerRadius;
-(CGFloat)layerCornerRadius{
    return [objc_getAssociatedObject(self, UIButton_CountDownBtn_layerCornerRadius) floatValue];
}

-(void)setLayerCornerRadius:(CGFloat)layerCornerRadius{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_layerCornerRadius,
                             [NSNumber numberWithFloat:layerCornerRadius],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)CGFloat layerBorderWidth;
-(CGFloat)layerBorderWidth{
    return [objc_getAssociatedObject(self, UIButton_CountDownBtn_layerBorderWidth) floatValue];
}

-(void)setLayerBorderWidth:(CGFloat)layerBorderWidth{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_layerBorderWidth,
                             [NSNumber numberWithFloat:layerBorderWidth],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)ShowTimeType showTimeType;
-(ShowTimeType)showTimeType{
    return [objc_getAssociatedObject(self, UIButton_CountDownBtn_showTimeType) integerValue];
}

-(void)setShowTimeType:(ShowTimeType)showTimeType{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_showTimeType,
                             [NSNumber numberWithInteger:showTimeType],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,assign)long count;
-(long)count{
    return [objc_getAssociatedObject(self, UIButton_CountDownBtn_count) longValue];
}

-(void)setCount:(long)count{
    if (count == 0) {
        count = 3;
    }
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_count,
                             [NSNumber numberWithLong:count],
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock countDownBlock;
-(MKDataBlock)countDownBlock{
    return objc_getAssociatedObject(self, UIButton_CountDownBtn_countDownBlock);
}

-(void)setCountDownBlock:(MKDataBlock)countDownBlock{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_countDownBlock,
                             countDownBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
 
