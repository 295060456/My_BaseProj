//
//  FileFolderHandleTool.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/27.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileFolderHandleTool : NSObject

/*
 1.Documents:只有用户生成的文件、其他数据及其他程序不能重新创建的文件，应该保存在/Documents目录下面，并将通过iCloud自动备份。
 2.Library:可以重新下载或者重新生成的数据应该保存在/Library /caches目录下面。举个例子，比如杂志、新闻、地图应用使用的数据库缓存文件和可下载内容应该保存到这个文件夹。
 3.tmp:只是临时使用的数据应该保存在/ tmp 文件夹，tmp目录不是你程序退出的时候就清空，是在你内存不足的情况系统会给你清空，看是网络缓存的数据还是本地存储的，如果本地存储你可以放在doc目录。
 尽管iCloud不会备份这些文件，但在应用使用完这些数据之后要注意随时删除，避免占用用户设备的空间。
 */
#pragma mark —— 禁止App系统文件夹document同步
///因为它会同步。苹果要求：可重复产生的数据不得进行同步,什么叫做可重复数据？这里最好禁止，否则会影响上架，被拒！
+(void)banSysDocSynchronization;
#pragma mark —— 目录获取
///获取沙盒的主目录路径：
+ (NSString *)homeDir;
///获取沙盒中Documents的目录路径：
+ (NSString *)documentsDir;
///获取沙盒中Library的目录路径：
+ (NSString *)libraryDir;
///获取沙盒中Libarary/Preferences的目录路径：
+ (NSString *)preferencesDir;
///获取沙盒中Library/Caches的目录路径：
+ (NSString *)cachesDir;
/// 获取沙盒中tmp的目录路径：供系统使用，程序员不要使用，因为随时会被销毁
+ (NSString *)tmpDir;
#pragma mark - 以当前时间戳生成缓存路径 Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除。一般存放体积比较大，不是特别重要的资源。
+(NSString *)cacheURL:(NSString *)extension
               folder:(NSString *)folderName;
#pragma mark —— 创建文件（夹）
///创建文件夹：
+ (BOOL)createDirectoryAtPath:(NSString *)path
                        error:(NSError *__autoreleasing *)error;
/*创建文件
 *参数1：文件创建的路径
 *参数2：写入文件的内容
 *参数3 overwrite ：假如已经存在此文件是否覆盖,如果文件存在，并不想覆盖，那么直接返回YES。
 *参数4：错误信息
 */
+ (BOOL)createFileAtPath:(NSString *)path
               overwrite:(BOOL)overwrite
                   error:(NSError *__autoreleasing *)error;
///file_url是文件的全路径。外层拼接好，如果返回YES则file_url可用
+(BOOL)createFileByUrl:(NSString *)file_url
                 error:(NSError *__autoreleasing *)error;
///获取文件创建的时间
+ (NSDate *)creationDateOfItemAtPath:(NSString *)path
                               error:(NSError *__autoreleasing *)error;
///获取文件修改的时间
+ (NSDate *)modificationDateOfItemAtPath:(NSString *)path
                                   error:(NSError *__autoreleasing *)error;
#pragma mark —— 写入文件内容
///写入文件内容：按照文件路径向文件写入内容，内容可为数组、字典、NSData等等
/*参数1：文件路径
 *参数2：文件内容
 *参数3：错误信息
 */
+ (BOOL)writeFileAtPath:(NSString *)path
                content:(NSObject *)content
                  error:(NSError *__autoreleasing *)error;
#pragma mark —— 删除文件（夹）
///删除文件（夹）
+ (BOOL)removeItemAtPath:(NSString *)path
                   error:(NSError *__autoreleasing *)error;
///清空Cashes文件夹
+ (BOOL)clearCachesDirectory;
///清空temp文件夹
+ (BOOL)clearTmpDirectory;
///清除path文件夹下缓存
+ (BOOL)clearCacheWithFilePath:(NSString *)path;
///给定一个路径，删除旗下所有东西
+(void)cleanFilesWithPath:(NSString *)PathStr;
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
                 error:(NSError *__autoreleasing *)error;
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
                 error:(NSError *__autoreleasing *)error;
#pragma mark —— 根据URL获取文件名
/*参数1：文件路径
 *参数2、是否需要后缀
 */
+ (NSString *)fileNameAtPath:(NSString *)path
                      suffix:(BOOL)suffix;
