//
//  MKPublickDataManager.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/12/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKPublickDataManager.h"
static MKPublickDataManager *static_publicDataManage = nil;
@interface MKPublickDataManager()
@property (strong,nonatomic) NSString *mkAccno;

@end

@implementation MKPublickDataManager
+ (MKPublickDataManager *) sharedPublicDataManage
{
    @synchronized(self){
        if ( nil == static_publicDataManage ) {
            static_publicDataManage = [[MKPublickDataManager alloc] init];
        }
    }
    return static_publicDataManage;
}
//#pragma mark - 登录model
//- (MKLoginModel *)mkLoginModel{
//    MKLoginModel *bdmodel = [[MKLoginModel getUsingLKDBHelper] searchSingle:[MKLoginModel class] where:nil orderBy:nil];
//    return bdmodel;
//}


@end
