#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(UIButton* btn);

@interface UIButton (Block)

/**
 *  button 添加点击事件
 *
 *  @param block
 */
- (void)addAction:(ButtonBlock)block;


/// 添加背景圖可以旋轉 Pi/2 的Button
/// @param block
- (void)addActionAutoImage:(ButtonBlock)block;

/**
 *  button 添加事件
 *
 *  @param block
 *  @param controlEvents 点击的方式
 */
- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;


/// 添加背景圖可以旋轉 Pi 的Button
/// @param block
- (void)addActionAutoImageWithPI:(ButtonBlock)block;

@end
