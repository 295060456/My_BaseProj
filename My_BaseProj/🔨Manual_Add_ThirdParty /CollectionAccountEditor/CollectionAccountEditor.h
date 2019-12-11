//
//  CollectionAccountEditorView.h
//  gt
//
//  Created by Administrator on 10/05/2019.
//  Copyright © 2019 GT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MoveDirection){
    MoveDirection_none = 0,
    
    MoveDirection_horizont,//水平方向滑动
    
    MoveDirection_vertical//垂直方向滑动

};

typedef NS_ENUM(NSUInteger, HaveCovering){
    HaveCovering_none = 0,
    
    HaveCovering_yes,//有遮罩物
    
    HaveCovering_no//无遮罩物
    
};

@interface CollectionAccountEditor : NSObject

+(instancetype)initWithCovering:(HaveCovering)haveCovering
              contentViewHeight:(CGFloat)height
               contentViewBlock:(DataBlock)contentViewBlock
                    finishBlock:(NoResultBlock)finishBlock;

-(void)launch;

-(void)close;

-(void)actionBlock:(DataBlock)block;

@end


@interface ContentView : UIView

-(void)actionBlock:(DataBlock)block;

@end

NS_ASSUME_NONNULL_END
