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
}

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,strong)CommentPopUpVC *commentPopUpVC;

@property(nonatomic,assign)CGFloat CommentPopUpVC_Y;
@property(nonatomic,assign)CGFloat CommentPopUpVC_EditY;//编辑状态下，键盘弹出的时候的CommentPopUpVC.view的高度
@property(nonatomic,assign)BOOL isCommentPopUpVCOpen;//当前CommentPopUpVC.view 是否开合?
@property(nonatomic,assign)CGFloat liftingHeight;
@property(nonatomic,assign)BOOL isBackFromPopAdVC;//是否从广告页pop回来的？

@end

@implementation CommentPopUpCarryOnVC

- (void)dealloc {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#pragma clang diagnostic pop
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
        self.isCommentPopUpVCOpen = NO;
        self.liftingHeight = SCREEN_HEIGHT / 2;
        self.CommentPopUpVC_Y = 0.0;
        self.CommentPopUpVC_EditY = 0.0f;
        self.isBackFromPopAdVC = NO;
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
}
//这个地方必须用下划线属性而不能用self.属性。因为这两个方法反复调用，会触发懒加载
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
//这个地方必须用下划线属性而不能用self.属性。因为这两个方法反复调用，会触发懒加载
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (!_commentPopUpVC.inputView.textField.isInputting) {
        _commentPopUpVC.view.mj_y = self.CommentPopUpVC_Y;
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
// 软键盘失去焦点，键盘消失，commentPopUpVC.view回归正常位置 self.commentPopUpVC.view.frame = (0 448; 414 448);
#warning 因为是通知，这个地方如果写self.commentPopUpVC,可能引起其他地方键盘事件，比如登录的时候，对它进行影响，所以必须用_commentPopUpVC
- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification{//键盘 弹出 和 收回 走这个方法
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];//(origin = (x = 0, y = 896), size = (width = 414, height = 346))
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];//(origin = (x = 0, y = 550), size = (width = 414, height = 346))
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
    NSLog(@"MMM beginFrameY = %f,endFrameY = %f",beginFrame.origin.y,endFrame.origin.y);
    if (self.isCommentPopUpVCOpen && _commentPopUpVC.inputView.textField.isInputting) {//第一次进这个分支，初始化
        if (self.isCommentPopUpVCOpen) {
            if (self.CommentPopUpVC_EditY) {
                if (_commentPopUpVC.inputView.textField.isInputting && !_commentPopUpVC.inputView.isReturnBtnSelect) {
                    if (endFrame.origin.y == SCREEN_HEIGHT) {
                        _commentPopUpVC.view.mj_y = self.liftingHeight;//3
                    }else{
                        _commentPopUpVC.view.mj_y = self.CommentPopUpVC_EditY;//2
                    }
                }else{
                    _commentPopUpVC.view.mj_y = self.CommentPopUpVC_EditY;
                }
            }else{
                _commentPopUpVC.view.mj_y -= KeyboardOffsetY;
                self.CommentPopUpVC_Y = _commentPopUpVC.view.mj_y;
                self.CommentPopUpVC_EditY = self.CommentPopUpVC_Y;//开始编辑的时候的高度（包含键盘弹出高度）
            }
        }else{
            _commentPopUpVC.view.mj_y -= KeyboardOffsetY;
            self.CommentPopUpVC_Y = _commentPopUpVC.view.mj_y;
            self.CommentPopUpVC_EditY = self.CommentPopUpVC_Y;//开始编辑的时候的高度（包含键盘弹出高度）
        }
    }else if (!self.isCommentPopUpVCOpen && _commentPopUpVC.inputView.textField.isInputting){
        //不存在这种可能性
        NSLog(@"");
    }else if (self.isCommentPopUpVCOpen && !_commentPopUpVC.inputView.textField.isInputting){
        if (self.isCommentPopUpVCOpen) {
            if (_commentPopUpVC.inputView.textField.isInputting) {
                _commentPopUpVC.view.mj_y = self.CommentPopUpVC_EditY;//102;//self.CommentPopUpVC_Y;
            }else{
                _commentPopUpVC.view.mj_y = self.liftingHeight;//1
            }
        }else{
            _commentPopUpVC.view.mj_y = self.liftingHeight;
            if (!_commentPopUpVC.isClickExitBtn) {
                self.CommentPopUpVC_Y = self.liftingHeight;
            }
        }
    }else if (!self.isCommentPopUpVCOpen && !_commentPopUpVC.inputView.textField.isInputting){
        _commentPopUpVC.view.mj_y = SCREEN_HEIGHT;
        self.CommentPopUpVC_Y = SCREEN_HEIGHT;
    }else{}
    NSLog(@"");
}

- (void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
    NSLog(@"键盘弹出");//self.commentPopUpVC.view.frame = (0 102; 414 448);
    NSLog(@"键盘关闭");//self.commentPopUpVC.view.frame = (0 448; 414 448);
}

-(void)GiveUpComment{
    [self.view endEditing:YES];
    [self willClose_vertical];
}

-(void)Sorry{
    _commentPopUpVC.view.mj_y = self.CommentPopUpVC_EditY;//102;
}

