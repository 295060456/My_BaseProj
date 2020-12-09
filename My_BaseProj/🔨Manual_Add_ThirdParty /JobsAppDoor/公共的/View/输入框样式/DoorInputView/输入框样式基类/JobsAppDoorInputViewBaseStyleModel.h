//
//  JobsAppDoorInputViewBaseStyleModel.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorInputViewBaseStyleModel : NSObject

@property(nonatomic,strong)UIImage *leftViewIMG;//
@property(nonatomic,strong)UIImage *selectedSecurityBtnIMG;
@property(nonatomic,strong)UIImage *unSelectedSecurityBtnIMG;
@property(nonatomic,strong)NSString *placeHolderStr;
@property(nonatomic,strong)NSString *inputStr;//输入框里面的实时内容
@property(nonatomic,assign)NSInteger inputCharacterRestriction;//输入字符限制
@property(nonatomic,assign)BOOL isShowDelBtn;//是否显示删除按钮，默认不显示
@property(nonatomic,assign)BOOL isShowSecurityBtn;//是否显示安全按钮（眼睛），默认不显示
@property(nonatomic)UIReturnKeyType returnKeyType;
@property(nonatomic)UIKeyboardAppearance keyboardAppearance;
@property(nonatomic)UITextFieldViewMode leftViewMode;  

@end

NS_ASSUME_NONNULL_END
