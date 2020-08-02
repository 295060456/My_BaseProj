//
//  MKCommentModel.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseModel.h"

///子标题一开始最多加载的个数
#define preMax 3
///加载更多数据 一次加载的个数
#define LoadDataNum 1

NS_ASSUME_NONNULL_BEGIN

@interface MKChildCommentModel : NSObject

@property(nonatomic,strong)NSString *commentDate;
@property(nonatomic,strong)NSString *commentId;
@property(nonatomic,strong)NSString *content;//第二级
@property(nonatomic,strong)NSString *headImg;
@property(nonatomic,strong)NSString *ID;
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
@property(nonatomic,strong)NSString *commentId;
@property(nonatomic,strong)NSString *content;//第一级
@property(nonatomic,strong)NSString *headImg;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSNumber *isPraise;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSNumber *parentId;
@property(nonatomic,strong)NSNumber *praiseNum;
@property(nonatomic,strong)NSNumber *replyNum;
@property(nonatomic,strong)NSString *userId;
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
//对于第一级来讲，commentId = ID
//parentId对于第一级没用，是上个级别的父节点
@property(nonatomic,strong)NSMutableArray <MKFirstCommentModel *>*listMytArr;

@end
///直接回复的，是一级评论
@interface MKCommentVideoModel : NSObject

@property(nonatomic,strong)NSString *commentDate;
@property(nonatomic,strong)NSString *commentId;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *headImg;
@property(nonatomic,strong)NSString *ID;//评论id
@property(nonatomic,strong)NSNumber *isPraise;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSNumber *parentId;
@property(nonatomic,strong)NSNumber *praiseNum;
@property(nonatomic,strong)NSNumber *replyNum;
@property(nonatomic,strong)NSString *userId;//这条评论的拥有者id
@property(nonatomic,strong)NSNumber *videoId;

@end

NS_ASSUME_NONNULL_END

