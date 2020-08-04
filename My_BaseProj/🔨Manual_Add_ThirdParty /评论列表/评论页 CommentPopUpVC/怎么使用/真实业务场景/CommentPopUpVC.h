//
//  CommentPopUpVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PopUpVC.h"
#import "InputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentPopUpVC : PopUpVC

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)InputView *inputView;

@property(nonatomic,strong)__block NSString *inputContentStr;
@property(nonatomic,strong)NSString *videoID;
@property(nonatomic,strong)NSString *commentNumStr;
@property(nonatomic,assign)BOOL isClickExitBtn;
@property(nonatomic,strong)NSMutableArray <MKFirstCommentModel *>*firstCommentModelMutArr;
@property(nonatomic,copy)MKDataBlock CommentPopUpBlock;
@property(nonatomic,strong)MKCommentModel *commentModel;
@property(nonatomic,strong)MKCommentVideoModel *commentVideoModel;

-(void)commentPopUpActionBlock:(MKDataBlock)commentPopUpBlock;//在VM里面

@end

NS_ASSUME_NONNULL_END
