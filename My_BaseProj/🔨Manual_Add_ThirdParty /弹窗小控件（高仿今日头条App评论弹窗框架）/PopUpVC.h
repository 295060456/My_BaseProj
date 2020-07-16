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
    MoveDirection_horizont = 0,//水平方向滑动
    MoveDirection_vertical//垂直方向滑动
};

@interface PopUpVC : BaseVC

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                   withStyle:(ComingStyle)comingStyle
               requestParams:(nullable id)requestParams
                     success:(DataBlock)block
                    animated:(BOOL)animated;
-(void)actionBlock:(DataBlock)block;

@end

NS_ASSUME_NONNULL_END

/* 使用示例

{
    BOOL isOpen;
    CGFloat liftingHeight;
}
@property(nonatomic,weak)PopUpVC *popUpVC;

-(instancetype)init{
    if (self = [super init]) {
        isOpen = NO;
        liftingHeight = SCREEN_HEIGHT / 2;
    }return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    //初始值为NO
    if (isOpen) {//目前为开
        [self willClose_vertical];
    }else{//目前为关
        if (!_popUpVC) {
            [self willOpen];
        }
    }
}

 -(void)willOpen{
     @weakify(self)
     [self.commentPopUpVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.equalTo(self.view);
         make.height.mas_equalTo(self->liftingHeight);
         make.bottom.mas_equalTo(self->liftingHeight);
     }];
     [self.view layoutIfNeeded];
     
     [UIView animateWithDuration:0.3f
                      animations:^{
         @strongify(self)
         [self.commentPopUpVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
             make.bottom.mas_equalTo(0);
         }];
         // 注意需要再执行一次更新约束
         [self.view layoutIfNeeded];
     } completion:^(BOOL finished) {
         @strongify(self)
         self->isOpen = !self->isOpen;
     }];
 }

 -(void)willClose_vertical{
     @weakify(self)
     [UIView animateWithDuration:0.3f
                      animations:^{
         @strongify(self)
         [self.commentPopUpVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
             make.bottom.mas_equalTo(self->liftingHeight);
         }];
         [self.view layoutIfNeeded];
     } completion:^(BOOL finished) {
 //        @strongify(self)
         weak_self.commentPopUpVC = nil;//不写这一句，反复暴力点击的时候会崩
         self->isOpen = !self->isOpen;
     }];
 }

 -(void)willClose_horizont{
     @weakify(self)
     [UIView animateWithDuration:0.3f
                      animations:^{
         @strongify(self)
         [self.commentPopUpVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
 //            make.bottom.mas_equalTo(self->liftingHeight);
             make.left.mas_equalTo(SCREEN_WIDTH);
         }];
         [self.view layoutIfNeeded];
     } completion:^(BOOL finished) {
         @strongify(self)
         weak_self.commentPopUpVC = nil;//不写这一句，反复暴力点击的时候会崩
         self->isOpen = !self->isOpen;
     }];
 }

-(PopUpVC *)popUpVC{
    if (!_popUpVC) {
        _popUpVC = [PopUpVC sharedInstance];
        [self addChildViewController:_popUpVC];
        [self.view addSubview:_popUpVC.view];
        @weakify(self)
        [_popUpVC actionBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)data;
                if (num.intValue == MoveDirection_horizont) {
                    [self willClose_horizont];
                }else if (num.intValue == MoveDirection_vertical){
                    [self willClose_vertical];
                }else{}
            }
        }];
    }return _popUpVC;
}

*/
