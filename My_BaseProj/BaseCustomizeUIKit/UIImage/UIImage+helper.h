//
//  UIImage+helper.h
//  jandaobao
//
//  Created by 杨志刚 on 15/6/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

@interface UIImage(helper)

+(UIImage *)createRRcode:(NSString *)sourceString;
+ (UIImage *)createNonInterpolatedUIImageFormString:(NSString *)string withSize:(CGFloat) size;
//根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (NSData *)imageZipToData:(UIImage *)newImage;
@end
