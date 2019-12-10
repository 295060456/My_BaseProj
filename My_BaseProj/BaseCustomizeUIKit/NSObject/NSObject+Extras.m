

//
//  NSObject+Extras.m
//  TestDemo
//
//  Created by AaltoChen on 15/10/31.
//  Copyright © 2015年 AaltoChen. All rights reserved.
//

#import "NSObject+Extras.h"

@implementation NSObject (Extras)

+ (UIImage *)imageWithString:(NSString *)string
                        font:(UIFont *)font
                       width:(CGFloat)width
               textAlignment:(NSTextAlignment)textAlignment
             backGroundColor:(UIColor *)backGroundColor
                   textColor:(UIColor *)textColor{
    
    NSDictionary *attributeDic = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, 10000)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                    attributes:attributeDic
                                       context:nil].size;
    if ([UIScreen.mainScreen respondsToSelector:@selector(scale)]){
        if (UIScreen.mainScreen.scale == 2.0){
            UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
        } else{
            UIGraphicsBeginImageContext(size);
        }
    }
    else{
        UIGraphicsBeginImageContext(size);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    [backGroundColor set];
    CGRect rect = CGRectMake(0,
                             0,
                             size.width + 1,
                             size.height + 1);
    CGContextFillRect(context, rect);
    NSMutableParagraphStyle *paragraph = NSMutableParagraphStyle.new;
    paragraph.alignment = textAlignment;
    NSDictionary *attributes = @ {
    NSForegroundColorAttributeName:textColor,
    NSFontAttributeName:font,
    NSParagraphStyleAttributeName:paragraph
    };
    [string drawInRect:rect
        withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  UIColor 转 UIImage
 */
+(UIImage*)createImageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f,
                           0.0f,
                           1.0f,
                           1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@end
