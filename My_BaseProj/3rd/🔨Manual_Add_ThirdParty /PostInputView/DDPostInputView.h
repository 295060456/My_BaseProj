//
//  DDPostInputView.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/28.
//

#import <UIKit/UIKit.h>

#if __has_include(<SZTextView/SZTextView.h>)
#import <SZTextView/SZTextView.h>
#else
#import "SZTextView.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface DDPostInputView : UIView

-(void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
