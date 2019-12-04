//
//  NSString+YBCodec.h
//  Aa
//
//  Created by Aalto on 2018/11/20.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extras)
-(NSString *)test:(NSArray <NSString *>*)arr;
/**
 *  判断对象 / 数组是否为空
 *  为空返回 YES
 *  不为空返回 NO
 */
+(BOOL)isEmptyStr:(NSString *)value; 
+(BOOL)isContainAllCharType:(NSString*)originString;
//MD5加密🔐,加盐操作在内部进行
+ (NSString *)MD5WithString:(NSString *)string
                isLowercase:(BOOL)isLowercase;

- (BOOL)match:(NSString *)express;

+ (BOOL)isPureInt:(NSString *)string;

+(BOOL)isHaveWhiteSpace:(NSString *)text;
+(NSString* )getTimeString:(NSString *)timeStampString;
+ (BOOL)isEmpty:(NSString *)text;
+ (id)isValueNSStringWith:(NSString *)str;
//+ (BOOL)getDataSuccessed:(NSDictionary *)dic;
//+(BOOL)getLNDataSuccessed:(NSDictionary *)dic;
+ (BOOL)isAllZeroInString:(NSString*)originString;
+ (NSString*)getAnonymousString:(NSString* )originString;
+ (NSString *)timeWithSecond:(NSInteger)second;
- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString;
+ (NSMutableAttributedString *)attributedReverseStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont numInSubColor:(UIColor*)numInSubColor numInSubFont:(UIFont*)numInSubFont;
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont numInSubColor:(UIColor*)numInSubColor numInSubFont:(UIFont*)numInSubFont;

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont;
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor stringFont:(UIFont*)sFont subString:(NSString *)subString subStringColor:(UIColor*)subStringcolor subStringFont:(UIFont*)subStringFont subStringUnderlineColor:(UIColor*)underlineColor;
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor image:(UIImage *)image;

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string stringColor:(UIColor*)scolor image:(UIImage *)image isImgPositionOnlyLeft:(BOOL)isOnlyLeft;

+ (CGFloat)getAttributeContentHeightWithAttributeString:(NSAttributedString*)atributedString withFontSize:(float)fontSize boundingRectWithWidth:(CGFloat)width;
+ (CGFloat)getContentHeightWithParagraphStyleLineSpacing:(CGFloat)lineSpacing fontWithString:(NSString*)fontWithString fontOfSize:(CGFloat)fontOfSize boundingRectWithWidth:(CGFloat)width;

+(CGFloat)getTextWidth:(NSString *)string withFontSize:(UIFont *)font withHeight:(CGFloat)height;

+(CGFloat)calculateTextWidth:(NSString *)string withFontSize:(float)fontSize withWidth:(float)width;
+(CGFloat)calculateAttributeTextWidth:(NSAttributedString *)atributedString withFontSize:(float)fontSize withWidth:(float)width;
+(NSString *)convertToJsonData:(NSDictionary *)dict;

+(float)textHitWithStirng:(NSString*)stingS font:(float)font widt:(float)wid;
// 根据字体大小 和高度计算文字的宽
+(float)textWidthWithStirng:(NSString*)stingS font:(float)font hit:(float)hit;

//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string ;
//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string;
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string;
//去除表情
+ (NSString *)disableEmoji:(NSString *)text;

//Convert NSDictionary values to NSString
+ (NSString*)convertDictionaryToString:(NSMutableDictionary*)dict;

//计算文本的大小
+ (CGSize)sizeWithString:(NSString*)str
                 andFont:(UIFont*)font
              andMaxSize:(CGSize)size;

- (CGSize)sizeWithFont:(UIFont*)font
            andMaxSize:(CGSize)size;

// 判断纯整数
+(BOOL)judgeiphoneNumberInt:(NSString*)number;


// 金额字符串格式化
- (NSString *)formatDecimalNumber;

+(NSString *)getMMSSFromSS:(NSInteger)totalTime; // 时间转 小时 / d分 、秒

+(NSString *)numberSuitScanf:(NSString*)number;

//我自己写的
+(NSString *)ensureNonnullString:(id)nullableStr
                      ReplaceStr:(NSString *)replaceStr;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
