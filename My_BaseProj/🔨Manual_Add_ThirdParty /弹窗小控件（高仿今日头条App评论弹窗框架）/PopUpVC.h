//
//  PopUpVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MoveDirection){
    MoveDirection_vertical_up = 0,//垂直方向(向上)滑动
    MoveDirection_vertical_down,//垂直方向(向下)滑动
    MoveDirection_horizont_left,//水平方向(向左)滑动
    MoveDirection_horizont_right//水平方向(向右)滑动
};

@interface PopUpVC : BaseVC

@property(nonatomic,assign)CGFloat liftingHeight;
@property(nonatomic,copy)MKDataBlock block;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;
-(void)popUpActionBlock:(MKDataBlock)block;

@end

NS_ASSUME_NONNULL_END

