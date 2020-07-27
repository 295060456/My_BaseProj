//
//  UIImage+helper.m
//  jandaobao
//
//  Created by 杨志刚 on 15/6/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIImage+helper.h"

@implementation UIImage(helper)

+(UIImage *)createRRcode: (NSString *)sourceString
{
    //1.实例化一个滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //1.1>设置filter的默认值
    //因为之前如果使用过滤镜，输入有可能会被保留，因此，在使用滤镜之前，最好恢复默认设置
    [filter setDefaults];
    
    //2将传入的字符串转换为NSData
    NSData *data = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.将NSData传递给滤镜（通过KVC的方式，设置inputMessage）
    [filter setValue:data forKey:@"inputMessage"];
    
    //4.由filter输出图像
    CIImage *outputImage = [filter outputImage];
    
    //5.将CIImage转换为UIImage
    UIImage *qrImage = [UIImage imageWithCIImage:outputImage];
    
    //6.返回二维码图像
    return qrImage;
}

+ (UIImage *)createNonInterpolatedUIImageFormString:(NSString *)string withSize:(CGFloat) size{
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[string dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    CGRect extent = CGRectIntegral(outputImage.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

/**
 *  压缩图片
 */
+ (NSData *)imageZipToData:(UIImage *)newImage{
    
    NSData *data = UIImageJPEGRepresentation(newImage, 1.0);
    
    if (data.length > 500 * 1024) {
        
        if (data.length>1024 * 1024) {//1M以及以上
            
            data = UIImageJPEGRepresentation(newImage, 0.5);
            
        }else if (data.length>512*1024) {//0.5M-1M
            
            data=UIImageJPEGRepresentation(newImage, 0.6);
            
        }else if (data.length>200*1024) { //0.25M-0.5M
            
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}


@end
