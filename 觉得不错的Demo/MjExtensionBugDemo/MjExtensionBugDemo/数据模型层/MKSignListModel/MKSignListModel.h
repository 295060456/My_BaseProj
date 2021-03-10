//
//  MKSignListModel.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/1/24.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSignModel : NSObject

@property(nonatomic,strong)NSNumber *days;
@property(nonatomic,strong)NSNumber *goldNum;
@property(nonatomic,strong)NSNumber *isSign;

@end

@interface MKSignListModel : NSObject

@property(nonatomic,strong)NSArray <MKSignModel *>*data;
@property(nonatomic,strong)NSNumber *isSign;
@property(nonatomic,strong)NSNumber *nowGoldNum;

@end

NS_ASSUME_NONNULL_END
