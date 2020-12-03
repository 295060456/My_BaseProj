//
//  DoorInputViewStyle_2.h
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBLDoorInputViewBaseStyle.h"
#import "ImageCodeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLDoorInputViewStyle_1 : UBLDoorInputViewBaseStyle

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)ZYTextField *tf;
//@property(nonatomic,strong)JobsTextField *tf;
@property(nonatomic,strong)UIButton *countDownBtn;
@property(nonatomic,assign)CGFloat inputViewWidth;
@property(nonatomic,assign)CGFloat inputViewHeight;
@property(nonatomic,assign)int time;

-(void)actionBlockdoorInputViewStyle_1:(FourDataBlock)doorInputViewStyle_1Block;//监测输入字符回调
-(void)actionBlockDoorInputViewStyle_1CountDownBtnClick:(MKDataBlock)doorInputViewStyle_1CountDownBtnClickBlock;//验证码按钮点击事件回调

@end

NS_ASSUME_NONNULL_END
