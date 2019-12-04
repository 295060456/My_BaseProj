//
//  VerifyCodeButton.m
//  ShengAi
//
//  Created by 刘赓 on 2018/12/12.
//  Copyright © 2018 刘赓. All rights reserved.
//

#import "VerifyCodeButton.h"

@interface VerifyCodeButton ()

@property(nonatomic,assign)long count;

@end

//获取验证码 —— 倒计时
@implementation VerifyCodeButton

-(void)dealloc{
   [self.timer invalidate];
}

-(instancetype)init{
    if ([super init]) {
    [self setTitle:self.titleBeginStr
          forState:UIControlStateNormal];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    self.backgroundColor = self.bgBeginColor;
    self.layer.borderColor = self.layerBorderColor.CGColor;
    self.layer.cornerRadius = self.layerCornerRadius;
    self.titleLabel.font = self.titleLabelFont;
    self.titleColor = self.titleColor;
    self.layer.borderWidth = self.layerBorderWidth;
    [self.titleLabel sizeToFit];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

//倒计时方法:
- (void)timeFailBeginFrom:(NSInteger)timeCount{
    [self setTitle:self.titleBeginStr
          forState:UIControlStateNormal];
    self.count = timeCount;
    self.enabled = NO;
    // 加1个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(timerFired)
                                                userInfo:nil
                                                 repeats:YES];
}
//计时器方法:
- (void)timerFired {
    if (self.count != 1) {
        self.count -= 1;
        self.enabled = NO;
        NSString *countStr;
        NSString *str;
        switch (self.showTimeType) {
            case ShowTimeType_SS:{
                //不做任何处理
                str = [NSString stringWithFormat:@"剩余%ld秒", self.count];
            }break;
            case ShowTimeType_MMSS:{
                countStr = [self getMMSSFromStr:[NSString stringWithFormat:@"%ld",self.count]];
                str = [@"剩余时间" stringByAppendingString:countStr];
            }break;
            case ShowTimeType_HHMMSS:{
                countStr = [self getHHMMSSFromStr:[NSString stringWithFormat:@"%ld",self.count]];
                str = [@"剩余时间" stringByAppendingString:countStr];
            }break;
            default:
                str = @"异常值";
                break;
        }
        [self setTitle:str
              forState:UIControlStateNormal];
    } else {
        self.enabled = YES;
        [self setTitle:self.titleEndStr
              forState:UIControlStateNormal];
        self.backgroundColor = self.bgEndColor;
        [self.timer invalidate];
    }
}

-(UIColor *)bgBeginColor{
    if (!_bgBeginColor) {
        _bgBeginColor = [UIColor lightGrayColor];
    }return _bgBeginColor;
}

-(UIColor *)titleColor{
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }return _titleColor;
}

-(UIColor *)layerBorderColor{
    if (!_layerBorderColor) {
        _layerBorderColor = [UIColor whiteColor];//CGColor
    }return _layerBorderColor;
}

-(UIFont *)titleLabelFont{
    if (!_titleLabelFont) {
        if (@available(iOS 8.2, *)) {
            _titleLabelFont = [UIFont systemFontOfSize:11.f
                                                weight:1];
        } else {
            // Fallback on earlier versions
        }
    }return _titleLabelFont;
}

-(CGFloat)layerCornerRadius{
    if (!_layerCornerRadius) {
       
        _layerCornerRadius = self.frame.size.height / 2;
    }return _layerCornerRadius;
}

-(CGFloat)layerBorderWidth{
    if (!_layerBorderWidth) {
        _layerBorderWidth = .5f;
    }return _layerBorderWidth;
}

-(NSString *)titleBeginStr{
    if (!_titleBeginStr) {
        _titleBeginStr = @"开始";
    }return _titleBeginStr;
}

-(NSString *)titleEndStr{
    if (!_titleEndStr) {
        _titleEndStr = @"取消";
    }return _titleEndStr;
}

-(UIColor *)bgEndColor{
    if (!_bgEndColor) {
        _bgEndColor = [UIColor orangeColor];
    }return _bgEndColor;
}

-(ShowTimeType)showTimeType{
    if (!_showTimeType) {
        _showTimeType = ShowTimeType_SS;//默认只显示秒
    }return _showTimeType;
}

//传入 秒  得到 xx:xx:xx
-(NSString *)getHHMMSSFromStr:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds / 3600];//format of hour
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds % 3600) / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];//format of time
    NSLog(@"format_time : %@",format_time);
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

@end