#pragma mark —— PopUpVCDelegate
- (void)closeComment {

}


-(void)willOpen{
    self.commentPopUpVC.view.alpha = 1;
    [UIView animateWithDuration:0.3f
                     animations:^{
        self.commentPopUpVC.view.mj_y = SCREEN_HEIGHT / 2;
    } completion:^(BOOL finished) {
        //不知为何，这个地方的约束会出现问题，所以在这里写上一句，锁定约束
        self.commentPopUpVC.view.mj_y = SCREEN_HEIGHT / 2;
        self.isCommentPopUpVCOpen = !self.isCommentPopUpVCOpen;
        self.CommentPopUpVC_Y = self.commentPopUpVC.view.mj_y;
        [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
    }];
}

-(void)willClose_vertical{
    [UIView animateWithDuration:0.3f
                     animations:^{
//        [_commentPopUpVC.inputView endEditing:YES];
        self->_commentPopUpVC.view.mj_y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self->_commentPopUpVC.view endEditing:YES];
        //不知为何，这个地方的约束会出现问题，所以在这里写上一句，锁定约束
        self->_commentPopUpVC.view.mj_y = SCREEN_HEIGHT;
        //vc的view减1 这里面避免用self.属性，因为害怕走属性懒加载
        [self->_commentPopUpVC.view removeFromSuperview];
        //vc为0
        [self->_commentPopUpVC removeFromParentViewController];
        self->_commentPopUpVC = nil;
        self.isCommentPopUpVCOpen = !self.isCommentPopUpVCOpen;
        [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    }];
}

-(void)willClose_horizont{
    [UIView animateWithDuration:0.3f
                     animations:^{
//        [self->_commentPopUpVC.inputView endEditing:YES];
        self->_commentPopUpVC.view.x = SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        [self->_commentPopUpVC.view endEditing:YES];
        //vc的view减1 这里面避免用self.属性，因为害怕走属性懒加载
        [self->_commentPopUpVC.view removeFromSuperview];
        //vc为0
        [self->_commentPopUpVC removeFromParentViewController];
        self->_commentPopUpVC = nil;
        self.isCommentPopUpVCOpen = !self.isCommentPopUpVCOpen;
        [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
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
        _commentPopUpVC.liftingHeight = self.liftingHeight;
        [UIView appointCornerCutToCircleWithTargetView:_commentPopUpVC.view
                                     byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                           cornerRadii:CGSizeMake(20, 20)];
        [self addChildViewController:_commentPopUpVC];
        [self.view addSubview:_commentPopUpVC.view];
        [self.view bringSubviewToFront:_commentPopUpVC.view];
        
        //初始化，否则控件是从上落下来的
        _commentPopUpVC.view.mj_y = SCREEN_HEIGHT;
        _commentPopUpVC.view.mj_x = 0;
        _commentPopUpVC.view.mj_w = SCREEN_WIDTH;
        _commentPopUpVC.view.mj_h = self.liftingHeight;
        
        @weakify(self)
        //已经发送评论网络请求成功
        [_commentPopUpVC commentPopUpActionBlock:^(id data) {
            NSLog(@"");
            @strongify(self)
            if ([data isKindOfClass:ZYTextField.class]) {
                if (!self->_commentPopUpVC.inputView.textField.isInputting) {
                    //仅仅键盘消失,commentPopUpVC还在
//                    [_commentPopUpVC.view endEditing:YES];
//                    [self willClose_vertical];//?
                    //发送按钮隐藏
                    [self.view endEditing:YES];
                    [self->_commentPopUpVC.inputView hideSendBtn];
                    self->_commentPopUpVC.view.mj_y = self.liftingHeight;
                }else{
//                    _commentPopUpVC.view.mj_y = 102;//self.CommentPopUpVC_EditY; CommentPopUpVC_Y
                }
            }
        }];
        //点击 或者 拖拽触发事件
        [_commentPopUpVC popUpActionBlock:^(id data) {
            if ([data isKindOfClass:UIButton.class]) {
                self->_commentPopUpVC.isClickExitBtn = YES;
                //判断评论框里面是否有值？
                if ([NSString isNullString:self->_commentPopUpVC.inputView.textField.text]) {
                    [self.view endEditing:YES];
                    [self willClose_vertical];
                }else{
                    [NSObject showSYSAlertViewTitle:@"优质评论会被优先展示"
                                            message:@"确定放弃评论吗？"
                                    isSeparateStyle:NO
                                        btnTitleArr:@[@"我不回复了",@"手滑啦"]
                                     alertBtnAction:@[@"GiveUpComment",@"Sorry"]
                                           targetVC:self
                                       alertVCBlock:^(id data) {
                        //DIY
                    }];
                }
            }else{
                //弹出键盘的时候 没做处理
                MoveDirection moveDirection = [data intValue];
                if (moveDirection == MoveDirection_vertical_down) {
                    [self willClose_vertical];
                }else if (moveDirection == MoveDirection_horizont_right){
                    [self willClose_horizont];
                }else if (moveDirection == MoveDirection_vertical_up){
                    [self willOpen];
                }else{}
            }
        }];
    }return _commentPopUpVC;
}



@end
