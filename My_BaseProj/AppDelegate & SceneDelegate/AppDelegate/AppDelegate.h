//
//  AppDelegate.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#ifdef DEBUG
#import <DoraemonKit/DoraemonManager.h>
#endif

#import "NoticePopupView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(readonly,strong)NSPersistentCloudKitContainer *persistentContainer;
@property(nonatomic,strong)UIWindow *window;//仅仅为了iOS 13 版本向下兼容而存在
@property(nonatomic,strong)TabbarVC *tabbarVC;
@property(nonatomic,strong)NoticePopupView *popupView;

- (void)saveContext;
+(instancetype)sharedInstance;

@end


