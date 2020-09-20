//
//  FSPresentationController.m
//  JRTTDialog
//
//  Created by 付森 on 2020/4/10.
//  Copyright © 2020 付森. All rights reserved.
//

#import "FSPresentationController.h"

@implementation FSPresentationController

- (CGRect)frameOfPresentedViewInContainerView
{
    CGSize containerSize = self.containerView.frame.size;
    
    NSLog(@"containerSize: %@", NSStringFromCGSize(containerSize));
    
    CGFloat top = 70;
    
    CGRect newFrame = CGRectMake(0, top, containerSize.width, containerSize.height - top);
    
    NSLog(@"newFrame: %@", NSStringFromCGRect(newFrame));
    
    return newFrame;
}

- (void)presentationTransitionWillBegin
{
    [super presentationTransitionWillBegin];
    
    self.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
}


@end
