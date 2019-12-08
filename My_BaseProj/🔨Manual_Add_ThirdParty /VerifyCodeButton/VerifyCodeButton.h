//
//  VerifyCodeButton.h
//  ShengAi
//
//  Created by 刘赓 on 2018/12/12.
//  Copyright © 2018 刘赓. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ShowTimeType_SS = 0,//秒
    ShowTimeType_MMSS,//分秒
    ShowTimeType_HHMMSS,//时分秒
} ShowTimeType;

NS_ASSUME_NONNULL_BEGIN

@interface VerifyCodeButton : UIButton

@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,copy)NSString *titleBeginStr;
@property(nonatomic,copy)NSString *titleRuningStr;
@property(nonatomic,copy)NSString *titleEndStr;
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,strong)UIColor *bgBeginColor;
@property(nonatomic,strong)UIColor *bgEndColor;
@property(nonatomic,strong)UIColor *layerBorderColor;
@property(nonatomic,strong)UIFont *titleLabelFont;
@property(nonatomic,assign)CGFloat layerCornerRadius;
@property(nonatomic,assign)CGFloat layerBorderWidth;
@property(nonatomic,assign)ShowTimeType showTimeType;

- (void)timeFailBeginFrom:(NSInteger)timeCount;//倒计时时间次数


@end

NS_ASSUME_NONNULL_END
