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

@property(nonatomic,copy)NSString *total;
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger size;
@property(nonatomic,copy)NSString *startRow;
@property(nonatomic,copy)NSString *endRow;
@property(nonatomic,assign)NSInteger pages;
@property(nonatomic,assign)NSInteger prePage;
@property(nonatomic,assign)NSInteger nextPage;
@property(nonatomic,assign)BOOL isFirstPage;
@property(nonatomic,assign)BOOL isLastPage;
@property(nonatomic,assign)BOOL hasPreviousPage;
@property(nonatomic,assign)BOOL hasNextPage;
@property(nonatomic,assign)NSInteger navigatePages;
@property(nonatomic,assign)NSArray *navigatepageNums;
@property(nonatomic,assign)NSInteger navigateFirstPage;
@property(nonatomic,assign)NSInteger navigateLastPage;

@end

NS_ASSUME_NONNULL_END

