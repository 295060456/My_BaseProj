//
//  DoorInputViewBaseStyle_3.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorInputViewBaseStyle_3.h"

@interface DoorInputViewBaseStyle_3 ()
<
UITextFieldDelegate
>

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *securityModeBtn;
@property(nonatomic,copy)MKDataBlock doorInputViewStyle_3Block;
@property(nonatomic,strong)ZYTextField *tf;
@property(nonatomic,strong)UIImage *btnSelectedIMG;
@property(nonatomic,strong)UIImage *btnUnSelectedIMG;

@property(nonatomic,assign)CGFloat inputViewWidth;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,assign)BOOL isShowSecurityMode;
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,assign)NSInteger limitLength;//输入限制

@end

@implementation DoorInputViewBaseStyle_3

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kRedColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        
        self.isOK = YES;
    }
}

-(void)richElementsInViewWithModel:(id _Nullable)model{
    
}

-(void)actionBlockDoorInputViewStyle_3:(MKDataBlock)doorInputViewStyle_3Block{
    
}

@end
