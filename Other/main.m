//
//  main.m
//  My_BaseProj
//
//  Created by Administrator on 03/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <FBAllocationTracker/FBAllocationTrackerManager.h>

int main(int argc, char * argv[]) {
    NSString *appDelegateClassName;
    [[FBAllocationTrackerManager sharedManager] startTrackingAllocations];
    [[FBAllocationTrackerManager sharedManager] enableGenerations];
    @autoreleasepool {
        //        image list -o -f
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }return UIApplicationMain(argc,
                              argv,
                              nil,
                              NSStringFromClass([AppDelegate class]));
}
