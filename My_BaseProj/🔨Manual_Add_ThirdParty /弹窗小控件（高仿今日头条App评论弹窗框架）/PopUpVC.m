//
//  PopUpVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PopUpVC.h"

@interface PopUpVC ()
<
UIGestureRecognizerDelegate
>

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,strong)UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeGestureRecognizerUp;
@property(nonatomic,strong)UISwipeGestureRecognizer *swipeGestureRecognizerDown;

/// move 0 不动 1 右 -1 下
@property (nonatomic, assign) NSInteger isMove;

/// move
@property (nonatomic, assign) CGFloat moveDistance;

@end

@implementation PopUpVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    PopUpVC *vc = PopUpVC.new;
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
    }return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.panGestureRecognizer.enabled = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    NSLog(@"");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)popUpActionBlock:(MKDataBlock)block{
    self.block = block;
}

- (void)swipeGestureRecognizerDirection:(UISwipeGestureRecognizer *)swipe{
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight:{
            if (self.block) {
                self.block(@(MoveDirection_horizont_right));//消失
            }
        }break;
        case UISwipeGestureRecognizerDirectionLeft:{
            
        }break;
        case UISwipeGestureRecognizerDirectionUp:{
            if (self.block) {
                self.block(@(MoveDirection_vertical_up));
            }
        }break;
        case UISwipeGestureRecognizerDirectionDown:{
            if (self.block) {
                self.block(@(MoveDirection_vertical_down));
            }
        }break;
            
        default:
            break;
    }
}
#pragma mark - UIGestureRecognizerDelegate
//每次走2次
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch{
//    NSLog(@"shouldReceiveTouch");
    return YES;
}
//是否接收一个手势触摸事件，默认为YES，返回NO为不接收
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    return YES;
}
//拖拽手势
- (void)pan:(UIPanGestureRecognizer *)panGestureRecognizer{
    // 获取手势状态
    UIGestureRecognizerState gestureRecognizerState = panGestureRecognizer.state;
    // 获取手指的偏移量
    CGPoint translatePoint = [panGestureRecognizer translationInView:self.view];
    // 移动方向
//    CGPoint velocity = [self.panGestureRecognizer velocityInView:self.view];
    NSLog(@"point:%@",NSStringFromCGPoint(translatePoint));
    if (gestureRecognizerState == UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan point:%@",NSStringFromCGPoint(translatePoint));
        if (translatePoint.x < 0 || translatePoint.y < 0) {
            self.isMove = 0;
        }else{
            if (translatePoint.x > translatePoint.y) {
                self.isMove = 1;
            }else{
                self.isMove = -1;
            }
        }
    }else if (gestureRecognizerState == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged point:%@",NSStringFromCGPoint(translatePoint));
            
            if (self.isMove == 1) {
                self.view.center = CGPointMake(self.view.center.x + translatePoint.x,self.view.center.y);
                self.moveDistance = translatePoint.x;
            }else if (self.isMove == -1){
                if (translatePoint.y > 0) {
                    self.view.center = CGPointMake(self.view.center.x ,self.view.center.y + translatePoint.y);
                    self.moveDistance = translatePoint.y;
                }else{
                    self.moveDistance = 0;
                }
            }else{
                self.moveDistance = 0;
            }
            [panGestureRecognizer setTranslation:CGPointZero inView:self.view];

    }else if (gestureRecognizerState == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded point:%@",NSStringFromCGPoint(translatePoint));

            if (self.view.left < SCREEN_WIDTH / 2) {
                if (self.isMove == 1 && self.moveDistance > 20) {
                    if (self.block) {
                        self.block(@(MoveDirection_horizont_right));//消失
                        return;
                    }
                }else{
                    self.view.left = 0;
                }
            }else{
                if (self.block) {
                    self.block(@(MoveDirection_horizont_right));//消失
                }
            }

            if (self.view.top > self.liftingHeight * 1.5) {
                if (self.block) {
                    self.block(@(MoveDirection_vertical_down));//消失
                }
            }else{
                if (self.moveDistance > 20) {
                    if (self.block) {
                        self.block(@(MoveDirection_vertical_down));//消失
                        return;
                    }
                }else{
                    self.view.top = self.liftingHeight;
                }
            }
    }
}

#pragma mark —— lazyLoad
-(UIPanGestureRecognizer *)panGestureRecognizer{
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(pan:)];
        _panGestureRecognizer.minimumNumberOfTouches = 1;//default = 1
        [self.view addGestureRecognizer:_panGestureRecognizer];
        _panGestureRecognizer.delegate = self;
    }return _panGestureRecognizer;
}

-(UISwipeGestureRecognizer *)swipeGestureRecognizerUp{
    if (!_swipeGestureRecognizerUp) {
        _swipeGestureRecognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(swipeGestureRecognizerDirection:)];
        // 轻扫方向:默认是右边
        _swipeGestureRecognizerUp.direction = UISwipeGestureRecognizerDirectionRight;
        _swipeGestureRecognizerUp.delegate = self;
    }return _swipeGestureRecognizerUp;
}

-(UISwipeGestureRecognizer *)swipeGestureRecognizerDown{
    if (!_swipeGestureRecognizerDown) {
        _swipeGestureRecognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(swipeGestureRecognizerDirection:)];
        // 轻扫方向:默认是右边
        _swipeGestureRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
        _swipeGestureRecognizerDown.delegate = self;
        //[self.view addGestureRecognizer:_swipeGestureRecognizerDown];
    }return _swipeGestureRecognizerDown;
}

-(CGFloat)liftingHeight{
    if (!_liftingHeight) {
        
    }return _liftingHeight;
}

@end
