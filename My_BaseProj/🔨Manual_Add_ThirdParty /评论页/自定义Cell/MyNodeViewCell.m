//
//  MyNodeViewCell.m
//  ZFJTreeViewDemo
//
//  Created by 张福杰 on 2019/6/27.
//  Copyright © 2019 张福杰. All rights reserved.
//

#import "MyNodeViewCell.h"
#import "MyNodeModel.h"
#import "ZFJNodeModel.h"

@interface MyNodeViewCell ()

@property (nonatomic,assign) CGFloat nodeLeftSpe;//节点距离右边的距离

@property (nonatomic,strong) UILabel *nodeLabView;

@end

@implementation MyNodeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)uiConfig{
    [super uiConfig];
    [self.contentView addSubview:self.nodeLabView];
}

- (void)dataConfig{
    [super dataConfig];
    _nodeLeftSpe = 25;
}

- (void)updateTreeCellWithModel:(ZFJNodeModel *)model{
    CGFloat leftSpace = model.level * _nodeLeftSpe;
    CGFloat marginSize = 0.0;
    self.nodeLabView.frame = CGRectMake(leftSpace + marginSize, 0, SCREEN_WIDTH - leftSpace - marginSize * 2, model.height);
    if(model.level == 0){
        self.nodeLabView.backgroundColor = [UIColor colorWithRed:0.780 green:0.204 blue:0.125 alpha:0.8];//一级节点
    }else if(model.level == 1){
        self.nodeLabView.backgroundColor = [UIColor colorWithRed:0.259 green:0.584 blue:0.835 alpha:0.8];//二级节点
    }else if(model.level == 2){
        self.nodeLabView.backgroundColor = [UIColor colorWithRed:0.459 green:0.961 blue:0.329 alpha:0.8];//三级节点
    }else if(model.level == 3){
        self.nodeLabView.backgroundColor = [UIColor colorWithRed:0.078 green:0.145 blue:0.459 alpha:0.8];//四级节点
    }else if(model.level == 4){
        self.nodeLabView.backgroundColor = [UIColor colorWithRed:0.765 green:0.224 blue:0.475 alpha:0.8];//五级节点
    }else if(model.level == 5){
        self.nodeLabView.backgroundColor = [UIColor colorWithRed:0.392 green:0.439 blue:0.878 alpha:0.8];//六级节点
    }else if(model.level == 6){
        self.nodeLabView.backgroundColor = [UIColor colorWithRed:0.620 green:0.200 blue:0.855 alpha:0.8];//七级节点
    }else if(model.level == 7){
        self.nodeLabView.backgroundColor = [UIColor colorWithRed:0.408 green:0.263 blue:0.643 alpha:0.8];//八级节点
    }else if(model.level == 8){
        self.nodeLabView.backgroundColor = [UIColor colorWithRed:0.302 green:0.502 blue:0.541 alpha:0.8];//九级节点
    }else if(model.level == 9){
        self.nodeLabView.backgroundColor = [UIColor colorWithRed:0.788 green:0.431 blue:0.604 alpha:0.8];//十级节点
    }
    if(model.sourceModel != nil){
        //用户自定义数据类型
        MyNodeModel *sourceModel = (MyNodeModel *)model.sourceModel;
        self.nodeLabView.text = [NSString stringWithFormat:@"  %@(%@)",model.nodeName, sourceModel.title];
    }else{
        self.nodeLabView.text = [NSString stringWithFormat:@"  %@(--)",model.nodeName];
    }
}

- (UIView *)nodeLabView{
    if(_nodeLabView == nil){
        _nodeLabView = [[UILabel alloc] init];
        _nodeLabView.backgroundColor = [UIColor whiteColor];
        _nodeLabView.textColor = [UIColor whiteColor];
        _nodeLabView.numberOfLines = 0;
        _nodeLabView.font = [UIFont systemFontOfSize:14];
    }
    return _nodeLabView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
