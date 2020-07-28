//
//  LowModel.h
//  eva
//
//  Created by 上帝的宠儿 on 2020/7/14.
//  Copyright © 2020 ice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondClassModel : NSObject

@property(nonatomic,strong)NSString *secondClassText;

+ (SecondClassModel *)create:(NSString *)secondClassText;

@end

