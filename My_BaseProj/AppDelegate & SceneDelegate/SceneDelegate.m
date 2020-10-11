//
//  SceneDelegate.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "SceneDelegate+LaunchingAd.h"

API_AVAILABLE(ios(13.0))

@interface SceneDelegate ()

@end

@implementation SceneDelegate

static SceneDelegate *static_sceneDelegate = nil;
+(SceneDelegate *)sharedInstance{
    @synchronized(self){
        if (!static_sceneDelegate) {
            static_sceneDelegate = SceneDelegate.new;
        }
    }return static_sceneDelegate;
}

-(instancetype)init{
    if (self = [super init]) {
        static_sceneDelegate = self;
        self.launchingAdPathStr = [[FileFolderHandleTool cachesDir] stringByAppendingPathComponent:@"LaunchingAd"]; // /Library/caches
    }return self;
}

-(void)KKK:(NSNotification *)noti{
    NSNumber *b = noti.object;
    if (b.intValue == AFNetworkReachabilityStatusNotReachable) {
        [WHToast showErrorWithMessage:@"没有网络连接"
                             duration:2
                        finishHandler:^{
          
        }];
    }
}
//系统版本不低于iOS13.0的设备
- (void)scene:(UIScene *)scene
willConnectToSession:(UISceneSession *)session
      options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        //在这里手动创建新的window
        if (@available(iOS 13.0, *)) {
            self.windowScene = (UIWindowScene *)scene;
        }
#pragma mark —— 启动图
//        [self netWorkingAd];
        [self fixedAdPicsUrl];
//        [self localAdPic];
}

- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}

- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}
#pragma mark —— lazyLoad
-(CustomSYSUITabBarController *)customSYSUITabBarController{
    if (!_customSYSUITabBarController) {
        _customSYSUITabBarController = CustomSYSUITabBarController.new;
    }return _customSYSUITabBarController;
}

-(UINavigationController *)navigationController{
    if (!_navigationController) {
//        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.customSYSUITabBarController];
        _navigationController = [UINavigationController rootVC:self.customSYSUITabBarController
                                               transitionScale:NO];
        _navigationController.navigationBar.hidden = YES;
    }return _navigationController;
}

@end
