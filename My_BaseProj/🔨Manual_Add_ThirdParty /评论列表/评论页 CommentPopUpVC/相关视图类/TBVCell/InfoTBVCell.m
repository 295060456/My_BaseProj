//
//  InfoTBVCell.m
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "InfoTBVCell.h"

@interface InfoTBVCell ()

@property(nonatomic,copy)MKDataBlock actionBlock;

@end

@implementation InfoTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    InfoTBVCell *cell = (InfoTBVCell *)[tableView dequeueReusableCellWithIdentifier:@"InfoTBVCell"];
    if (!cell) {
        cell = [[InfoTBVCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"InfoTBVCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = HEXCOLOR(0x242A37);
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return SCALING_RATIO(55);
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:MKChildCommentModel.class]) {
        self.childCommentModel = (MKChildCommentModel *)model;
        self.LikeBtn.selected = self.childCommentModel.isPraise.boolValue;
        self.LikeBtn.thumpNum = self.childCommentModel.praiseNum.integerValue;
        self.textLabel.text = self.childCommentModel.nickname;
        self.detailTextLabel.text = self.childCommentModel.content;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.childCommentModel.headImg]
                          placeholderImage:[UIImage animatedGIFNamed:@"钱袋"]];
        [UIView cornerCutToCircleWithView:self.imageView
                          AndCornerRadius:SCALING_RATIO(55 / 2)];
    }
}

-(void)action:(MKDataBlock)actionBlock{
    self.actionBlock = actionBlock;
}
//点赞/取消点赞操作
- (void)likeBtnClickAction:(RBCLikeButton *)sender{
    if (self.actionBlock) {
        self.actionBlock(@{
            @"sender":sender,
            @"model":self.childCommentModel
                         });
    }
}
#pragma mark —— lazyLoad
-(RBCLikeButton *)LikeBtn{
    if (!_LikeBtn) {
        _LikeBtn = RBCLikeButton.new;
        [_LikeBtn setImage:KIMG(@"day_like")
                  forState:UIControlStateNormal];
        [_LikeBtn setImage:KIMG(@"day_like_red")
                   forState:UIControlStateSelected];
//        _LikeBtn.layer.cornerRadius = SCALING_RATIO(55 / 4);
//        _LikeBtn.layer.borderColor = kGrayColor.CGColor;
//        _LikeBtn.layer.borderWidth = 1;
        _LikeBtn.thumpNum = 0;
        [_LikeBtn addTarget:self
                     action:@selector(likeBtnClickAction:)
           forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_LikeBtn];
        [_LikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(55 / 2), SCALING_RATIO(55 / 2)));
            make.right.equalTo(self.contentView).offset(-SCALING_RATIO(13));
            make.centerY.equalTo(self.contentView);
        }];
    }return _LikeBtn;
}



@end
