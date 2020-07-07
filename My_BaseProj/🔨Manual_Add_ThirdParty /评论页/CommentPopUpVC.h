//
//  CommentPopUpVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PopUpVC.h"
#import "ZFJTreeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentPopUpVC : PopUpVC

@property(nonatomic,strong)ZFJTreeView *treeView;
@property(nonatomic,assign)CGFloat liftingHeight;

@end

NS_ASSUME_NONNULL_END
