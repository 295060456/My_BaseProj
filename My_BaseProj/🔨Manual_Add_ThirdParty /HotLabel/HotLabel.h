//
//  HotLabel.h
//  My_BaseProj
//
//  Created by Administrator on 08/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotLabel : UIView

-(instancetype)initWithTopOffset:(CGFloat)topOffset
                      eachOffset:(CGFloat)eachOffset;

-(void)hotLabelWithDataArr:(NSArray *)dataArr;

-(void)actionBlock:(MKDataBlock)Block;

@end

NS_ASSUME_NONNULL_END

//1、根据内容对承载物Lable的宽进行动态设置;
//2、一行放不下自动转入下一行
