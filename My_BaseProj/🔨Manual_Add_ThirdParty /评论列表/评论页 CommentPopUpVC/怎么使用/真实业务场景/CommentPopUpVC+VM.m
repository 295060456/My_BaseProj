//
//  CommentPopUpVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CommentPopUpVC+VM.h"

@implementation CommentPopUpVC (VM)
///GET 初始化用户评论列表
-(void)netWorking_MKCommentQueryInitListGET{
    
}
///POST 评论视频
-(void)netWorking_MKCommentVideoPOST{//
    //如果评论成功
    self.commentNumStr = @"";
    self.inputView.tfContentStr = @"";
    self.inputView.textField.text = @"";
}
///POST 回复评论
-(void)netWorking_MKCommentReplyCommentPOSTWithCommentId:(NSString *)commentId
                                                      ID:(NSString *)ID
                                                 content:(NSString *)content{//
    //如果评论成功
    self.commentNumStr = @"";
    self.inputView.tfContentStr = @"";
    self.inputView.textField.text = @"";
}
///POST 删除评论
-(void)netWorking_MKCommentDelCommentPOSTWithCommentId:(NSString *)commentId
                                                    ID:(NSString *)ID{
    
}

///POST 点赞或取消点赞
-(void)netWorking_MKCommentSetPraisePOSTWithCommentId:(NSString *)commentId
                                                   ID:(NSString *)ID
                                               sender:(RBCLikeButton *)sender{
    
}

@end

//{
//    endRow = 2;
//    hasNextPage = 0;
//    hasPreviousPage = 0;
//    isFirstPage = 1;
//    isLastPage = 1;
//    list =     (
//                {
//            child =             (
//                                {
//                    commentDate = "15:35";
//                    content = "第二级";
//                    headImg = "user/headimg/n1@2x.png";
//                    id = 1286565527414611970;
//                    nickname = "金正志121";
//                    parentId = 0;
//                    praiseNum = 0;
//                    toReplyUserId = 1286555175368065026;
//                    toReplyUserImg = "http://103.243.183.254:9000/bucket1-dev/IMAGES/app-user/headimg/f2@2x.png";
//                    toReplyUserName = "段干明轩504";
//                    userId = 1280865260648706049;
//                }
//            );
//            commentDate = "15:33";
//            content = "第一级";
//            headImg = "http://103.243.183.254:9000/bucket1-dev/IMAGES/app-user/headimg/f2@2x.png";
//            id = 1286565256642928642;
//            nickname = "段干明轩504";
//            parentId = 0;
//            praiseNum = 0;
//            replyNum = 1;
//            userId = 1286555175368065026;
//            videoId = 1286286121952661506;
//        },
//                {
//            child =             (
//            );
//            commentDate = "15:34";
//            content = "第一级2";
//            headImg = "http://103.243.183.254:9000/bucket1-dev/IMAGES/app-user/headimg/f2@2x.png";
//            id = 1286565353967558657;
//            nickname = "段干明轩504";
//            parentId = 0;
//            praiseNum = 0;
//            replyNum = 0;
//            userId = 1286555175368065026;
//            videoId = 1286286121952661506;
//        }
//    );
//    navigateFirstPage = 1;
//    navigateLastPage = 1;
//    navigatePages = 8;
//    navigatepageNums =     (
//        1
//    );
//    nextPage = 0;
//    pageNum = 1;
//    pageSize = 10;
//    pages = 1;
//    prePage = 0;
//    size = 2;
//    startRow = 1;
//    total = 2;
//}
