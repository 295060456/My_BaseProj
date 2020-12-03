//
//  ImageCodeView.h
//  XLVerCodeView
//
//  Created by Mac-Qke on 2019/7/9.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageCodeView : UIView

@property(nonatomic,copy)NSArray *CodeArr;//乱字符的基本构成元素
@property(nonatomic,copy)__block NSString *CodeStr;//外界传来的乱字符元素

@property(nonatomic,strong)__block NSString *captchaKey;

@property(nonatomic,strong)UIColor *color;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIColor *bgColor;//外界不传值定义内部即用随机色彩

@end

NS_ASSUME_NONNULL_END
