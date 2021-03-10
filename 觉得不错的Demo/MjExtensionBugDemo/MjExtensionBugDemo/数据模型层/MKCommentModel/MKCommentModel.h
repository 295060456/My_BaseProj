//
//  MKCommentModel.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseModel.h"

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

NS_ASSUME_NONNULL_BEGIN
//对应字段 child
@interface MKChildCommentModel : NSObject

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *parentId;
@property(nonatomic,strong)NSURL *headImg;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *commentDate;
@property(nonatomic,assign)NSInteger praiseNum;
@property(nonatomic,copy)NSString *toReplyUserId;
@property(nonatomic,copy)NSString *toReplyUserImg;
@property(nonatomic,copy)NSString *toReplyUserName;
@property(nonatomic,copy)NSString *commentId;
@property(nonatomic,copy)NSString *isPraise;
@property(nonatomic,assign)NSInteger isVip;
@property(nonatomic,assign)NSInteger toIsVip;

@end
// 对应字段 list
@interface MKFirstCommentModel : NSObject

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *parentId;
@property(nonatomic,strong)NSURL *headImg;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *commentDate;
@property(nonatomic,assign)NSInteger praiseNum;
@property(nonatomic,assign)NSInteger replyNum;
@property(nonatomic,strong)NSMutableArray <MKChildCommentModel *>*childMutArr;//二级评论
@property(nonatomic,copy)NSString *videoId;
@property(nonatomic,copy)NSString *commentId;
@property(nonatomic,assign)NSInteger isPraise;
@property(nonatomic,assign)BOOL isVip;

@end
/// 对应字段 data
@interface MKCommentModel : BaseModel

@property(nonatomic,strong) NSMutableArray <MKFirstCommentModel *>*listMutArr;//一级评论

@end

@interface MKFirstCommentCustomCofigModel : NSObject

@property(nonatomic,strong)NSMutableArray <MKChildCommentModel *>*childMutArr;//二级评论
#pragma mask —— 自定义字段
@property(nonatomic,assign)BOOL isFullShow;//是否全显示 默认不全显示
@property(nonatomic,assign)NSInteger preMax;//显示控制，二级数据默认最多显示多少个 默认3
@property(nonatomic,assign)NSInteger firstShonNum;//在满足限制条件的情况下，第一次显示的数据条数 （数据库有但小于PreMax）
@property(nonatomic,assign)NSInteger loadMoreDataNum;//加载更多数据,一次加载的个数，为0全加载

@end


NS_ASSUME_NONNULL_END

