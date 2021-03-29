//
//  ViewController@1.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@1.h"

@interface ViewController_1 ()

@end

@implementation ViewController_1

//https://www.jianshu.com/p/a1e967dead48

//http://devma.cn/blog/2016/04/01/ru-he-sheng-cheng-wen-zi-lou-kong-de-tu-pian/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JobsMagicTextField * bF1 = [[JobsMagicTextField alloc] init];
    bF1.leftView = [[UIImageView alloc] initWithImage:KIMG(@"验证ICON")];
    bF1.leftViewMode = UITextFieldViewModeAlways;
    bF1.placeHolderOffset = 20;
    bF1.frame = CGRectMake(10, 145, self.view.frame.size.width - 20, 50);
    bF1.placeholder = @"变色(Change color)";
    bF1.animationColor = [UIColor redColor];
    [self.view addSubview:bF1];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
