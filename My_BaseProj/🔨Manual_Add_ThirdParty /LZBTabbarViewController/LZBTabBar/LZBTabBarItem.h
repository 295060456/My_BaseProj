//
//  LZBTabBarItem.h
//  My_BaseProj
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBTabBarItem : UIControl
/**
 *  TabBar单个item的高度
 */
@property(nonatomic,assign)CGFloat itemHeight;

#pragma mark - config 文字样式
/**
 *  文字内容
 */
@property(nonatomic,copy)NSString *title;
/**
 *  文字偏移量
 */
@property(nonatomic,assign)UIOffset titleOffest;
/**
 *  未选中文字属性描述：颜色、字体
 */
@property(nonatomic,strong)NSDictionary *unselectTitleAttributes;
/**
 *  选中文字属性描述：颜色、字体
 */
@property(nonatomic,strong)NSDictionary *selectTitleAttributes;

#pragma mark - config 图片样式
/**
 *  选中图片
 */
@property(nonatomic,strong)UIImage *selectImage;
/**
 *  未选中图片
 */
@property(nonatomic,strong)UIImage *unSelectImage;
/**
 *  图片偏移量
 */
@property(nonatomic,assign)UIOffset imageOffest;
/**
 设置选中和未选中的图片

 @param selectImage 选中图片
 @param unSelectImage 未选中图片
 */
- (void)setSelectImage:(UIImage *)selectImage
         unselectImage:(UIImage *)unSelectImage;

#pragma mark - config 背景View图片样式
/**
 *  选中背景图片
 */
@property(nonatomic,strong)UIImage *selectBackgroundImage;
/**
 *  未选中背景图片
 */
@property(nonatomic,strong)UIImage *unselectBackgroundImage;
/**
 设置背景选中和未选中的图片
 
 @param selectedImage 选中图片
 @param unselectedImage 未选中图片
 */
- (void)setBackgroundSelectedImage:(UIImage *)selectedImage
                   unselectedImage:(UIImage *)unselectedImage;

#pragma mark - config  角标样式
/**
 *  角标文字
 */
@property(nonatomic,copy)NSString *badgeValue;
/**
 *  角标背景图片
 */
@property(nonatomic,strong)UIImage *badgeBackgroundImage;
/**
 *  角标背景颜色
 */
@property(nonatomic,strong)UIColor *badgeBackgroundColor;
/**
 *  角标文字颜色
 */
@property(nonatomic,strong)UIColor *badgeTextColor;
/**
 *  角标文字字体
 */
@property(nonatomic,strong)UIFont *badgeTextFont;
/**
 * 角标偏移量
 */
@property(nonatomic,assign)UIOffset badgeOffset;
/**
 * 角标背景偏移量
 */
@property(nonatomic,assign)UIOffset badgeBackgroundOffset;
/**
 * 手势
*/
@property(nonatomic,strong)UITapGestureRecognizer *tagGR;//敲击
@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;//长按

@property(nonatomic,strong)NSMutableArray<NSString *> *lottieJsonNameStrMutArr;
@property(nonatomic,assign)NSInteger tagger;
@property(nonatomic,strong)LOTAnimationView *animation;

-(void)gestureRecognizerLZBTabBarItemBlock:(TwoDataBlock)LZBTabBarItemGestureRecognizerBlock;
-(void)animationActionLZBTabBarItemBlock:(MKDataBlock)LZBTabBarItemAnimationActionBlock;

@end

NS_ASSUME_NONNULL_END
