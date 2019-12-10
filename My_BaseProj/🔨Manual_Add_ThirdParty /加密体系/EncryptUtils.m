//
//  EncryptUtils.m
//  TogetherInvest
//
//  Created by Hope on 3/10/15.

//

#import "EncryptUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation EncryptUtils
/**
 *  20位SHA1加密
 */
+(NSString *)sha1_20bits:(NSString *)str{
    const char *cStr = [str UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:str.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }return [result copy];
}
/**
 *  64位SHA1加密
 */
+(NSString *)sha1_64bits:(NSString *)str{
    const char *cStr = [str UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:str.length];
    uint8_t digest[CC_SHA1_BLOCK_BYTES];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_BLOCK_BYTES * 2];
    for(int i = 0; i < CC_SHA1_BLOCK_BYTES; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }return [result copy];
}
/**
 *  32位MD5加密
 */
+(NSString *)md5_32bits:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }return [result copy];
}
/**
 *  64位MD5加密
 */
+(NSString *)md5_64bits:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_BLOCK_BYTES];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_BLOCK_BYTES * 2];
    for(int i = 0; i < CC_MD5_BLOCK_BYTES; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }return [result copy];
}
//生成?位随机字符串
+ (NSString *)shuffledAlphabet:(int)bits{
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    // Get the characters into a C array for efficient shuffling
    NSUInteger numberOfCharacters = [alphabet length];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
    // Perform a Fisher-Yates shuffle
    for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
        NSUInteger j = (arc4random_uniform((float)numberOfCharacters - i) + i);
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }
    // Turn the result back into a string
    NSString *result = [NSString stringWithCharacters:characters
                                               length:bits];
    free(characters);
    return result;
}


@end
