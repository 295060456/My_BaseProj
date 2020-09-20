//
//  ViewController.m
//  JRTTDialog
//
//  Created by 付森 on 2020/4/10.
//  Copyright © 2020 付森. All rights reserved.
//

#import "ViewController.h"
#import "FSReplyController.h"
#import "FSPresentationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemAction)];
    
}

- (void)rightBarItemAction
{
    FSReplyController *controller = [[FSReplyController alloc] init];
    
    controller.modalPresentationStyle = UIModalPresentationCustom;
    
    controller.transitioningDelegate = (id<UIViewControllerTransitioningDelegate>)self;
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate


//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
//
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;
//
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    FSPresentationController *controller = [[FSPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    return controller;
}

@end
