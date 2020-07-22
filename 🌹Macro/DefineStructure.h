//
//  DefineStructure.h
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#ifndef DefineStructure_h
#define DefineStructure_h

typedef enum : NSUInteger {
    BusinessType_HadPaid = 0,//已支付
    BusinessType_HadBilled,//已发单
    BusinessType_HadOrdered,//已接单
    BusinessType_HadCanceled,//已作废
    BusinessType_HadConsigned,//已发货
    BusinessType_HadCompleted,//已完成
} BusinessType;

typedef enum : NSUInteger {//1、摊位;2、批发;3、厂家
    PlatformType_NUll = 0,
    PlatformType_Stall,//摊位
    PlatformType_Wholesale,//批发
    PlatformType_ProducingArea//产地 厂家
} PlatformType;



#endif /* DefineStructure_h */
