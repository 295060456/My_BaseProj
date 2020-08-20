//
//  MKUploadingVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKUploadingVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKUploadingVC (VM)

-(void)videosUploadNetworking:(NSData *)data
              andVideoArticle:(NSString *)videoArticle;

@end

NS_ASSUME_NONNULL_END
