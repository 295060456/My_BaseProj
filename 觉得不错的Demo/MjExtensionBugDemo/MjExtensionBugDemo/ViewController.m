//
//  ViewController.m
//  MjExtensionBugDemo
//
//  Created by Jobs on 2021/1/25.
//

#import "ViewController.h"

#if __has_include(<MJExtension/MJExtension.h>)
#import <MJExtension/MJExtension.h>
#else
#import "MJExtension.h"
#endif

#if __has_include(<YYModel/YYModel.h>)
#import <YYModel/YYModel.h>
#else
#import "YYModel.h"
#endif

#import "BaseModel.h"
#import "MKSignListModel.h"
#import "MKCommentModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dataDic_01 = [self readLocalFileWithName:@"Data"];
    NSLog(@"");
    MKSignListModel *signListModel = (MKSignListModel *)[MKSignListModel mj_objectWithKeyValues:dataDic_01[@"data"]];
    NSLog(@"");
    
    NSDictionary *dataDic_02 = [self readLocalFileWithName:@"CommentData"];
    MKCommentModel *commentModel_mj = [MKCommentModel mj_objectWithKeyValues:dataDic_02[@"data"]];
    MKCommentModel *commentModel_yy = [MKCommentModel yy_modelWithDictionary:dataDic_02[@"data"]];
    
    NSLog(@"");
}

// 读取本地JSON文件
-(NSDictionary *)readLocalFileWithName:(NSString *)name{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
