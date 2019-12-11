//
//  LGiOSBtn.m
//  My_BaseProj
//
//  Created by hello on 2019/7/4.
//  Copyright © 2019 Corp. All rights reserved.
//

#import "LGiOSBtn.h"

@interface LGiOSBtn (){
    
    
}

// 是否抖动
@property (nonatomic, assign, getter=isShaking) BOOL shaking;
// 右上角的按钮，
@property (nonatomic, weak) UIImageView *iconBtn;
// 遮盖，在抖动时出现
@property (nonatomic, weak) UIView *coverView;

@end

@implementation LGiOSBtn

- (UIImageView *)iconBtn {
    if (!_iconBtn) {
        UIImageView *iconBtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyStore"]];
        iconBtn.userInteractionEnabled = YES;
        iconBtn.hidden = YES;
        _iconBtn = iconBtn;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick)];
        [iconBtn addGestureRecognizer:tap];
        [self addSubview:iconBtn];
    }
    return _iconBtn;
}

- (UIView *)coverView {
    if (!_coverView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        view.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        _coverView = view;
    }
    return _coverView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addLongPressGestureRecognizer];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addLongPressGestureRecognizer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addLongPressGestureRecognizer];
    }
    return self;
}

// 添加长按手势
- (void)addLongPressGestureRecognizer {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longClick)];
    [self addGestureRecognizer:longPress];
}

//- (void)delete {
//    [self.iconBtn.superview removeFromSuperview];
//}

// 是否执行动画
- (void)setShaking:(BOOL)shaking {
    if (shaking) {
        [self shakingAnimation];
        self.coverView.hidden = NO;
        self.iconBtn.hidden = NO;
    } else {
        [self.layer removeAllAnimations];
        self.coverView.hidden = YES;
        self.iconBtn.hidden = YES;
    }
}

#pragma mark - 抖动动画
#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)
- (void)shakingAnimation {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(Angle2Radian(-5)),  @(Angle2Radian(5)), @(Angle2Radian(-5))];
    anim.duration = 0.25;
    
    // 动画次数设置为最大
    anim.repeatCount = MAXFLOAT;
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:anim forKey:@"shake"];
}

- (void)longClick {
    if (self.shaking) return;
    self.shaking = YES;
}

// 点击右上角按钮
- (void)iconClick {
    [self removeFromSuperview];
    // 设计一个代理，为了在自己被删除后做一些事情(例如，对页面进行布局)
    if ([self.delegate respondsToSelector:@selector(deleteButtonRemoveSelf:)]) {
        [self.delegate deleteButtonRemoveSelf:self];
    }
}

- (void)coverClick {
    self.shaking = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整位置
    self.imageView.mj_x = 0;
    self.imageView.mj_y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    
    self.titleLabel.mj_x = 0;
    self.titleLabel.width = self.width;
    if (self.width >= self.height) {
        self.titleLabel.height = 20;
        self.titleLabel.mj_y = self.height - self.titleLabel.height;
    } else {
        self.titleLabel.mj_y = self.imageView.height;
        self.titleLabel.height = self.height - self.titleLabel.mj_y;
    }
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.iconBtn.size = CGSizeMake(self.width * 0.3, self.width * 0.3);
    self.iconBtn.mj_x = self.width - self.iconBtn.width;
    self.iconBtn.mj_y = 0;
    
    self.coverView.frame = self.bounds;
    [self bringSubviewToFront:self.iconBtn];
}




@end
