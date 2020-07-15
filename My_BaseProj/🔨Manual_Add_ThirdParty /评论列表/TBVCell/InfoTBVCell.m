//
//  InfoTBVCell.m
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "InfoTBVCell.h"

@interface InfoTBVCell ()

@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation InfoTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    InfoTBVCell *cell = (InfoTBVCell *)[tableView dequeueReusableCellWithIdentifier:@"InfoTBVCell"];
    if (!cell) {
        cell = [[InfoTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"InfoTBVCell"];
        cell.contentView.backgroundColor = [UIColor greenColor];

    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 55;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    self.titleLab.text = model;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _titleLab;;
}

@end
