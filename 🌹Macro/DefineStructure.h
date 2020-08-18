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

#pragma mark —— GPUImage
typedef NS_ENUM(NSInteger, CameraManagerDevicePosition) {
    CameraManagerDevicePositionBack,
    CameraManagerDevicePositionFront,
};

typedef NS_ENUM(NSInteger, TypeFilter) {
    filterNone,
    filterGaussBlur,
    filterDilation,
    filterBeautify,
    filterGif,
};


#endif /* DefineStructure_h */
