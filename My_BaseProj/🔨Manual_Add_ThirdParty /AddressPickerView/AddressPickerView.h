//
//  AddressPickerView.h
//  CJAddressPicker
//
//  Created by 陈雄 on 2019/5/21.
//  Copyright © 2019 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressPickerView : UIView

@property(nonatomic,copy) void (^complete)(NSString *province,NSString *city,NSString *subCity,NSString *street);

+ (instancetype)addressPickerViewWithComplete:(void (^)(NSString *province,NSString *city,NSString *subCity,NSString *street))complete;

@end

NS_ASSUME_NONNULL_END
