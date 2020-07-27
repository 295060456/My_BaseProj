//
//  FileFolderHandleTool.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/27.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "FileFolderHandleTool.h"
#import <TXFileOperation.h>

@implementation FileFolderHandleTool

#pragma mark —— 目录获取
///获取沙盒的主目录路径：
+ (NSString *)homeDir {
    return NSHomeDirectory();
}
///获取沙盒中Documents的目录路径：
+ (NSString *)documentsDir {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask,
                                                YES) firstObject];
}
///获取沙盒中Library的目录路径：
+ (NSString *)libraryDir {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                NSUserDomainMask,
                                                YES) lastObject];
}
///获取沙盒中Libarary/Preferences的目录路径：
+ (NSString *)preferencesDir {
    NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                NSUserDomainMask,
                                                                YES) lastObject];
    return [libraryDir stringByAppendingPathComponent:@"Preferences"];
}
///获取沙盒中Library/Caches的目录路径：
+ (NSString *)cachesDir {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                NSUserDomainMask,
                                                YES) firstObject];
}
/// 获取沙盒中tmp的目录路径：
+ (NSString *)tmpDir {
    return NSTemporaryDirectory();
}
#pragma mark —— 创建文件（夹）
///创建文件夹：
+ (BOOL)createDirectoryAtPath:(NSString *)path
                        error:(NSError *__autoreleasing *)error {
    NSFileManager *manager = [NSFileManager defaultManager];
    /* createDirectoryAtPath:withIntermediateDirectories:attributes:error:
     * 参数1：创建的文件夹的路径
     * 参数2：是否创建媒介的布尔值，一般为YES
     * 参数3: 属性，没有就置为nil
     * 参数4: 错误信息
    */
    BOOL isSuccess = [manager createDirectoryAtPath:path
                        withIntermediateDirectories:YES
                                         attributes:nil
                                              error:error];
    return isSuccess;
}
/*创建文件
 *参数1：文件创建的路径
 *参数2：写入文件的内容
 *参数3：假如已经存在此文件是否覆盖
 *参数4：错误信息
 */
+ (BOOL)createFileAtPath:(NSString *)path
               overwrite:(BOOL)overwrite
                   error:(NSError *__autoreleasing *)error {
    // 如果文件夹路径不存在，那么先创建文件夹
    NSString *directoryPath = [self directoryAtPath:path];
    if (![self isExistsAtPath:directoryPath]) {
        // 创建文件夹
        if (![self createDirectoryAtPath:directoryPath
                                   error:error]) {
            return NO;
        }
    }
    // 如果文件存在，并不想覆盖，那么直接返回YES。
    if (!overwrite) {
        if ([self isExistsAtPath:path]) {
            return YES;
        }
    }
   /*创建文件
    *参数1：创建文件的路径
    *参数2：创建文件的内容（NSData类型）
    *参数3：文件相关属性
    */
    BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:path
                                                             contents:nil
                                                           attributes:nil];
    return isSuccess;
}
///获取文件创建的时间
+ (NSDate *)creationDateOfItemAtPath:(NSString *)path
                               error:(NSError *__autoreleasing *)error {
    return (NSDate *)[self attributeOfItemAtPath:path
                                          forKey:NSFileCreationDate
                                           error:error];
}
///获取文件修改的时间
+ (NSDate *)modificationDateOfItemAtPath:(NSString *)path
                                   error:(NSError *__autoreleasing *)error {
    return (NSDate *)[self attributeOfItemAtPath:path
                                          forKey:NSFileModificationDate
                                           error:error];
}
#pragma mark —— 写入文件内容
///写入文件内容：按照文件路径向文件写入内容，内容可为数组、字典、NSData等等
/*参数1：文件路径
 *参数2：文件内容
 *参数3：错误信息
 */
