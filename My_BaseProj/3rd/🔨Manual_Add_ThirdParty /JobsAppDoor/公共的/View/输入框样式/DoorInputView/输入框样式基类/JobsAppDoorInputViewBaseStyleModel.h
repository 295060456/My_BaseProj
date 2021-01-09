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
@property(nonatomic,strong)NSString *nickNamePlaceHolderStr;
@property(nonatomic,strong)NSString *titleLabStr;
@property(nonatomic,strong)UIFont *titleStrFont;
@property(nonatomic,strong)UIColor *titleStrCor;
@property(nonatomic,strong)NSString *inputStr;//输入框里面的实时内容
@property(nonatomic,assign)NSInteger inputCharacterRestriction;//输入字符限制
@property(nonatomic,assign)BOOL isShowDelBtn;//是否显示删除按钮，默认不显示
@property(nonatomic,assign)BOOL isShowSecurityBtn;//是否显示安全按钮（眼睛），默认不显示
@property(nonatomic)UIReturnKeyType returnKeyType;
@property(nonatomic)UIKeyboardAppearance keyboardAppearance;
@property(nonatomic)UITextFieldViewMode leftViewMode;
// 关于 ZYTextField 的
@property(nonatomic,assign)CGFloat TFRiseHeight;// 键盘在此手机上的最高弹起，区别于全面屏结合非全面屏，有一个安全区域34
@property(nonatomic,assign)CGFloat placeHolderOffset;//左/右/居中 对齐的时候的偏移量 传正值
@property(nonatomic,assign)CGFloat ZYTextFieldCornerRadius;
@property(nonatomic,assign)CGFloat ZYTextFieldBorderWidth;
@property(nonatomic,assign)CGFloat offset;
@property(nonatomic,assign)CGFloat leftViewOffsetX;
@property(nonatomic,assign)CGFloat rightViewOffsetX;
@property(nonatomic,assign)PlaceHolderAlignment placeHolderAlignment;//PlaceHolder的位置
@property(nonatomic,assign)BOOL ZYTextFieldMasksToBounds;
@property(nonatomic,assign)UIColor *ZYTextFieldBorderColor;
@property(nonatomic,strong)UIColor *ZYtextColor;//文本颜色
@property(nonatomic,strong)UIColor *ZYtintColor;//光标颜色
@property(nonatomic,strong)UIColor *ZYplaceholderLabelTextColor_1;//占位文字颜色 失去焦点
@property(nonatomic,strong)UIColor *ZYplaceholderLabelTextColor_2;//占位文字颜色 聚焦状态
@property(nonatomic,strong)UIFont *ZYtextFont;//字体大小
@property(nonatomic,strong)UIFont *ZYplaceholderLabelFont_1;//占位文字字体 失去焦点
@property(nonatomic,strong)UIFont *ZYplaceholderLabelFont_2;//占位文字字体 聚焦状态
@property(nonatomic,strong)NSMutableArray <RichLabelDataStringsModel *>*richLabelDataStringsForPlaceHolderMutArr;

@end

NS_ASSUME_NONNULL_END
