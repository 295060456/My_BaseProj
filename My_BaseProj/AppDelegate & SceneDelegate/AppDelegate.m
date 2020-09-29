//
//  AppDelegate.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#ifdef DEBUG
#import <DoraemonKit/DoraemonManager.h>
#endif

#import "AppDelegate.h"
#import "CustomSYSUITabBarController.h"

@interface AppDelegate ()

@property(nonatomic,strong)UINavigationController *navigationController;
@property(nonatomic,strong)CustomSYSUITabBarController *customSYSUITabBarController;

@end

@implementation AppDelegate

static AppDelegate *static_appDelegate = nil;
+(AppDelegate *)sharedInstance{
    @synchronized(self){
        if (!static_appDelegate) {
            static_appDelegate = AppDelegate.new;
        }
    }return static_appDelegate;
}

-(instancetype)init{
    if (self = [super init]) {
        static_appDelegate = self;
    }return self;
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#ifdef DEBUG
    [[DoraemonManager shareInstance] install];
    /**
     *  宏忽略警告-+         */
    SuppressPerformSelectorLeakWarning(
                                       id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
                                       [overlayClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
                                       );
#endif
    
#pragma mark —— 网络监控
    [FMARCNetwork.sharedInstance AFNReachability];
//    [GKConfigure setupDefaultConfigure];
// 沙盒路径
    NSString *directory = NSHomeDirectory();
    NSLog(@"沙盒路径 : %@", directory);
    // 配置导航栏属性
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure * _Nonnull configure) {
        configure.gk_translationX = 15;
        configure.gk_translationY = 20;
        configure.gk_scaleX = 0.90;
        configure.gk_scaleY = 0.92;
        // 导航栏背景色
        configure.backgroundColor = kClearColor;
        // 导航栏标题颜色
        configure.titleColor = kWhiteColor;
        // 导航栏标题字体
        configure.titleFont = [UIFont systemFontOfSize:18.0f];
        // 导航栏返回按钮样式
        configure.backStyle = GKNavigationBarBackStyleBlack;
        // 导航栏左右item间距
        configure.gk_navItemLeftSpace = 12.0f;
        configure.gk_navItemRightSpace = 12.0f;
    }];
    
    //如果系统版本低于iOS 13.0 则运行以下代码
    if (@available(iOS 13.0, *)) {

    }else{
        self.window.rootViewController = self.navigationController;
        [self.window makeKeyAndVisible];
    }
    return YES;
}
//系统版本低于iOS13.0的设备
-(void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"---applicationDidEnterBackground----"); //进入后台
}

-(void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"---applicationDidBecomeActive----");//进入前台
}
#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application
configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
                              options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration"
                                          sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application
didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

#pragma mark - Core Data stack
@synthesize persistentContainer = _persistentContainer;
- (NSPersistentCloudKitContainer *)persistentContainer  API_AVAILABLE(ios(13.0)){
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:@"MonkeyKingVideo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }return _persistentContainer;
}

#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
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