+ (BOOL)writeFileAtPath:(NSString *)path
                content:(NSObject *)content
                  error:(NSError *__autoreleasing *)error {
    //判断文件内容是否为空
    if (!content) {
        [NSException raise:@"非法的文件内容" format:@"文件内容不能为nil"];
        return NO;
    }
    //判断文件(夹)是否存在
    if ([self isExistsAtPath:path]) {
        if ([content isKindOfClass:[NSMutableArray class]]) {//文件内容为可变数组
            [(NSMutableArray *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSArray class]]) {//文件内容为不可变数组
            [(NSArray *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSMutableData class]]) {//文件内容为可变NSMutableData
            [(NSMutableData *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSData class]]) {//文件内容为NSData
            [(NSData *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSMutableDictionary class]]) {//文件内容为可变字典
            [(NSMutableDictionary *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSDictionary class]]) {//文件内容为不可变字典
            [(NSDictionary *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSJSONSerialization class]]) {//文件内容为JSON类型
            [(NSDictionary *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSMutableString class]]) {//文件内容为可变字符串
            [[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSString class]]) {//文件内容为不可变字符串
            [[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[UIImage class]]) {//文件内容为图片
            [UIImagePNGRepresentation((UIImage *)content) writeToFile:path atomically:YES];
        }else if ([content conformsToProtocol:@protocol(NSCoding)]) {//文件归档
//            [NSKeyedArchiver archiveRootObject:content toFile:path];//API_DEPRECATED
            [NSKeyedArchiver archivedDataWithRootObject:content
                                  requiringSecureCoding:NO
                                                  error:nil];
        }else {
            [NSException raise:@"非法的文件内容"
                        format:@"文件类型%@异常，无法被处理。", NSStringFromClass([content class])];
            return NO;
        }
    }else {
        return NO;
    }return YES;
}
#pragma mark —— 删除文件（夹）
///删除文件（夹）
+ (BOOL)removeItemAtPath:(NSString *)path
                   error:(NSError *__autoreleasing *)error {
    return [[NSFileManager defaultManager] removeItemAtPath:path error:error];
}
///清空Cashes文件夹
+ (BOOL)clearCachesDirectory {
    NSArray *subFiles = [TXFileOperation listFilesInCachesDirectoryByDeep:NO];
    BOOL isSuccess = YES;

    for (NSString *file in subFiles) {
        NSString *absolutePath = [[self cachesDir] stringByAppendingPathComponent:file];
        isSuccess &= [TXFileOperation removeItemAtPath:absolutePath];
    }
    return isSuccess;
}
///清空temp文件夹
+ (BOOL)clearTmpDirectory {
    NSArray *subFiles = [TXFileOperation listFilesInTmpDirectoryByDeep:NO];
    BOOL isSuccess = YES;

    for (NSString *file in subFiles) {
        NSString *absolutePath = [[self tmpDir] stringByAppendingPathComponent:file];
        isSuccess &= [TXFileOperation removeItemAtPath:absolutePath];
    }
    return isSuccess;
}
///清除path文件夹下缓存
+ (BOOL)clearCacheWithFilePath:(NSString *)path{
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path
                                                                              error:nil];
    NSString *filePath = nil;
    NSError *error = nil;
    for (NSString *subPath in subPathArr){
        filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath
                                                   error:&error];
        if (error) return NO;
    }return YES;
}
#pragma mark —— 复制文件（夹）
///复制文件 依据源文件的路径复制一份到目标路径：
/*参数1、被复制文件路径
 *参数2、要复制到的目标文件路径
 *参数3、当要复制到的文件路径文件存在，会复制失败，这里传入是否覆盖
 *参数4、错误信息
 */
+ (BOOL)copyItemAtPath:(NSString *)path
                toPath:(NSString *)toPath
             overwrite:(BOOL)overwrite
                 error:(NSError *__autoreleasing *)error {
    // 先要保证源文件路径存在，不然抛出异常
    if (![self isExistsAtPath:path]) {
        [NSException raise:@"非法的源文件路径"
                    format:@"源文件路径%@不存在，请检查源文件路径", path];
        return NO;
    }
    //获得目标文件的上级目录
    NSString *toDirPath = [self directoryAtPath:toPath];
    if (![self isExistsAtPath:toDirPath]) {
        // 创建复制路径
        if (![self createDirectoryAtPath:toDirPath
                                   error:error]) {
            return NO;
        }
    }
    // 如果覆盖，那么先删掉原文件
    if (overwrite) {
        if ([self isExistsAtPath:toPath]) {
            [self removeItemAtPath:toPath
                             error:error];
        }
    }
    // 复制文件，如果不覆盖且文件已存在则会复制失败
    BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:path
                                                             toPath:toPath
                                                              error:error];
    return isSuccess;
}
#pragma mark —— 移动文件（夹）
///移动文件(夹) 依据源文件的路径移动到目标路径：
/*参数1、被移动文件路径
 *参数2、要移动到的目标文件路径
 *参数3、当要移动到的文件路径文件存在，会移动失败，这里传入是否覆盖
 *参数4、错误信息
 */
