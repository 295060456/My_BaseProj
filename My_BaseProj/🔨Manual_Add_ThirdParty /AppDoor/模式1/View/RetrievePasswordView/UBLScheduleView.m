//
//  UBLScheduleView.m
//  UBLLive
//
//  Created by Jobs on 2020/11/25.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "UBLScheduleView.h"

@interface UBLScheduleView ()

@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <UIButton *>*btnMutArr;
@property(nonatomic,strong)NSMutableArray <UIImageView *>*lineMutArr;

@end

@implementation UBLScheduleView

-(instancetype)init{
    if (self = [super init]) {
        self.schedule = 1;//默认就是进度 1
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        [self makeUI];
        self.isOK = YES;
    }
}

-(void)makeUI{
    for (int i = 0; i < self.titleMutArr.count; i++) {
        UIButton *scheduleUnit = UIButton.new;
        [self.btnMutArr addObject:scheduleUnit];
        [scheduleUnit setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
        scheduleUnit.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        [scheduleUnit setImage:KIMG(@"找回密码流程未完成") forState:UIControlStateNormal];
        [scheduleUnit setImage:KIMG(@"找回密码流程已完成或者进行中") forState:UIControlStateSelected];
        
        if (i < self.schedule) {
            scheduleUnit.selected = YES;
        }else{
            scheduleUnit.selected = NO;
        }
        
        [scheduleUnit setTitle:self.titleMutArr[i] forState:UIControlStateNormal];
        [scheduleUnit.titleLabel sizeToFit];
        [self addSubview:scheduleUnit];
        [scheduleUnit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.centerY.equalTo(self);
            if (self.btnMutArr.count == 1) {
                make.left.equalTo(self).offset(71);
            }else if (self.btnMutArr.count == 2){
                make.centerX.equalTo(self);
            }else{
                make.right.equalTo(self).offset(-71);
            }
        }];
        [scheduleUnit layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace:8];
    }
    
    for (int i = 0; i < self.btnMutArr.count - 1; i++) {
        UIImageView *line = UIImageView.new;
        if (i < self.schedule) {
            line.backgroundColor = kBlueColor;
        }else{
            line.backgroundColor = KLightGrayColor;
        }

        [self.lineMutArr addObject:line];
        [self addSubview:line];
        UIButton *btnLeft = self.btnMutArr[i];
        UIButton *btnRight = self.btnMutArr[i + 1];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.equalTo(btnLeft.imageView.mas_right);
            make.right.equalTo(btnRight.imageView.mas_left);
            make.centerY.equalTo(btnLeft.imageView);
        }];
    }
}

-(void)setSchedule:(NSInteger)schedule{
    _schedule = schedule;
}
#pragma mark —— lazyLoad
-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"身份验证"];
        [_titleMutArr addObject:@"修改密码"];
        [_titleMutArr addObject:@"完成"];
    }return _titleMutArr;
}

-(NSMutableArray<UIButton *> *)btnMutArr{
    if (!_btnMutArr) {
        _btnMutArr = NSMutableArray.array;
    }return _btnMutArr;
}

-(NSMutableArray<UIImageView *> *)lineMutArr{
    if (!_lineMutArr) {
        _lineMutArr = NSMutableArray.array;
    }return _lineMutArr;
}

@end
