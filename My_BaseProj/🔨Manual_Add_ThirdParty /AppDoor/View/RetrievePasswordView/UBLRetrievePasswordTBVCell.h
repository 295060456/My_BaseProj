//
//  UBLRetrievePasswordTBVCell.h
//  UBLLive
//
//  Created by Jobs on 2020/11/26.
//  Copyright © 2020 UBL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UBLRetrievePasswordTBVCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;
-(void)actionBlockRetrievePasswordTBVCell:(MKDataBlock)retrievePasswordTBVCellBlock;

@end

NS_ASSUME_NONNULL_END
