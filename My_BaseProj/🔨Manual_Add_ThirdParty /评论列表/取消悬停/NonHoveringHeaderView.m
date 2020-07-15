//
//  NonHoveringHeaderView.m
//  HeaderDemo
//
//  Created by zyd on 2018/6/22.
//  Copyright © 2018年 zyd. All rights reserved.
//

#import "NonHoveringHeaderView.h"
#import "UITableViewHeaderFooterView+Attribute.h"

@interface NonHoveringHeaderView ()

@end

@implementation NonHoveringHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                               withData:(id)data{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.result.alpha = 1;
        self.tag = [data intValue];
    }return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:[self.tableView rectForHeaderInSection:self.section]];
}

#pragma mark —— lazyLoad
-(UIControl *)result{
    if (!_result) {
        _result = UIControl.new;
        [self.contentView addSubview:_result];
        [_result mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _result;
}

@end