+ (BOOL)moveItemAtPath:(NSString *)path
                toPath:(NSString *)toPath
             overwrite:(BOOL)overwrite
                 error:(NSError *__autoreleasing *)error {
    // 先要保证源文件路径存在，不然抛出异常
    if (![self isExistsAtPath:path]) {
        [NSException raise:@"非法的源文件路径"
                    format:@"源文件路径%@不存在，请检查源文件路径", path];
        return NO;
    }
    //获得目标文件的上级目录
    NSString *toDirPath = [self directoryAtPath:toPath];
    if (![self isExistsAtPath:toDirPath]) {
        // 创建移动路径
        if (![self createDirectoryAtPath:toDirPath error:error]) {
            return NO;
        }
    }
    // 判断目标路径文件是否存在
    if ([self isExistsAtPath:toPath]) {
        //如果覆盖，删除目标路径文件
        if (overwrite) {
            //删掉目标路径文件
            [self removeItemAtPath:toPath error:error];
        }else {
           //删掉被移动文件
            [self removeItemAtPath:path error:error];
            return YES;
        }
    }
    // 移动文件，当要移动到的文件路径文件存在，会移动失败
    BOOL isSuccess = [[NSFileManager defaultManager] moveItemAtPath:path
                                                             toPath:toPath
                                                              error:error];
    return isSuccess;
}
#pragma mark —— 根据URL获取文件名
/*参数1：文件路径
 *参数2、是否需要后缀
 */
+ (NSString *)fileNameAtPath:(NSString *)path
                      suffix:(BOOL)suffix {
    NSString *fileName = [path lastPathComponent];
    if (!suffix) {
        fileName = [fileName stringByDeletingPathExtension];
    }return fileName;
}
/// 获取文件所在的文件夹路径：
+ (NSString *)directoryAtPath:(NSString *)path {
    return [path stringByDeletingLastPathComponent];
}
/// 根据文件路径获取文件扩展类型:
+ (NSString *)suffixAtPath:(NSString *)path {
    return [path pathExtension];
}
#pragma mark —— 判断文件（夹）是否存在
///判断文件路径是否存在:
+ (BOOL)isExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}
///判断路径是否为空（判空条件是文件大小为0，或者是文件夹下没有子文件）:
+ (BOOL)isEmptyItemAtPath:(NSString *)path
                    error:(NSError *__autoreleasing *)error {
    return ([self isFileAtPath:path error:error] &&
            [[self sizeOfItemAtPath:path error:error] intValue] == 0) ||
    ([self isDirectoryAtPath:path error:error] &&
     [[self listFilesInDirectoryAtPath:path deep:NO] count] == 0);
}
///判断目录是否是文件夹：
+ (BOOL)isDirectoryAtPath:(NSString *)path
                    error:(NSError *__autoreleasing *)error {
    return ([self attributeOfItemAtPath:path forKey:NSFileType error:error] == NSFileTypeDirectory);
}
///判断目录是否是文件:
+ (BOOL)isFileAtPath:(NSString *)path
               error:(NSError *__autoreleasing *)error {
    return ([self attributeOfItemAtPath:path forKey:NSFileType error:error] == NSFileTypeRegular);
}
///判断目录是否可以执行:
+ (BOOL)isExecutableItemAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] isExecutableFileAtPath:path];
}
///判断目录是否可读:
+ (BOOL)isReadableItemAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] isReadableFileAtPath:path];
}
///判断目录是否可写:
+ (BOOL)isWritableItemAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] isWritableFileAtPath:path];
}
#pragma mark —— 获取文件（夹）大小
///获取文件大小（NSNumber）:
+ (NSNumber *)sizeOfItemAtPath:(NSString *)path
                         error:(NSError *__autoreleasing *)error {
    return (NSNumber *)[self attributeOfItemAtPath:path forKey:NSFileSize error:error];
}
///获取文件夹大小（NSNumber）:
+ (NSNumber *)sizeOfDirectoryAtPath:(NSString *)path
                              error:(NSError *__autoreleasing *)error {
    if ([self isDirectoryAtPath:path error:error]) {
       //深遍历文件夹
        NSArray *subPaths = [self listFilesInDirectoryAtPath:path deep:YES];
        NSEnumerator *contentsEnumurator = [subPaths objectEnumerator];
        
        NSString *file;
        unsigned long long int folderSize = 0;
        
        while (file = [contentsEnumurator nextObject]) {
            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[path stringByAppendingPathComponent:file]
                                                                                            error:nil];
            folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
        }
        return [NSNumber numberWithUnsignedLongLong:folderSize];
    }return nil;
}
///获取文件大小（单位为字节）:
+ (NSString *)sizeFormattedOfItemAtPath:(NSString *)path
                                  error:(NSError *__autoreleasing *)error {
    //先获取NSNumber类型的大小
    NSNumber *size = [self sizeOfItemAtPath:path
                                      error:error];
    if (size) {
       //将文件大小格式化为字节
        return [self sizeFormatted:size];
    }return nil;
}
///将文件大小格式化为字节
+(NSString *)sizeFormatted:(NSNumber *)size{
    /*NSByteCountFormatterCountStyle枚举
     *NSByteCountFormatterCountStyleFile 字节为单位，采用十进制的1000bytes = 1KB
     *NSByteCountFormatterCountStyleMemory 字节为单位，采用二进制的1024bytes = 1KB
     *NSByteCountFormatterCountStyleDecimal KB为单位，采用十进制的1000bytes = 1KB
     *NSByteCountFormatterCountStyleBinary KB为单位，采用二进制的1024bytes = 1KB
     */
    return [NSByteCountFormatter stringFromByteCount:[size unsignedLongLongValue]
                                          countStyle:NSByteCountFormatterCountStyleFile];
}
///获取文件夹大小（单位为字节）:
+ (NSString *)sizeFormattedOfDirectoryAtPath:(NSString *)path
                                       error:(NSError *__autoreleasing *)error {
    //先获取NSNumber类型的大小
    NSNumber *size = [self sizeOfDirectoryAtPath:path error:error];
    if (size) {
        return [self sizeFormatted:size];
    }
    return nil;
}
#pragma mark —— 遍历文件夹(分为深遍历和浅遍历：)
/**
 文件遍历
 参数1：目录的绝对路径
 参数2：是否深遍历 (1. 浅遍历：返回当前目录下的所有文件和文件夹；
 2. 深遍历：返回当前目录下及子目录下的所有文件和文件夹)
 */
