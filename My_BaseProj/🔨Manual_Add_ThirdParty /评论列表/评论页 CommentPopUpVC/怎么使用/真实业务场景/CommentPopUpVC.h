//
//  CommentPopUpVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PopUpVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentPopUpVC : PopUpVC

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)MKCommentModel *commentModel;
@property(nonatomic,strong)NSMutableArray <MKFirstCommentModel *>*firstCommentModelMutArr;
@property(nonatomic,strong)__block NSString *inputContentStr;

-(void)commentPopUpActionBlock:(MKDataBlock)commentPopUpBlock;

@end

NS_ASSUME_NONNULL_END
