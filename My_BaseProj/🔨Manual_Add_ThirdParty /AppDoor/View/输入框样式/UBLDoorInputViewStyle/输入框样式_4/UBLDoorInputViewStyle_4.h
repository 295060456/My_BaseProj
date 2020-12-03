//
//  UBLDoorInputViewStyle_4.h
//  UBLLive
//
//  Created by Jobs on 2020/12/2.
//  Copyright © 2020 UBL. All rights reserved.
//

#import "UBLDoorInputViewBaseStyle.h"
#import "ImageCodeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLDoorInputViewStyle_4 : UBLDoorInputViewBaseStyle

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)ZYTextField *tf;
@property(nonatomic,strong)ImageCodeView *imageCodeView;
@property(nonatomic,strong)UIImage *btnSelectedIMG;
@property(nonatomic,strong)UIImage *btnUnSelectedIMG;
@property(nonatomic,assign)CGFloat inputViewWidth;
@property(nonatomic,assign)BOOL isShowSecurityMode;
@property(nonatomic,assign)NSInteger limitLength;//输入限制

-(void)actionBlockDoorInputViewStyle_4:(FourDataBlock)doorInputViewStyle_4Block;//监测输入字符回调

@end

NS_ASSUME_NONNULL_END
