//
//  DoorInputViewStyle_3.h
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBLDoorInputViewBaseStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLDoorInputViewStyle_3 : UBLDoorInputViewBaseStyle

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)ZYTextField *tf;
@property(nonatomic,strong)UIImage *btnSelectedIMG;
@property(nonatomic,strong)UIImage *btnUnSelectedIMG;
@property(nonatomic,assign)CGFloat inputViewWidth;
@property(nonatomic,assign)BOOL isShowSecurityMode;
@property(nonatomic,assign)NSInteger limitLength;//输入限制

-(void)actionBlockDoorInputViewStyle_3:(FourDataBlock)doorInputViewStyle_3Block;//监测输入字符回调

@end

NS_ASSUME_NONNULL_END