+ (NSArray *)listFilesInDirectoryAtPath:(NSString *)path
                                   deep:(BOOL)deep {
    NSArray *listArr;
    NSError *error;
    NSFileManager *manager = [NSFileManager defaultManager];
    if (deep) {
        // 深遍历
        NSArray *deepArr = [manager subpathsOfDirectoryAtPath:path
                                                        error:&error];
        if (!error) {
            listArr = deepArr;
        }else {
            listArr = nil;
        }
    }else {
        // 浅遍历
        NSArray *shallowArr = [manager contentsOfDirectoryAtPath:path
                                                           error:&error];
        if (!error) {
            listArr = shallowArr;
        }else {
            listArr = nil;
        }
    }return listArr;
}
#pragma mark —— 获取文件属性
///根据key获取文件某个属性：
//key的列表如下：
//FOUNDATION_EXPORT NSString * const NSFileType;
//FOUNDATION_EXPORT NSString * const NSFileTypeDirectory;
//FOUNDATION_EXPORT NSString * const NSFileTypeRegular;
//FOUNDATION_EXPORT NSString * const NSFileTypeSymbolicLink;
//FOUNDATION_EXPORT NSString * const NSFileTypeSocket;
//FOUNDATION_EXPORT NSString * const NSFileTypeCharacterSpecial;
//FOUNDATION_EXPORT NSString * const NSFileTypeBlockSpecial;
//FOUNDATION_EXPORT NSString * const NSFileTypeUnknown;
//FOUNDATION_EXPORT NSString * const NSFileSize;
//FOUNDATION_EXPORT NSString * const NSFileModificationDate;
//FOUNDATION_EXPORT NSString * const NSFileReferenceCount;
//FOUNDATION_EXPORT NSString * const NSFileDeviceIdentifier;
//FOUNDATION_EXPORT NSString * const NSFileOwnerAccountName;
//FOUNDATION_EXPORT NSString * const NSFileGroupOwnerAccountName;
//FOUNDATION_EXPORT NSString * const NSFilePosixPermissions;
//FOUNDATION_EXPORT NSString * const NSFileSystemNumber;
//FOUNDATION_EXPORT NSString * const NSFileSystemFileNumber;
//FOUNDATION_EXPORT NSString * const NSFileExtensionHidden;
//FOUNDATION_EXPORT NSString * const NSFileHFSCreatorCode;
//FOUNDATION_EXPORT NSString * const NSFileHFSTypeCode;
//FOUNDATION_EXPORT NSString * const NSFileImmutable;
//FOUNDATION_EXPORT NSString * const NSFileAppendOnly;
//FOUNDATION_EXPORT NSString * const NSFileCreationDate;
//FOUNDATION_EXPORT NSString * const NSFileOwnerAccountID;
//FOUNDATION_EXPORT NSString * const NSFileGroupOwnerAccountID;
//FOUNDATION_EXPORT NSString * const NSFileBusy;
//FOUNDATION_EXPORT NSString * const NSFileProtectionKey NS_AVAILABLE_IOS(4_0);
//FOUNDATION_EXPORT NSString * const NSFileProtectionNone NS_AVAILABLE_IOS(4_0);
//FOUNDATION_EXPORT NSString * const NSFileProtectionComplete NS_AVAILABLE_IOS(4_0);
//FOUNDATION_EXPORT NSString * const NSFileProtectionCompleteUnlessOpen NS_AVAILABLE_IOS(5_0);
//FOUNDATION_EXPORT NSString * const NSFileProtectionCompleteUntilFirstUserAuthentication NS_AVAILABLE_IOS(5_0);

