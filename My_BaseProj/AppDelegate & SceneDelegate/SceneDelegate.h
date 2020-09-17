//
//  SceneDelegate.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSYSUITabBarController.h"
#import "MKLaunchingAdModel.h"

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)UIWindowScene *windowScene;
@property(nonatomic,strong)CustomSYSUITabBarController *customSYSUITabBarController;
@property(nonatomic,strong)UINavigationController *navigationController;
@property(nonatomic,strong)MKLaunchingAdModel *launchingAdModel;
@property(nonatomic,strong)NSString *launchingAdPathStr;

+(SceneDelegate *)sharedInstance;

@end

