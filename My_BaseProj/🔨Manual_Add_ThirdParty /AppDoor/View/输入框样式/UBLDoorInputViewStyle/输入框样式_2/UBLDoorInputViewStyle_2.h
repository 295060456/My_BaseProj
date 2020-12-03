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

@interface UBLDoorInputViewStyle_2 : UBLDoorInputViewBaseStyle

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)ZYTextField *tf;
@property(nonatomic,strong)ImageCodeView *imageCodeView;
@property(nonatomic,assign)CGFloat inputViewWidth;
@property(nonatomic,assign)CGFloat inputViewHeight;

-(void)actionBlockDoorInputViewStyle_2:(FourDataBlock)doorInputViewStyle_2Block;//监测输入字符回调

@end

NS_ASSUME_NONNULL_END
