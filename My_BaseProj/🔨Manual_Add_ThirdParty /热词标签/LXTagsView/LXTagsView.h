//
//  LXTagsView.h
//  TestDemo
//
//  Created by 万众创新 on 2018/7/25.
//  Copyright © 2018年 万众创新. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LXTagClick)(NSString *tagTitle);

@interface LXTagsView : UIView

/*
 * 标签数组
 */
@property (nonatomic ,strong)NSArray *dataA;

/*
 * 回调
 */
@property (nonatomic ,copy)LXTagClick tagClick;

/*
 * 标签高度，默认为32 1
 */
@property (nonatomic ,assign)CGFloat tagHeight;

/*
 * 整体左右间距 默认为10 1
 */
@property (nonatomic ,assign)CGFloat viewHMargin;

/*
 * 整体上下间距 默认为10 1
 */
@property (nonatomic ,assign)CGFloat viewVMargin;

/*
 * 标签内部左右间距 默认为10 1
 */
@property (nonatomic ,assign)CGFloat tagInnerSpace;

/*
 * 标签之间的水平间距 默认为10 1
 */
@property (nonatomic ,assign)CGFloat tagHMargin;

/*
 * 标签之间的行间距 默认为5 1
 */
@property (nonatomic ,assign)CGFloat tagVMargin;

/*
 * 标签字体 默认为5
 */
@property (nonatomic ,strong)UIFont *tagFont;

/*
 * 总长度 默认为 设备屏蔽总宽 1
 */
@property (nonatomic ,assign)CGFloat allWidth;

/*
 * 按钮长度 默认为
 */
@property (nonatomic ,assign)CGFloat btnWidth;

/*
 * 标签背景颜色 默认为
 */
@property (nonatomic ,strong)UIColor *tagBgColor;

/*
 * 标签字体颜色 默认为
 */
@property (nonatomic ,strong)UIColor *tagTextColor;

/*
 * 圆角处理值 默认为
 */
@property (nonatomic ,assign)CGFloat cornerRadius;

/*
 * 按钮描边线宽 默认为
 */
@property (nonatomic ,assign)CGFloat borderWidth;

/*
 * 按钮描边颜色 默认为
 */
@property (nonatomic ,strong)UIColor *borderColor;

@end
