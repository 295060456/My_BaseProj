//
//  MKCommentModel.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKChildCommentModel : NSObject

@property(nonatomic,strong)NSString *commentDate;
@property(nonatomic,strong)NSNumber *commentId;
@property(nonatomic,strong)NSString *content;//第二级
@property(nonatomic,strong)NSString *headImg;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *isPraise;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSNumber *parentId;
@property(nonatomic,strong)NSNumber *praiseNum;
@property(nonatomic,strong)NSNumber *toReplyUserId;
@property(nonatomic,strong)NSString *toReplyUserImg;
@property(nonatomic,strong)NSString *toReplyUserName;
@property(nonatomic,strong)NSNumber *userId;

@end

@interface MKFirstCommentModel : NSObject

@property(nonatomic,strong)NSMutableArray <MKChildCommentModel *>*childMutArr;
@property(nonatomic,strong)NSString *commentDate;
@property(nonatomic,strong)NSNumber *commentId;
@property(nonatomic,strong)NSString *content;//第一级
@property(nonatomic,strong)NSString *headImg;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *isPraise;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSNumber *parentId;
@property(nonatomic,strong)NSNumber *praiseNum;
@property(nonatomic,strong)NSNumber *replyNum;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSNumber *videoId;

#pragma mask --- define
@property(nonatomic,assign)BOOL _hasMore;
@property(nonatomic,assign)BOOL isFullShow;
///当前二级数据实际个数
@property(nonatomic,assign)int rand;
///当前二级数据显示个数
@property(nonatomic,assign)int randShow;
///显示控制，二级数据默认最多显示多少个
@property(nonatomic,assign)int PreMax;

@end

@interface MKCommentModel : BaseModel

@property(nonatomic,strong)NSMutableArray <MKFirstCommentModel *>*listMytArr;

@end

NS_ASSUME_NONNULL_END
