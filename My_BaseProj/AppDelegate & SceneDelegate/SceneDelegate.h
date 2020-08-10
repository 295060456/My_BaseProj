//
//  SceneDelegate.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSYSUITabBarController.h"

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property(nonatomic,strong)RACSignal *reqSignal;
@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)UIWindowScene *windowScene;
@property(nonatomic,strong)CustomSYSUITabBarController *customSYSUITabBarController;
@property(nonatomic,strong)UINavigationController *navigationController;

+ (SceneDelegate *)sharedInstance;

@end
