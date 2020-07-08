//
//  NSlogToDocumentFolder.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "NSlogToDocumentFolder.h"

@implementation NSlogToDocumentFolder

+ (void)redirectNSlogToDocumentFolder{
    
    //如果已经连接Xcode调试则不输出到文件
    if(isatty(STDOUT_FILENO)) return;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@.log",currentDateStr];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    // 先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];
    
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

@end
