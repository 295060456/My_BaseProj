//
//  LOTAnimationView+action.m
//  My_BaseProj
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "LOTAnimationView+action.h"
#import <objc/runtime.h>

@implementation LOTAnimationView (action)

static char *LOTAnimationView_action = "LOTAnimationView_action";
static char *LOTAnimationView_ActionBlock = "LOTAnimationView_ActionBlock";

@dynamic tagger;
@dynamic LOTAnimationViewActionBlock;

-(void)actionLOTAnimationViewBlock:(MKDataBlock)LOTAnimationViewActionBlock{
    self.LOTAnimationViewActionBlock = LOTAnimationViewActionBlock;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.LOTAnimationViewActionBlock) {
        self.LOTAnimationViewActionBlock(@(self.tagger));
    }
}

#pragma mark —— @property(nonatomic,assign)NSInteger tagger;
-(NSInteger)tagger{
    return [objc_getAssociatedObject(self, LOTAnimationView_action) integerValue];
}

-(void)setTagger:(NSInteger)tagger{
    objc_setAssociatedObject(self,
                             LOTAnimationView_action,
                             [NSNumber numberWithInteger:tagger],
                             OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark —— @property(nonatomic,copy)MKDataBlock LOTAnimationViewActionBlock;
-(MKDataBlock)LOTAnimationViewActionBlock{
    return objc_getAssociatedObject(self, LOTAnimationView_ActionBlock);
}

-(void)setLOTAnimationViewActionBlock:(MKDataBlock)LOTAnimationViewActionBlock{
    objc_setAssociatedObject(self,
                             LOTAnimationView_ActionBlock,
                             LOTAnimationViewActionBlock,
                             OBJC_ASSOCIATION_COPY);
}


@end
