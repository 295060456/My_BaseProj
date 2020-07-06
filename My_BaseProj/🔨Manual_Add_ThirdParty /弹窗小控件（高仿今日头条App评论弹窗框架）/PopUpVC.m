//
//  PopUpVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PopUpVC.h"

@interface PopUpVC ()

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)DataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,copy)DataBlock block;
@property(nonatomic,assign)MoveDirection moveDirection;

@end

@implementation PopUpVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                    withStyle:(ComingStyle)comingStyle
                requestParams:(nullable id)requestParams
                      success:(DataBlock)block
                     animated:(BOOL)animated{
    PopUpVC *vc = [PopUpVC sharedInstance];
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
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

+ (instancetype)sharedInstance {
    static PopUpVC *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[super allocWithZone:NULL] init];
        }
    });return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)viewDidLoad{
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = kRedColor;
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    NSLog(@"");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)actionBlock:(DataBlock)block{
    self.block = block;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.view];
    //以前的point
    CGPoint preP = [touch previousLocationInView:self.view];
    //x轴偏移的量
    CGFloat offsetX = currentP.x - preP.x;
    //Y轴偏移的量
    CGFloat offsetY = currentP.y - preP.y;
    
    if(fabs(offsetX) > fabs(offsetY) && self.view.mj_y == self.view.mj_h){//横移
        self.moveDirection = MoveDirection_horizont;
        self.view.transform = CGAffineTransformTranslate(self.view.transform,
                                                         offsetX,
                                                         0);
        if (self.view.mj_x < 0) {
            self.view.mj_x = 0;
        }
    }else if (fabs(offsetX) < fabs(offsetY) && self.view.mj_x == 0){//竖移
        self.moveDirection = MoveDirection_vertical;
        self.view.transform = CGAffineTransformTranslate(self.view.transform,
                                                         0,
                                                         offsetY);
        if (self.view.mj_y < self.view.mj_h) {
            self.view.mj_y = self.view.mj_h;
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.block) {
        self.block(@(self.moveDirection));
    } 
}

@end