/// 获取文件所在的文件夹路径：删除最后一个路径节点
+ (NSString *)directoryAtPath:(NSString *)path;
/// 根据文件路径获取文件扩展类型:
+ (NSString *)suffixAtPath:(NSString *)path;
#pragma mark —— 判断文件（夹）是否存在
///判断文件路径是否存在:
+ (BOOL)isExistsAtPath:(NSString *)path;
///判断路径是否为空（判空条件是文件大小为0，或者是文件夹下没有子文件）:
+ (BOOL)isEmptyItemAtPath:(NSString *)path
                    error:(NSError *__autoreleasing *)error;
///判断目录是否是文件夹：
+ (BOOL)isDirectoryAtPath:(NSString *)path
                    error:(NSError *__autoreleasing *)error;
///判断目录是否是文件:
+ (BOOL)isFileAtPath:(NSString *)path
               error:(NSError *__autoreleasing *)error;
///判断目录是否可以执行:
+ (BOOL)isExecutableItemAtPath:(NSString *)path;
///判断目录是否可读:
+ (BOOL)isReadableItemAtPath:(NSString *)path;
///判断目录是否可写:
+ (BOOL)isWritableItemAtPath:(NSString *)path;
#pragma mark —— 获取文件（夹）大小
///获取文件大小（NSNumber）:
+ (NSNumber *)sizeOfItemAtPath:(NSString *)path
                         error:(NSError *__autoreleasing *)error;
///获取文件夹大小（NSNumber）:
+ (NSNumber *)sizeOfDirectoryAtPath:(NSString *)path
                              error:(NSError *__autoreleasing *)error;
///获取文件大小（单位为字节）:
+ (NSString *)sizeFormattedOfItemAtPath:(NSString *)path
                                  error:(NSError *__autoreleasing *)error;
///将文件大小格式化为字节
+(NSString *)sizeFormatted:(NSNumber *)size;
///获取文件夹大小（单位为字节）:
+ (NSString *)sizeFormattedOfDirectoryAtPath:(NSString *)path
                                       error:(NSError *__autoreleasing *)error;
#pragma mark —— 遍历文件夹(分为深遍历和浅遍历：)
/**
 文件遍历
 参数1：目录的绝对路径
 参数2：是否深遍历 (1. 浅遍历：返回当前目录下的所有文件和文件夹；
 2. 深遍历：返回当前目录下及子目录下的所有文件和文件夹)
 */
+ (NSArray *)listFilesInDirectoryAtPath:(NSString *)path
                                   deep:(BOOL)deep;
#pragma mark —— 获取文件属性
+ (id)attributeOfItemAtPath:(NSString *)path
                      forKey:(NSString *)key
                      error:(NSError *__autoreleasing *)error;
///获取文件属性集合:
+ (NSDictionary *)attributesOfItemAtPath:(NSString *)path
                                   error:(NSError *__autoreleasing *)error;
#pragma mark —— 系统相册相关
///获取相册最新加载（录制、拍摄）的资源
+(PHAsset *)gettingLastResource:(NSString *)Key;

+(void)createFolder:(NSString *)folderName
  ifExitFolderBlock:(MKDataBlock)ifExitFolderBlock
  completionHandler:(TwoDataBlock)completionBlock;
///创建一个名为folderName的相册，并且以路径pathStr保存文件
+(void)createFolder:(NSString *)folderName
               path:(NSString *)pathStr;
///保存视频资源文件到指定的相册路径，这里是整个App名字的相册
+(void)saveRes:(NSURL *)movieURL;
///是否存在此相册判断逻辑依据
+(BOOL)isExistFolder:(NSString *)folderName;
///保存文件到系统默认的相册
+(void)saveVideo:(NSString *)videoPath;
+(void)saveImage:(UIImage *)image;
///仅获取PHAsset里面的视频
+(void)getVedioFromPHAsset:(PHAsset *)phAsset
                  complete:(MKDataBlock)completeBlock;
///获取PHAsset里面的相片
+(void)getPicFromPHAsset:(PHAsset *)phAsset
                complete:(MKDataBlock)completeBlock;
///获取PHAsset里面的声音
+(void)getAudioFromPHAsset:(PHAsset *)phAsset
                  complete:(MKDataBlock)completeBlock;

@end

NS_ASSUME_NONNULL_END
