//
//  CommentPopUpCarryOnVC.m
//  My_BaseProj
//
//  Created by Jobs on 2020/7/28.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CommentPopUpCarryOnVC.h"
#import "CommentPopUpVC.h"

@interface CommentPopUpCarryOnVC ()
{
    BOOL isOpen;
    CGFloat liftingHeight;
    CGFloat CommentPopUpVC_Y;
}

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,strong)CommentPopUpVC *commentPopUpVC;

@end

@implementation CommentPopUpCarryOnVC

- (void)dealloc {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    CommentPopUpCarryOnVC *vc = CommentPopUpCarryOnVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        isOpen = NO;
        liftingHeight = SCREEN_HEIGHT / 2;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    [self keyboard];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}
//每次刷新视图的时候会很频繁的回调 viewWillLayoutSubviews 和 viewDidLayoutSubviews
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"self.commentPopUpVC.view弹出");//self.commentPopUpVC.view.frame = (0 0; 414 896); self.commentPopUpVC.view.frame = (0 896; 414 448);self.commentPopUpVC.view.frame = (0 896; 414 448);
    NSLog(@"键盘输入");//self.commentPopUpVC.view.frame = (0 102; 414 448);&& self.commentPopUpVC.view.frame = (0 448; 414 448);
    NSLog(@"self.commentPopUpVC.view退出");//self.commentPopUpVC.view.frame = (0 448; 414 448);self.commentPopUpVC.view.frame = (0 0; 414 896);
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"self.commentPopUpVC.view弹出");//self.commentPopUpVC.view.frame = (0 896; 414 448);self.commentPopUpVC.view.frame = (0 896; 414 448);self.commentPopUpVC.view.frame = (0 448; 414 448);
    NSLog(@"键盘输入");//self.commentPopUpVC.view.frame = (0 448; 414 448);&& self.commentPopUpVC.view.frame = (0 448; 414 448);
    NSLog(@"self.commentPopUpVC.view退出");//self.commentPopUpVC.view.frame = (0 896; 414 448);self.commentPopUpVC.view.frame = (0 0; 414 896);
//    self.commentPopUpVC.view.mj_y = CommentPopUpVC_Y;//开102 关448
    if (CommentPopUpVC_Y != SCREEN_HEIGHT / 2 && CommentPopUpVC_Y != 0) {
        self.commentPopUpVC.view.mj_y = CommentPopUpVC_Y;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)keyboard{
#warning 此处必须禁用IQKeyboardManager，因为框架的原因，弹出键盘的时候是整个VC全部向上抬起，一个是弹出的高度不对，第二个是弹出的逻辑不正确，就只是需要评论页向上同步弹出键盘高度即可。可是一旦禁用IQKeyboardManager这里就必须手动监听键盘弹出高度，再根据这个高度对评论页做二次约束
    [IQKeyboardManager sharedManager].enable = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}
// 点击输入框 弹出软键盘commentPopUpVC.view 整体向上弹出一段软键盘高度的距离 self.commentPopUpVC.view.frame = (0 102; 414 448) ——> self.commentPopUpVC.view.frame = (0 448; 414 448)
// 软键盘失去焦点，键盘消失，commentPopUpVC.view回归正常位置 self.commentPopUpVC.view.frame = (0 448; 414 448);
- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];//(origin = (x = 0, y = 896), size = (width = 414, height = 346))
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];//(origin = (x = 0, y = 550), size = (width = 414, height = 346))
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
    self.commentPopUpVC.view.mj_y -= KeyboardOffsetY;
    CommentPopUpVC_Y = self.commentPopUpVC.view.mj_y;//开102 关448
    NSLog(@"键盘弹出");//self.commentPopUpVC.view.frame = (0 102; 414 448);
    NSLog(@"键盘关闭");//self.commentPopUpVC.view.frame = (0 448; 414 448);
}

- (void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
    NSLog(@"键盘弹出");//self.commentPopUpVC.view.frame = (0 102; 414 448);
    NSLog(@"键盘关闭");//self.commentPopUpVC.view.frame = (0 448; 414 448);
}
#pragma mark —— PopUpVCDelegate
- (void)closeComment {

}

-(void)willOpen{
    [self.commentPopUpVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self->liftingHeight);
        make.bottom.mas_equalTo(self->liftingHeight);
    }];
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
        [self.commentPopUpVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
        }];
        // 注意需要再执行一次更新约束
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self->isOpen = !self->isOpen;
    }];
}

-(void)willClose_vertical{
    [UIView animateWithDuration:0.3f
                     animations:^{
        [self.commentPopUpVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self->liftingHeight);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
                //vc的view减1
        [self.commentPopUpVC.view removeFromSuperview];
        //vc为0
        [self.commentPopUpVC removeFromParentViewController];
        self->_commentPopUpVC = nil;
        self->isOpen = !self->isOpen;
    }];
}

-(void)willClose_horizont{
    [UIView animateWithDuration:0.3f
                     animations:^{
        [self.commentPopUpVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(self->liftingHeight);
            make.left.mas_equalTo(SCREEN_WIDTH);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        //vc的view减1
        [self.commentPopUpVC.view removeFromSuperview];
        //vc为0
        [self.commentPopUpVC removeFromParentViewController];
        self->_commentPopUpVC = nil;
        self->isOpen = !self->isOpen;
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        UIView *touchView = touch.view;
        if (touchView == _commentPopUpVC.view) {
            
        }else if(touchView == self.view){
            if (_commentPopUpVC.view) {
                [self willClose_vertical];
            }else{
                [self willOpen];
            }
        }else{}
    }
}

#pragma mark —— lazyload
-(CommentPopUpVC *)commentPopUpVC{
    if (!_commentPopUpVC) {
        _commentPopUpVC = CommentPopUpVC.new;
        _commentPopUpVC.liftingHeight = liftingHeight;
        [UIView appointCornerCutToCircleWithTargetView:_commentPopUpVC.view
                                     byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                           cornerRadii:CGSizeMake(20, 20)];
        [self addChildViewController:_commentPopUpVC];
        [self.view addSubview:_commentPopUpVC.view];
        [_commentPopUpVC actionBlock:^(id data) {
            MoveDirection moveDirection = [data intValue];
            if (moveDirection == MoveDirection_vertical_down) {
                [self willClose_vertical];
            }else if (moveDirection == MoveDirection_horizont_right){
                [self willClose_horizont];
            }else if (moveDirection == MoveDirection_vertical_up){
                [self willOpen];
            }else{}
        }];
    }return _commentPopUpVC;
}


@end
