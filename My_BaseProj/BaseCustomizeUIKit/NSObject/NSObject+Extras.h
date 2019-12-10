//
//  NSObject+Extras.h
//  TestDemo
//
//  Created by AaltoChen on 15/10/31.
//  Copyright © 2015年 AaltoChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extras)
//判断类型是否匹配
+(BOOL)isNSStringClass:(id)object;
+(BOOL)isNSDictionaryClass:(id)object;
+(BOOL)isNSNumberClass:(id)object;
+(BOOL)isNSNullClass:(id)object;
+(BOOL)isNSArrayClass:(id)object;

/**
 *  判断是否当日第一次启动App
 */
+(BOOL)isFirstLaunchApp;

/**
 文本转图像
 */
+ (UIImage *)imageWithString:(NSString *)string
                        font:(UIFont *)font
                       width:(CGFloat)width
               textAlignment:(NSTextAlignment)textAlignment
             backGroundColor:(UIColor *)backGroundColor
                   textColor:(UIColor *)textColor;
/**
 *  UIColor 转 UIImage
 */
+(UIImage*)createImageWithColor:(UIColor*)color;

- (NSString *)stringForValue:(id)value;
- (BOOL)boolForValue:(id)value;
- (float)floatForValue:(id)value;
- (int)intForValue:(id)value;
-(NSString*)convertNull:(id)object;//转换空串
-(BOOL)isNull:(id)object;//判断是否为空串

- (void) showLoad:(NSString *) msg;

- (void) hideLoad;
@end
