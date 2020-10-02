//
//  CommentPopUpNonHoveringHeaderView.m
//  My_BaseProj
//
//  Created by Jobs on 2020/10/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CommentPopUpNonHoveringHeaderFooterView.h"
#import "UITableViewHeaderFooterView+Attribute.h"

@interface CommentPopUpNonHoveringHeaderFooterView ()

@property(nonatomic,strong)UIImageView *headerIMGV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)RBCLikeButton *LikeBtn;

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *contentStr;
@property(nonatomic,strong)MKFirstCommentModel *firstCommentModel;
@property(nonatomic,copy)MKDataBlock commentPopUpNonHoveringHeaderViewBlock;

@end

@implementation CommentPopUpNonHoveringHeaderFooterView

@synthesize result = _result;

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                              withData:(id)data{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.result.alpha = 1;
        self.contentView.backgroundColor = HEXCOLOR(0x242A37);
        if ([data isKindOfClass:MKFirstCommentModel.class]) {
            self.firstCommentModel = (MKFirstCommentModel *)data;
            [self.headerIMGV sd_setImageWithURL:[NSURL URLWithString:self.firstCommentModel.headImg]
                               placeholderImage:[UIImage animatedGIFNamed:@"钱袋"]];
            self.titleStr = self.firstCommentModel.nickname;
            self.contentStr = self.firstCommentModel.content;
            self.titleLab.alpha = 1;
            self.contentLab.alpha = 1;
            self.LikeBtn.selected = self.firstCommentModel.isPraise.boolValue;
        }
    }return self;
}

-(void)resultAction:(UIControl *)sender{
    NSLog(@"%@",sender);
    if (self.nonHoveringHeaderViewBlock) {
        self.nonHoveringHeaderViewBlock(@{
        @"sender":sender,
        @"model":self.firstCommentModel
                     });//UIControl
    }
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:[self.tableView rectForHeaderInSection:self.section]];
}

-(void)actionBlockCommentPopUpNonHoveringHeaderView:(MKDataBlock)commentPopUpNonHoveringHeaderViewBlock{
    self.commentPopUpNonHoveringHeaderViewBlock = commentPopUpNonHoveringHeaderViewBlock;
}
//点赞/取消点赞操作
- (void)likeBtnClickAction:(RBCLikeButton *)sender{
    if (self.commentPopUpNonHoveringHeaderViewBlock) {
        self.commentPopUpNonHoveringHeaderViewBlock(@{
            @"sender":sender,
            @"model":self.firstCommentModel
                         });//RBCLikeButton
    }
}
#pragma mark —— lazyLoad
-(UIControl *)result{
    if (!_result) {
        _result = UIControl.new;
        [_result addTarget:self
                    action:@selector(resultAction:)
          forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_result];
        [_result mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _result;
}

-(UIImageView *)headerIMGV{
    if (!_headerIMGV) {
        _headerIMGV = UIImageView.new;
        [self.contentView addSubview:_headerIMGV];
        [_headerIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(34), SCALING_RATIO(34)));
            make.left.equalTo(self.contentView).offset(SCALING_RATIO(16));
            make.centerY.equalTo(self.contentView);
        }];
    }return _headerIMGV;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.titleStr;
        _titleLab.attributedText = [[NSMutableAttributedString alloc] initWithString:self.titleStr
                                                                          attributes:@{NSFontAttributeName: kFontSize(13),
                                                                                       NSForegroundColorAttributeName: COLOR_RGB(131, 145, 175, 1)}];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.headerIMGV.mas_centerY);
            make.left.equalTo(self.headerIMGV.mas_right).offset(SCALING_RATIO(10));
        }];
    }return _titleLab;
}

-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = UILabel.new;
        _contentLab.text = self.contentStr;
        _contentLab.attributedText = [[NSMutableAttributedString alloc] initWithString:self.contentStr
                                                                            attributes: @{NSFontAttributeName: kFontSize(15),
                                                                                          NSForegroundColorAttributeName: COLOR_RGB(255, 255, 255, 1)}];
        [self.contentView addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_centerY);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.headerIMGV.mas_right).offset(SCALING_RATIO(10));
        }];
    }return _contentLab;
}

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
