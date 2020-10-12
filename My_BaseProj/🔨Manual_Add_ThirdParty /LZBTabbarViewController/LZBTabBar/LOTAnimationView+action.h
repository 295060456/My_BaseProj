//
//  LOTAnimationView+action.h
//  My_BaseProj
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Lottie/LOTAnimationView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LOTAnimationView (action)

@property(nonatomic,assign)NSInteger tagger;
@property(nonatomic,copy)MKDataBlock LOTAnimationViewActionBlock;

-(void)actionLOTAnimationViewBlock:(MKDataBlock)LOTAnimationViewActionBlock;//?

@end

NS_ASSUME_NONNULL_END
