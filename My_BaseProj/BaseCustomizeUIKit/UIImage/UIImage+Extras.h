//
//  UIImage+Extras.h

//
//  Created by Aalto on 2018/12/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extras)

/**
 根据颜色生成图片
 
 @param color 颜色
 @return --
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 根据颜色生成图片
 
 @param color 颜色
 @param rect 大小
 @return --
 */
+ (UIImage *)imageWithColor:(UIColor *)color
                       rect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
