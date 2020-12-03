//
//  JobsAppDoorContentView.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorContentView.h"

//可以发现：（animateWithDuration + Masonry，动画参数设置无效）

@interface JobsAppDoorContentView ()

@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)MKDataBlock jobsAppDoorContentViewBlock;

@end

@implementation JobsAppDoorContentView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kWhiteColor;
        self.alpha = 0.7;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.toRegisterBtn.alpha = 1;
        self.isOK = YES;
    }
}

-(void)actionBlockJobsAppDoorContentView:(MKDataBlock)jobsAppDoorContentViewBlock{
    self.jobsAppDoorContentViewBlock = jobsAppDoorContentViewBlock;
}

-(void)animationChangeRegisterBtnFrame{
    /*
     *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
     *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
     *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
     *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
     *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
     *    dampingRatio 阻尼
     *    velocity 速度
     */
    @weakify(self)
    [UIView animateWithDuration:0.7
                          delay:0.1
         usingSpringWithDamping:1
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        @strongify(self)
        if (self.toRegisterBtn.selected) {
            [self.toRegisterBtn setTitle:@"返\n回\n登\n录"
                                forState:UIControlStateNormal];
            [self.toRegisterBtn setImage:KIMG(@"用户名称")
                                forState:UIControlStateNormal];
        }else{
            [self.toRegisterBtn setTitle:@"新\n用\n户\n注\n册"
                                forState:UIControlStateNormal];
            [self.toRegisterBtn setImage:KIMG(@"用户名称")
                                forState:UIControlStateNormal];
        }
        
        if (self.jobsAppDoorContentViewBlock) {
            self.jobsAppDoorContentViewBlock(self.toRegisterBtn);
        }
        
        [self.toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:8];
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark —— lazyLoad
-(UIButton *)toRegisterBtn{
    if (!_toRegisterBtn) {
        _toRegisterBtn = UIButton.new;
        _toRegisterBtn.titleLabel.numberOfLines = 0;
        _toRegisterBtn.backgroundColor = kBlackColor;
        _toRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        _toRegisterBtn.alpha = 0.7f;
        [_toRegisterBtn setTitle:@"新\n用\n户\n注\n册"
                        forState:UIControlStateNormal];
        [_toRegisterBtn setImage:KIMG(@"用户名称")
                        forState:UIControlStateNormal];
        @weakify(self)
        [[_toRegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            [self endEditing:YES];
            [self animationChangeRegisterBtnFrame];
        }];
        [self addSubview:_toRegisterBtn];
        _toRegisterBtn.frame = CGRectMake(self.mj_w - 64,
                                          0,
                                          64,
                                          self.mj_h);
        [_toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:8];
    }return _toRegisterBtn;
}

@end
