//
//  DHAreasModel.h
//  Project_Model
//
//  Created by Harriet on 2018/7/9.
//  Copyright © 2018年 Harriet. All rights reserved.
//
#import <Foundation/Foundation.h>
//区县
@interface DHAreasCountryModel : NSObject

@property (nonatomic, copy) NSString *countryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray *childList;

@end

//市
@interface DHAreasCityModel : NSObject

@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray *childList;

@end

//省
@interface DHAreasProvinceModel : NSObject

@property (nonatomic, copy) NSString *privinceId;
@property (nonatomic, copy) NSString *

name;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray *childList;

@end

@interface DHAreasModel : NSObject

@property (nonatomic, strong) NSArray *content;

@end
