//
//  LogoContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorLogoContentView.h"

@interface JobsAppDoorLogoContentView ()

@property(nonatomic,strong)UIImageView *mainImgV;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation JobsAppDoorLogoContentView

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.mainImgV.alpha = 1;
        self.isOK = YES;
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)mainImgV{
    if (!_mainImgV) {
        _mainImgV = UIImageView.new;
        _mainImgV.image = KIMG(@"AppDoorLogo");
        [self addSubview:_mainImgV];
        [_mainImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _mainImgV;
}

@end
