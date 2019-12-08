//
//  NSString+YBCodec.m
//  Aa
//
//  Created by Aalto on 2018/11/20.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "NSString+Extras.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extras)

-(NSString *)test:(NSArray <NSString *>*)arr{
    NSString *resultStr;
    for (int i = 0; i < arr.count; i++) {
        NSString *tempStr = arr[i];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"/" withString:@""];//去除字符 /
        [resultStr stringByAppendingString:[NSString stringWithFormat:@"/%@",tempStr]];
    }return resultStr;
}

/**
 *  判断对象 / 数组是否为空
 *  为空返回 YES
 *  不为空返回 NO
 */
+(BOOL)isEmptyStr:(NSString *)value{

    if (value == nil ||
        value == NULL) return YES;

    if((NSNull *)value == [NSNull null]) return YES;

    if ([value isKindOfClass:[NSString class]]){
        if (((NSString *)value).length > 0){
            if ([value isEqualToString:@"(null)"]||
                [value isEqualToString:@"null"]||
                [value isEqualToString:@"<null>"]) return YES;
        } else return YES;
    } return NO;
}


/*
 分开来注释一下：
 ^ 匹配一行的开头位置
 (?![0-9]+$) 预测该位置后面不全是数字
 (?![a-zA-Z]+$) 预测该位置后面不全是字母
 [0-9A-Za-z] {8,16} 由8-16位数字或这字母组成
 $ 匹配行结尾位置
 
 注：(?!xxxx) 是正则表达式的负向零宽断言一种形式，标识预该位置后不是xxxx字符。
 https:blog.csdn.net/w6524587/article/details/56279494
密码(以字母开头，长度在6~18之间，只能包含字母、数字和下划线)：
 ^[a-zA-Z]\w{5,17}$
强密码(必须包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间)：
 ^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$

 */
+(BOOL)isContainAllCharType:(NSString*)originString{
    
    NSString * regex = @"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{4,16}$";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

//    NSString * regexLower = @"[a-z]+$";
//
//    NSPredicate *predLower = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexLower];
//
//    NSString * regexNumber = @"[^0-9]+$";
//
//    NSPredicate *predNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexNumber];
    
    BOOL isMatch = ([pred evaluateWithObject:originString]
                    );//&&[predLower evaluateWithObject:originString]
//    &&![predNumber evaluateWithObject:originString]
    return isMatch;
    
//    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z0-9]*" options:NSRegularExpressionCaseInsensitive error:nil];
//    NSInteger count = [numberRegular numberOfMatchesInString:originString options:NSMatchingReportProgress range:NSMakeRange(0, originString.length)];//count是str中包含[A-Za-z0-9]数字的个数，只要count>0，说明str中包含数字
//    if (count > 0) {
//        return YES;
//
//    }
//    return NO;
}

// 判断纯整数
+(BOOL)judgeiphoneNumberInt:(NSString *)number{
    
    NSScanner *scan = [NSScanner scannerWithString:number];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (NSString *)MD5WithString:(NSString *)string
                isLowercase:(BOOL)isLowercase{
    
    string = [NSString stringWithFormat:@"*bub#{%@}#fly*",string];
    
    //传入参数,转化成char
    const char* str = [string UTF8String];
    //开辟一个16字节的空间
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    /*
     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
     */
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [ret appendFormat:@"%02X",result[i]];
    }
    
    NSString *finalStr = Nil;
    
    if (isLowercase) {
        
        finalStr = [ret lowercaseString];
    }else{
        
        finalStr = [ret uppercaseString];
    }
    
    return finalStr;
}


- (BOOL)match:(NSString *)express {
    return [self isMatchedByRegex:express];
}

+ (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int value;
    return [scan scanInt:&value] && [scan isAtEnd];
}


+(BOOL)isHaveWhiteSpace:(NSString *)text
{
    NSRange _range = [text rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return true;
    }else {
        
        //没有空格
        return false;
    }
//    return false;
}

