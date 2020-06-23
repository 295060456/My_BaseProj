//
//  AppDelegate.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomSYSUITabBarController.h"

@interface AppDelegate ()

@property(nonatomic,strong)CustomSYSUITabBarController *customSYSUITabBarController;

@end

@implementation AppDelegate

+ (instancetype)sharedInstance {
    static AppDelegate *_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instace) {
            _instace = [[super allocWithZone:NULL] init];
        }
    });return _instace;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    #if DEBUG
        /**
         *  宏忽略警告
         */
        SuppressPerformSelectorLeakWarning(
                                           
                                           id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
                                           [overlayClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
                                           );
        
    #endif
        // 沙盒路径
        NSString *directory = NSHomeDirectory();
        NSLog(@"沙盒路径 : %@", directory);
        [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application
configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
                              options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
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

-(UIWindow *)window{
    if (!_window) {
        _window = UIWindow.new;
        _window.frame = [UIScreen mainScreen].bounds;
        _window.backgroundColor = kWhiteColor;
        _window.rootViewController = self.customSYSUITabBarController;//根视图
    }return _window;
}

@end
