//
//  JobsAppDoorContentView.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorContentView.h"

//可以发现：（animateWithDuration + Masonry，动画参数设置无效）
static float ThingsHeight = 50;//边角半圆形控件的高度
static float RegisterBtnWidth = 64;//竖形按钮的宽度

@interface JobsAppDoorContentView ()

@property(nonatomic,strong)UILabel *titleLab;//标题
@property(nonatomic,strong)UIButton *abandonLoginBtn;//随便逛逛按钮
@property(nonatomic,strong)UIButton *loginBtn;//登录按钮
@property(nonatomic,strong)UIButton *registerBtn;//注册按钮
@property(nonatomic,strong)NSMutableArray <NSString *>*loginTitleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*registerTitleMutArr;
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)MKDataBlock jobsAppDoorContentViewBlock;

@end

@implementation JobsAppDoorContentView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [kWhiteColor colorWithAlphaComponent:0.7];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        //进页面最初是登录
        self.toRegisterBtn.alpha = 1;
        self.titleLab.alpha = 1;
        self.abandonLoginBtn.alpha = 1;
        self.loginBtn.alpha = 1;
        self.isOK = YES;
    }
}

-(void)actionBlockJobsAppDoorContentView:(MKDataBlock)jobsAppDoorContentViewBlock{
    self.jobsAppDoorContentViewBlock = jobsAppDoorContentViewBlock;
}

-(void)makeInputView{
//    UBLDoorInputViewStyle_3 *inputView;
    
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
            
            self.registerBtn.alpha = 1;
            self.abandonLoginBtn.alpha = 0;
            self.loginBtn.alpha = 0;
            
            self.titleLab.centerX = (self.mj_w + self.toRegisterBtn.mj_w) / 2;
            self.titleLab.text = @"注册";
            [self.toRegisterBtn setTitle:@"返\n回\n登\n录"
                                forState:UIControlStateNormal];
            [self.toRegisterBtn setImage:KIMG(@"用户名称")
                                forState:UIControlStateNormal];
        }else{
            
            self.registerBtn.alpha = 0;
            self.abandonLoginBtn.alpha = 1;
            self.loginBtn.alpha = 1;
            
            self.titleLab.centerX = (self.mj_w - self.toRegisterBtn.mj_w) / 2;
            self.titleLab.text = @"登录";
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
        _toRegisterBtn.backgroundColor = [kBlackColor colorWithAlphaComponent:.6f];
        _toRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
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
        _toRegisterBtn.frame = CGRectMake(self.mj_w - RegisterBtnWidth,
                                          0,
                                          RegisterBtnWidth,
                                          self.mj_h);
        [_toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:8];
    }return _toRegisterBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"登录";
        _titleLab.textColor = kWhiteColor;
        _titleLab.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        _titleLab.centerX = (self.mj_w - self.toRegisterBtn.mj_w) / 2;
        _titleLab.top = 20;
    }return _titleLab;
}

-(NSMutableArray<NSString *> *)loginTitleMutArr{
    if (!_loginTitleMutArr) {
        _loginTitleMutArr = NSMutableArray.array;
        [_loginTitleMutArr addObject:@"用户名"];
        [_loginTitleMutArr addObject:@"密码"];
    }return _loginTitleMutArr;
}

-(NSMutableArray<NSString *> *)registerTitleMutArr{
    if (!_registerTitleMutArr) {
        _registerTitleMutArr = NSMutableArray.array;
        [_registerTitleMutArr addObject:@"用户名"];
        [_registerTitleMutArr addObject:@"密码"];
        [_registerTitleMutArr addObject:@"确认密码"];
        [_registerTitleMutArr addObject:@"推广码（可不填写）"];
        [_registerTitleMutArr addObject:@"图形验证码"];
    }return _registerTitleMutArr;
}

-(UIButton *)abandonLoginBtn{
    if (!_abandonLoginBtn) {
        _abandonLoginBtn = UIButton.new;
        [_abandonLoginBtn setTitle:@"随便逛逛"
                          forState:UIControlStateNormal];
        [_abandonLoginBtn setTitleColor:kWhiteColor
                               forState:UIControlStateNormal];
        _abandonLoginBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
        [_abandonLoginBtn.titleLabel sizeToFit];
        @weakify(self)
        [[_abandonLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
        }];
        [self addSubview:_abandonLoginBtn];
        _abandonLoginBtn.mj_x = self.titleLab.mj_x;
        _abandonLoginBtn.bottom = self.height - 30;
        _abandonLoginBtn.size = CGSizeMake(MAINSCREEN_WIDTH / 5, 10);
    }return _abandonLoginBtn;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = UIButton.new;
        [_loginBtn setTitle:@"登录"
                   forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.7];
        [_loginBtn setTitleColor:kWhiteColor
                        forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
        [_loginBtn.titleLabel sizeToFit];
        @weakify(self)
        [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
        }];
        [self addSubview:_loginBtn];
        _loginBtn.mj_x = 20;
        _loginBtn.size = CGSizeMake(self.mj_w - self.toRegisterBtn.mj_w - 40, ThingsHeight);
        _loginBtn.bottom = self.abandonLoginBtn.top - 10;
        [UIView cornerCutToCircleWithView:_loginBtn AndCornerRadius:_loginBtn.mj_h / 2];
    }return _loginBtn;
}

-(UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = UIButton.new;
        [_registerBtn setTitle:@"注册"
                      forState:UIControlStateNormal];
        @weakify(self)
        [[_registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
        }];
        [self addSubview:_registerBtn];
        _registerBtn.mj_x = self.toRegisterBtn.mj_x + self.toRegisterBtn.mj_w + 10;//10是偏移量
        _registerBtn.bottom = self.height - 30;
        _registerBtn.size = CGSizeMake(self.mj_w - self.toRegisterBtn.mj_w - 40, ThingsHeight);
    }return _registerBtn;
}

@end