+(NSString* )getTimeString:(NSString *)timeStampString{
    // timeStampString 是服务器返回的13位时间戳
    // iOS 生成的时间戳是10位
    
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+(BOOL)isEmpty:(NSString *)string{
    if (string == nil ||
        string == NULL ||
        [string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    string = StringFormat(@"%@",string);
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    string = [string stringByTrimmingCharactersInSet:whitespace];
    if (string.length == 0) {
        return YES;
    }return NO;
}

+(id)isValueNSStringWith:(NSString *)str{
    NSString *resultStr = nil;
    str =[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([str isEqual:[NSNull null]]
        ||[NSString stringWithFormat:@"%@",str]==nil
        ||[NSString stringWithFormat:@"%@",str].length==0
        ||[[NSString stringWithFormat:@"%@",str] isEqual:@"(null)"]
        ||[[NSString stringWithFormat:@"%@",str] isEqual:@"*null*"]
        ||[[NSString stringWithFormat:@"%@",str] isEqual:@"null"]
        ||[str stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0
        ) {
        resultStr = @"";
    }else{
        resultStr = [NSString stringWithFormat:@"%@",str];
    }
    return resultStr;
}

+ (NSString*)fliterLeadingZeroInString:(NSString*)originString{
    if (originString.length>0) {
        NSMutableArray* carries = [NSMutableArray array];
        for (int i=0; i<originString.length; i++) {
            char s = [originString characterAtIndex:i];
            if(s == '0'){
                NSString *tempString = [NSString stringWithUTF8String:&s];
                [carries addObject:tempString];
            }
        }
    }
    return NO;
}

+ (BOOL)isAllZeroInString:(NSString*)originString{
    if (originString.length>0) {
        NSMutableArray* carries = [NSMutableArray array];
        for (int i=0; i<originString.length; i++) {
            char s = [originString characterAtIndex:i];
            if(s == '0'){
                NSString *tempString = [NSString stringWithUTF8String:&s];
                [carries addObject:tempString];
            }
        }
        if (carries.count == originString.length) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}
+ (NSString*)getAnonymousString:(NSString* )originString{
    if (originString.length<2) {
        return originString;
    }
    NSMutableArray* carries = [NSMutableArray array];
    for (int i=1; i<originString.length-1; i++) {
        char s = [originString characterAtIndex:i];
        s = '*';
        NSString *tempString = [NSString stringWithUTF8String:&s];
        [carries addObject:tempString];
    }
    NSString *string = [carries componentsJoinedByString:@""];
    
    NSString *anonymousString = [originString stringByReplacingCharactersInRange:NSMakeRange(1, originString.length-2) withString:string];
    return anonymousString;
    
}
#pragma mark -将秒数转换为字符串格式
+ (NSString *)timeWithSecond:(NSInteger)second{
    NSString *time;
    if (second < 60) {
        time = [NSString stringWithFormat:@"00:%02ld",(long)second];//00:00:%02ld
    }
    else {
        if (second < 3600) {
            time = [NSString stringWithFormat:@"%02ld:%02ld",second/60,second%60];//00:%02ld:%02ld
        }
        else {
            time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",second/3600,(second-second/3600*3600)/60,second%60];
        }
    }
    return time;
}
// 截取字符串方法封装// 截取字符串方法封装
- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString{
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
}
#pragma mark -绘制AttributeString与NSTextAttachment不同大小颜色
+ (NSMutableAttributedString *)attributedReverseStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont numInSubColor:(UIColor*)numInSubColor numInSubFont:(UIFont*)numInSubFont
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"([0-9]\\d*\\.?\\d*)" options:0 error:NULL];//)个
    
    NSArray<NSTextCheckingResult *> *ranges = [regular matchesInString:subString options:0 range:NSMakeRange(0, [subString length])];
    
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor};
    
    NSMutableAttributedString *subAttributedStr = [[NSMutableAttributedString alloc] initWithString:subString attributes:subAttributes];
    
    for (int i = 0; i < ranges.count; i++) {
        [subAttributedStr setAttributes:@{NSForegroundColorAttributeName : numInSubColor,NSFontAttributeName:numInSubFont} range:ranges[i].range];
    }
    
    [subAttributedStr appendAttributedString:attributedStr];
    
    
    return subAttributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont numInSubColor:(UIColor*)numInSubColor numInSubFont:(UIFont*)numInSubFont
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"([0-9]\\d*\\.?\\d*)" options:0 error:NULL];//)个
    
    NSArray<NSTextCheckingResult *> *ranges = [regular matchesInString:subString options:0 range:NSMakeRange(0, [subString length])];
    
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor};
    
    NSMutableAttributedString *subAttributedStr = [[NSMutableAttributedString alloc] initWithString:subString attributes:subAttributes];
    
    for (int i = 0; i < ranges.count; i++) {
        [subAttributedStr setAttributes:@{NSForegroundColorAttributeName : numInSubColor,NSFontAttributeName:numInSubFont} range:ranges[i].range];
    }
    
    [attributedStr appendAttributedString:subAttributedStr];
    
    
    return attributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSMutableAttributedString *subAttributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", subString]];
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor};
    [subAttributedStr setAttributes:subAttributes range:NSMakeRange(0,subAttributedStr.length)];
    
    [attributedStr appendAttributedString:subAttributedStr];
    
    
    return attributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont subStringUnderlineColor:(UIColor*)underlineColor
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:sFont,NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSMutableAttributedString *subAttributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", subString]];
    NSDictionary * subAttributes = @{NSFontAttributeName:subStringFont,NSForegroundColorAttributeName:subStringcolor,NSUnderlineStyleAttributeName:@1,NSUnderlineColorAttributeName:underlineColor};
    [subAttributedStr setAttributes:subAttributes range:NSMakeRange(0,subAttributedStr.length)];
    
    [attributedStr appendAttributedString:subAttributedStr];
    
    
    return attributedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor image:(UIImage *)image
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ ", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSTextAttachment *attachment=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attachment.image=image;
    attachment.bounds=CGRectMake(0,-8 , image.size.width, image.size.height);
    NSAttributedString *imageStr=[NSAttributedString attributedStringWithAttachment:attachment];
    
    
    
    [attributedStr insertAttributedString:imageStr atIndex:0];
    
    
    return attributedStr;
}
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor image:(UIImage *)image isImgPositionOnlyLeft:(BOOL)isOnlyLeft
{
    NSMutableAttributedString *attributedStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@  ", string]];
    NSDictionary * attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:scolor};
    [attributedStr setAttributes:attributes range:NSMakeRange(0,attributedStr.length)];
    
    
    NSTextAttachment *attachment=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attachment.image=image;
    attachment.bounds=CGRectMake(0,-8 , image.size.width, image.size.height);
    NSAttributedString *imageStr=[NSAttributedString attributedStringWithAttachment:attachment];
    
    NSTextAttachment *attachment0=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *image0 = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationUpMirrored];
    attachment0.image=isOnlyLeft?image:image0;
    attachment0.bounds=CGRectMake(0,isOnlyLeft?-2:3, image.size.width, image.size.height);
    NSAttributedString *imageStr0=[NSAttributedString attributedStringWithAttachment:attachment0];
    
    [attributedStr insertAttributedString:imageStr0 atIndex:0];
    
    if(!isOnlyLeft)[attributedStr insertAttributedString:imageStr atIndex:attributedStr.length];
    
    return attributedStr;
}
#pragma mark -限宽计算AttributeString与String的高度
+ (CGFloat)getAttributeContentHeightWithAttributeString:(NSAttributedString*)atributedString withFontSize:(float)fontSize boundingRectWithWidth:(CGFloat)width{
    float height = 0;
    CGSize lableSize = CGSizeZero;
//    if(IS_IOS7)
    if ([atributedString respondsToSelector:@selector(boundingRectWithSize:options:context:)]){
        CGSize sizeTemp = [atributedString boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                                        options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           
                                                        context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    height = lableSize.height;
    return height;
}

+ (CGFloat)getContentHeightWithParagraphStyleLineSpacing:(CGFloat)lineSpacing fontWithString:(NSString*)fontWithString fontOfSize:(CGFloat)fontOfSize boundingRectWithWidth:(CGFloat)width {
    float height = 0;
    CGSize lableSize = CGSizeZero;
//    if(IS_IOS7)
    if([fontWithString respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = lineSpacing;
        CGSize sizeTemp = [fontWithString boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                                       options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    attributes: @{NSFontAttributeName:
                                                                      [UIFont systemFontOfSize:fontOfSize],
                                                                  NSParagraphStyleAttributeName:
                                                                      paragraphStyle}
                                                       context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    
    
    height = lableSize.height;
    return height;
}

#pragma mark -限高计算AttributeString与String的宽度
+(CGFloat)getTextWidth:(NSString *)string withFontSize:(UIFont *)font withHeight:(CGFloat)height
{
    float width = 0;
    CGSize lableSize = CGSizeZero;
    if([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:font forKey: NSFontAttributeName];
        CGSize sizeTemp = [string boundingRectWithSize: CGSizeMake(MAXFLOAT, height)
                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes: stringAttributes
                                               context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    width = lableSize.width;
    return width;
}

#pragma mark -限宽计算AttributeString与String的宽度
+(CGFloat)calculateTextWidth:(NSString *)string withFontSize:(float)fontSize withWidth:(float)width
{
    float resultWidth = 0;
    CGSize lableSize = CGSizeZero;
    if([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *stringAttributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey: NSFontAttributeName];
        CGSize sizeTemp = [string boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes: stringAttributes
                                               context: nil].size;
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    
    resultWidth = lableSize.width;
    return resultWidth;
}

+(CGFloat)calculateAttributeTextWidth:(NSAttributedString *)atributedString withFontSize:(float)fontSize withWidth:(float)width
{
    float resultWidth = 0;
    CGSize lableSize = CGSizeZero;
    if([atributedString respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
        
        //        [atributedString setAttributes:@{ NSFontAttributeName:kFontSize(fontSize)} range:NSMakeRange(0,atributedString.length)];
        
        CGSize sizeTemp = [atributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                        context:nil].size;
        
        
        
        //                           boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
        //                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
        //                                            attributes: stringAttributes
        //                                               context: nil].size;//string
        lableSize = CGSizeMake(ceilf(sizeTemp.width), ceilf(sizeTemp.height));
    }
    
    resultWidth = lableSize.width;
    return resultWidth;
}

// 根据字体大小 和宽度计算文字的高
+(float)textHitWithStirng:(NSString*)stingS font:(float)font widt:(float)wid{
    if (!font) {
        font = 14.0;
    }
    if (!stingS) {
        stingS = @"";
    }
    if (!wid || wid == 0.0) {
        wid = 20;
    }
    CGRect rect=[stingS boundingRectWithSize:CGSizeMake(wid, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.height;
}

// 根据字体大小 和高度计算文字的宽
+(float)textWidthWithStirng:(NSString*)stingS font:(float)font hit:(float)hit{
    if (!font) {
        font = 14.0;
    }
    if (!stingS) {
        stingS = @"";
    }
    if (!hit || hit == 0.0) {
        hit = 20;
    }
    CGRect rect=[stingS boundingRectWithSize:CGSizeMake( MAXFLOAT, hit) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.width;
}

// 字典转json字符串方法//==[dic mj_JSONString]
+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}


//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (0x2100 <= hs && hs <= 0x27ff){
                returnValue =YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
            }else{
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue =YES;
                    }
                }
            }
            if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e) {
                returnValue =YES;
            }
            
        }
    }];
    return returnValue;
}
//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++){
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
//去除表情
+ (NSString *)disableEmoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

//Convert NSDictionary values to NSString
+ (NSString*)convertDictionaryToString:(NSMutableDictionary*)dict{
    
    NSError *error;
    // get Dictionary from mutable Dictionary
    NSDictionary *tempDict = [dict copy];
    
    //giving error as it takes dic, array,etc only. not custom object.
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *nsJson=  [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    return nsJson;
}

+ (CGSize)sizeWithString:(NSString*)str
                 andFont:(UIFont*)font
              andMaxSize:(CGSize)size{
    
    NSDictionary*attrs =@{NSFontAttributeName: font};
    
    return  [str boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrs
                              context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont*)font
            andMaxSize:(CGSize)size{
    //特殊的格式要求都写在属性字典中
    NSDictionary*attrs =@{NSFontAttributeName: font};
    //返回一个矩形，大小等于文本绘制完占据的宽和高。
    return  [self  boundingRectWithSize:size
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:attrs
                                context:nil].size;
}

- (NSString *)formatDecimalNumber{
    if (!self || self.length == 0) {
        return self;
    }
    NSNumber *number = @([self doubleValue]);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    formatter.positiveFormat = @"###,##0.00";
    NSString *amountString = [formatter stringFromNumber:number];
    return amountString;
}

+(NSString *)getMMSSFromSS:(NSInteger)totalTime{
    
    NSInteger seconds = totalTime;
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    if ([str_hour isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    }
    return format_time;
}

+(NSString *)numberSuitScanf:(NSString*)number{
    
    NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    return numberString;
}

//我自己写的
+(NSString *)ensureNonnullString:(id)nullableStr
                      ReplaceStr:(NSString *)replaceStr{
    //只有NSNumber 和 NSString 这两种情况
    //过滤特殊字符：空格
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    replaceStr = [replaceStr stringByTrimmingCharactersInSet:whitespace];//有空格，去除空格
    if (replaceStr == nil ||
        replaceStr == Nil ||
        replaceStr.length == 0) {
        replaceStr = @"暂无数据";
    }
    if (nullableStr == nil ||
        nullableStr == NULL ||
        [nullableStr isKindOfClass:[NSNull class]]) {//判断空 或者 空对象
        return replaceStr;
    }else if([nullableStr isKindOfClass:[NSString class]]){
        NSString *str = (NSString *)nullableStr;
        str = [str stringByTrimmingCharactersInSet:whitespace];//有空格，去除空格
        return str.length == 0 ? replaceStr : str;
    }else if ([nullableStr isKindOfClass:[NSNumber class]]){
        NSNumber *b = (NSNumber *)nullableStr;//longlong??
        if (strcmp([nullableStr objCType], @encode(BOOL)) == 0) {// Bool 类型
            return [NSString stringWithFormat:@"%d",[b boolValue]];
        }else if (strcmp([nullableStr objCType], @encode(int)) == 0){// int 类型
            return [NSString stringWithFormat:@"%d",[b intValue]];
        }else if (strcmp([nullableStr objCType], @encode(float)) == 0){// float 类型
            return [NSString stringWithFormat:@"%f",[b floatValue]];
        }else if (strcmp([nullableStr objCType], @encode(double)) == 0){//double 类型
            return [NSString stringWithFormat:@"%f",[b doubleValue]];
        }else if (strcmp([nullableStr objCType], @encode(char)) == 0){//char 类型
            return [NSString stringWithFormat:@"%c",[b charValue]];
        }else if (strcmp([nullableStr objCType], @encode(u_char)) == 0){//unsigned char 类型
            return [NSString stringWithFormat:@"%c",[b charValue]];
        }else if (strcmp([nullableStr objCType], @encode(short)) == 0){//short 类型
            return [NSString stringWithFormat:@"%c",[b shortValue]];
        }else if (strcmp([nullableStr objCType], @encode(u_short)) == 0){//unsigned short 类型
            return [NSString stringWithFormat:@"%c",[b shortValue]];
        }else if (strcmp([nullableStr objCType], @encode(long)) == 0){//long 类型
            return [NSString stringWithFormat:@"%ld",[b longValue]];
        }else if (strcmp([nullableStr objCType], @encode(u_long)) == 0){//unsigned long 类型
            return [NSString stringWithFormat:@"%lu",[b unsignedLongValue]];
        }else return replaceStr;
    }else return replaceStr;
}

//JSON转NSDictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (BOOL)isNullString:(NSString*)string{
    
    if (string == nil || string == NULL || [string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    string = StringFormat(@"%@",string);
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    string = [string stringByTrimmingCharactersInSet:whitespace];
    
    if (string.length == 0) {
        return YES;
    }
    
    return NO;
}

//开始时间给定 结束时间不给定就启用现在的时间戳
+(NSTimeInterval)timeIntervalstartDate:(NSString *_Nonnull)startTime
                               endDate:(NSString *_Nullable)endTime
                         timeFormatter:(NSDateFormatter *_Nullable)timeFormatter{
    if (timeFormatter == nil ||
        timeFormatter == Nil) {
        timeFormatter = NSDateFormatter.new;
        [timeFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSDate* startDate = [timeFormatter dateFromString:startTime];
    NSDate* endDate;
    if ([NSString isNullString:endTime]) {
        NSString *now = [timeFormatter stringFromDate:[NSDate date]];
        endDate = [timeFormatter dateFromString:now];
    }else{
        endDate = [timeFormatter dateFromString:endTime];
    }
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
}

//传入 秒  得到 xx:xx:xx
+(NSString *)getHHMMSSFromStr:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds / 3600];//format of hour
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds % 3600) / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];//format of time
    NSLog(@"format_time : %@",format_time);
    return format_time;
}

//传入 秒  得到  xx分钟xx秒
+(NSString *)getMMSSFromStr:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds / 60];//format of minute
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds % 60];//format of second
    NSString *format_time = [NSString stringWithFormat:@"%@分钟%@秒",str_minute,str_second];//format of time
    NSLog(@"format_time : %@",format_time);
    return format_time;
}

//字符串中取数字
+(long long)getDigitsFromStr:(NSString *)str{
    NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    int remainSecond = [[str stringByTrimmingCharactersInSet:nonDigits] intValue];
    return (long long)remainSecond;
}


@end
