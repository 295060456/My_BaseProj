//
//  WGradientProgress.h
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGradientProgress : UIView

@property(nonatomic,assign)CGFloat progress;

-(void)showOnParent:(UIView *)parentView;
-(void)hide;
///旋转 以适应不同方向的直线型进度条
-(void)setTransformRadians:(CGFloat)transformRadians;

@end
