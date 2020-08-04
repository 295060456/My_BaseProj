//
//  DefineStructure.h
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#ifndef DefineStructure_h
#define DefineStructure_h

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BusinessType_HadPaid = 0,//已支付
    BusinessType_HadBilled,//已发单
    BusinessType_HadOrdered,//已接单
    BusinessType_HadCanceled,//已作废
    BusinessType_HadConsigned,//已发货
    BusinessType_HadCompleted,//已完成
} BusinessType;


#endif /* DefineStructure_h */
