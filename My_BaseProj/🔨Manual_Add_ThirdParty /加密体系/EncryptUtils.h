//
//  EncryptUtils.h
//  TogetherInvest
//
//  Created by Hope on 3/10/15.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

/**
*  20位SHA1加密
*/
static inline NSString *sha1_20bits(NSString *str,BOOL isLowercase){
    const char *cStr = [str UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:str.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    NSString *finalStr = Nil;
    if(isLowercase){
        finalStr = [result lowercaseString];
    }else{
        finalStr = [result uppercaseString];
    }
    
    return [finalStr copy];
}
/**
*  64位SHA1加密
*/
static inline NSString *sha1_64bits(NSString *str,BOOL isLowercase){
    const char *cStr = [str UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:str.length];
    uint8_t digest[CC_SHA1_BLOCK_BYTES];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_BLOCK_BYTES * 2];
    for(int i = 0; i < CC_SHA1_BLOCK_BYTES; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    NSString *finalStr = Nil;
    if(isLowercase){
        finalStr = [result lowercaseString];
    }else{
        finalStr = [result uppercaseString];
    }
    
    return [finalStr copy];
}
/**
*  32位MD5加密
*/
static inline NSString *md5_32bits(NSString *str,BOOL isLowercase){
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    NSString *finalStr = Nil;
    if(isLowercase){
        finalStr = [result lowercaseString];
    }else{
        finalStr = [result uppercaseString];
    }
    
    return [finalStr copy];
}
/**
*  64位MD5加密
*/
static inline NSString *md5_64bits(NSString *str,BOOL isLowercase){
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_BLOCK_BYTES];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_BLOCK_BYTES * 2];
    for(int i = 0; i < CC_MD5_BLOCK_BYTES; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    NSString *finalStr = Nil;
    if(isLowercase){
        finalStr = [result lowercaseString];
    }else{
        finalStr = [result uppercaseString];
    }
    
    return [finalStr copy];
}
//生成?位随机字符串
static inline NSString *shuffledAlphabet(int bits){
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

/*
 MD5加密 是HASH算法一种、 是生成32位的数字字母混合码。 MD5主要特点是 不可逆

 MD5算法还具有以下性质：
 1、压缩性：任意长度的数据，算出的MD5值长度都是固定的。
 2、容易计算：从原数据计算出MD5值很容易。
 3、抗修改性：对原数据进行任何改动，哪怕只修改1个字节，所得到的MD5值都有很大区别。
 4、弱抗碰撞：已知原数据和其MD5值，想找到一个具有相同MD5值的数据（即伪造数据）是非常困难的。
 5、强抗碰撞：想找到两个不同的数据，使它们具有相同的MD5值，是非常困难的。

 为什么加盐？
 因为现在网上有各种网站来查询MD5码
 例如http://www.cmd5.com，所以
 为了让MD5码更加安全，我们现在都采用加盐，盐要越长越乱，得到的MD5码就很难查到

 资料来源：https://blog.csdn.net/u013983033/article/details/84543122
 
*/
