//
//  SceneDelegate.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property(strong,nonatomic)UIWindow * window;
@property(nonatomic,strong)CustomSYSUITabBarController *customSYSUITabBarController;

+ (instancetype)sharedInstance;

@end

