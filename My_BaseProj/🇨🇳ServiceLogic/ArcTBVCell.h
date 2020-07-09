//
//  ArcTBVCell.h
//  My_BaseProj
//
//  Created by Administrator on 10/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArcTBVCell : UITableViewCell

+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeight:(nullable id)model;
-(void)richElementsInCellWithModel:(nullable id)model;

@end

NS_ASSUME_NONNULL_END
