//
//  SearchBar.h
//  Feidegou
//
//  Created by Kite on 2019/11/24.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchBar : UIView

@property(nonatomic,strong)ZYTextField *textField;
@property(nonatomic,copy)NSString *placeholderStr;
@property(nonatomic,strong)NSMutableArray *dataMutArr;

-(void)actionBlock:(FourDataBlock)block;//在外部启动数据源 textField,self
-(void)clickBlock:(MKDataBlock)block;


@end

NS_ASSUME_NONNULL_END
