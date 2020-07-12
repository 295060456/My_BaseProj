//
//  LZBTabBar.h
//  LZBTabbarViewController
//
//  Created by zibin on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
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

@end

@protocol LZBTabBarDelegate;

typedef enum : NSUInteger {
    LZBTabBarStyleType_sysNormal = 0,//系统默认样式，平的
    LZBTabBarStyleType_middleItemUp//最中间的按钮凸起中间(前提条件是存在奇数个item)
} LZBTabBarStyleType;

@interface LZBTabBar : UIView

@property(nonatomic,strong)NSMutableArray <NSString *>*lottieJsonNameStrMutArr;

@property(nonatomic,assign)LZBTabBarStyleType tabBarStyleType;

/**
 *  自定义tabbar的delegate
 */
@property(nonatomic,weak)id<LZBTabBarDelegate> delegate;
/**
 *  TabBar设置按钮数组items
 */
@property(nonatomic,strong)NSArray<LZBTabBarItem *>*items;
/**
 *  TabBar设置当前选中的item
 */
@property(nonatomic,strong)LZBTabBarItem *currentSelectItem;
/**
 *  TabBar设置当前选中的item,animation动画
 */
- (void)setCurrentSelectItem:(LZBTabBarItem *)currentSelectItem
                   animation:(BOOL)animation;
/**
 * TabBar顶部分割线
 */
@property(nonatomic,strong)UIView *topLine;
/**
 * TabBar背景View
 */
@property(nonatomic,strong)UIView *backgroundView;

@end

#pragma mark - 自定义LZBTabBar

@protocol LZBTabBarDelegate <NSObject>

/**
 判断tabbbar是否被点击
 
 @param tabBar 自定义tabbar
 @param index 点击的tabbar的index
 @return 是否允许
 */
- (BOOL)lzb_tabBar:(LZBTabBar *)tabBar
shouldSelectItemAtIndex:(NSInteger)index;


/**
 点击tabbar的index
 
 @param tabBar 自定义tabbar
 @param index 点击的tabbar的index
 */
- (void)lzb_tabBar:(LZBTabBar *)tabBar
didSelectItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END



