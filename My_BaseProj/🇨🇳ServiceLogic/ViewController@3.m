//
//  ViewController@3.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@3.h"

#import "UBLDoorVC.h"
#import "JobsAppDoorVC.h"

@interface ViewController_3 ()

@end

@implementation ViewController_3

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:true];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    //尝试高仿蜜柚 登录注册忘记密码
    [UIViewController comingFromVC:self
                              toVC:JobsAppDoorVC.new
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:@(doorBgType_Image)
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:^(id data) {
        
    }];
    return;
    //临时占位，测试注册登录忘记密码
    [UIViewController comingFromVC:self
                              toVC:UBLDoorVC.new
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:@(doorBgType_Image)
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:^(id data) {
        
    }];
}

@end
