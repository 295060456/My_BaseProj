//
//  BWItemModel.m
//  BWShareView
//
//  Created by syt on 2019/12/23.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWItemModel.h"

@implementation BWItemModel

- (instancetype)initWithImg:(NSString *)img text:(NSString *)text
{
    self = [super init];
    if (self) {
        self.img = img;
        self.text = text;
    }
    return self;
}


@end
