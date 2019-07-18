//
//  LGiOSBtn.h
//  My_BaseProj
//
//  Created by hello on 2019/7/4.
//  Copyright © 2019 Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGiOSBtn;
@protocol DZDeleteButtonDelegate <NSObject>
@optional
- (void)deleteButtonRemoveSelf:(LGiOSBtn *)button;
@end

NS_ASSUME_NONNULL_BEGIN

@interface LGiOSBtn : UIButton

@property (nonatomic, weak) id<DZDeleteButtonDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
