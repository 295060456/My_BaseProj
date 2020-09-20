//
//  ViewController.m
//  CommentAlert
//
//  Created by 李立 on 2018/1/8.
//  Copyright © 2018年 李立. All rights reserved.
//

#import "ViewController.h"
#import "CommentActionSheet.h"

@interface ViewController ()
@property (strong, nonatomic) CommentActionSheet *as;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.as = [[CommentActionSheet alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    [self.view addSubview:self.as];
    [self.view bringSubviewToFront:self.as];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)show:(UIButton *)sender
{
    [UIView animateWithDuration:.25f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.as.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100);
    } completion:^(BOOL finished) {
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
