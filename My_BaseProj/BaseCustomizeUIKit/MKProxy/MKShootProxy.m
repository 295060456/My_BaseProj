//
//  MKShootProxy.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/18.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKShootProxy.h"

@interface MKShootProxy ()

@end

@implementation MKShootProxy

#pragma mark —— lazyLoad
-(UILabel *)lab{
    if (!_lab) {
        _lab = UILabel.new;
    }return _lab;
}

-(UIImageView *)imgv{
    if (!_imgv) {
        _imgv = UIImageView.new;
    }return _imgv;
}

@end
