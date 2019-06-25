//
//  AppDelegate.m
//  My_BaseProj
//
//  Created by Administrator on 03/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomSYSUITabBarController.h"

@interface AppDelegate ()

@property(nonatomic,strong)CustomSYSUITabBarController *customSYSUITabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#if DEBUG
    /**
     *  宏忽略警告
     */
    SuppressPerformSelectorLeakWarning(
                                       
                                       id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
                                       
                                       [overlayClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
                                       
                                       );
    
#endif
    
    self.window.frame = [UIScreen mainScreen].bounds;
    
    self.window.backgroundColor = kWhiteColor;
    
    //根试图
    self.window.rootViewController = self.customSYSUITabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background 画＊state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.

}

#pragma mark —— lazyLoad
-(CustomSYSUITabBarController *)customSYSUITabBarController{
    
    if (!_customSYSUITabBarController) {
        
        _customSYSUITabBarController = CustomSYSUITabBarController.new;
    }
    
    return _customSYSUITabBarController;
}



@end