+ (id)attributeOfItemAtPath:(NSString *)path
                      forKey:(NSString *)key
                       error:(NSError *__autoreleasing *)error {
    return [[self attributesOfItemAtPath:path
                                   error:error] objectForKey:key];
}
///获取文件属性集合:
+ (NSDictionary *)attributesOfItemAtPath:(NSString *)path
                                   error:(NSError *__autoreleasing *)error {
    return [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                            error:error];
}
#pragma mark —— 系统相册相关
///获取相册最新加载（录制、拍摄）的资源
+(PHAsset *)gettingLastResource:(NSString *)Key{
    //获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = PHFetchOptions.new;
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:Key
                                                              ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    //这里取得的结果 assetsFetchResults 其实可以当做一个数组。
    //获取最新一张照片
    PHAsset *d = [assetsFetchResults firstObject];
    return d;
}
///创建相册
+(void)createFolder:(NSString *)folderName
               path:(NSString *)pathStr{
    if (![self isExistFolder:folderName]) {
        [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:folderName];
        } completionHandler:^(BOOL success,
                              NSError * _Nullable error) {
            if (success) {
                NSLog(@"创建相册文件夹成功!");
                [FileFolderHandleTool saveRes:[NSURL URLWithString:pathStr]];
            } else {
                NSLog(@"创建相册文件夹失败:%@", error);
            }
        }];
    }else [FileFolderHandleTool saveRes:[NSURL URLWithString:pathStr]];
}
///保存视频资源文件
+(void)saveRes:(NSURL *)movieURL{
    __block NSString *localIdentifier = Nil;//标识保存到系统相册中的标识
    PHFetchResult *collectonResuts = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];//首先获取相册的集合
    [collectonResuts enumerateObjectsUsingBlock:^(id obj,
                                                  NSUInteger idx,
                                                  BOOL *stop) {//对获取到集合进行遍历
        PHAssetCollection *assetCollection = obj;
        NSLog(@"LLL %@",assetCollection.localizedTitle);
        if ([assetCollection.localizedTitle isEqualToString:HDAppDisplayName])  {
            [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
                //请求创建一个Asset
                PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:movieURL];
                //请求编辑相册
                PHAssetCollectionChangeRequest *collectonRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                //为Asset创建一个占位符，放到相册编辑请求中
                PHObjectPlaceholder *placeHolder = [assetRequest placeholderForCreatedAsset];
                //相册中添加视频
                [collectonRequest addAssets:@[placeHolder]];
                localIdentifier = placeHolder.localIdentifier;
            } completionHandler:^(BOOL success,
                                  NSError *error) {
                if (success) {
                    NSLog(@"保存视频成功!");
                    //保存视频成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveRes_success"
                                                                        object:nil];
                } else {
                    NSLog(@"保存视频失败:%@", error);
                }
            }];
        }
    }];
}
///是否存在此相册判断逻辑依据
+ (BOOL)isExistFolder:(NSString *)folderName {
    __block BOOL isExisted = NO;
    //首先获取用户手动创建相册的集合
    PHFetchResult *collectonResuts = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    //对获取到集合进行遍历
    [collectonResuts enumerateObjectsUsingBlock:^(id obj,
                                                  NSUInteger idx,
                                                  BOOL *stop) {
        PHAssetCollection *assetCollection = obj;
        if ([assetCollection.localizedTitle isEqualToString:folderName])  {
            isExisted = YES;
        }
    }];return isExisted;
}

@end
