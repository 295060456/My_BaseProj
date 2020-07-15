//
//  LoadMoreTBVCell.m
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "LoadMoreTBVCell.h"

@interface LoadMoreTBVCell ()

@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation LoadMoreTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    LoadMoreTBVCell *cell = (LoadMoreTBVCell *)[tableView dequeueReusableCellWithIdentifier:@"LoadMoreTBVCell"];
    if (!cell) {
        cell = [[LoadMoreTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"LoadMoreTBVCell"];
        cell.contentView.backgroundColor = [UIColor blueColor];

    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 55;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    self.titleLab.text = @"加载更多...";
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.backgroundColor = [UIColor systemYellowColor];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _titleLab;
}

@end
