//
//  BaseModel.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/22.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

@property(nonatomic,strong)NSNumber *endRow;
@property(nonatomic,strong)NSNumber *hasNextPage;
@property(nonatomic,strong)NSNumber *hasPreviousPage;
@property(nonatomic,strong)NSNumber *isFirstPage;
@property(nonatomic,strong)NSNumber *isLastPage;

@property(nonatomic,strong)NSNumber *navigateFirstPage;
@property(nonatomic,strong)NSNumber *navigateLastPage;
@property(nonatomic,strong)NSNumber *navigatePages;
@property(nonatomic,strong)NSArray *navigatepageNums;

@property(nonatomic,strong)NSNumber *nextPage;
@property(nonatomic,strong)NSNumber *pageNum;
@property(nonatomic,strong)NSNumber *pageSize;
@property(nonatomic,strong)NSNumber *pages;
@property(nonatomic,strong)NSNumber *prePage;
@property(nonatomic,strong)NSNumber *size;
@property(nonatomic,strong)NSNumber *startRow;
@property(nonatomic,strong)NSNumber *total;

@end

NS_ASSUME_NONNULL_END

