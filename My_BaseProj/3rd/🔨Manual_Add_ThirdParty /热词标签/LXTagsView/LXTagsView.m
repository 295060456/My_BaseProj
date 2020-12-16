//
//  LXTagsView.m
//  TestDemo
//
//  Created by 万众创新 on 2018/7/25.
//  Copyright © 2018年 万众创新. All rights reserved.
//

#import "LXTagsView.h"
#import "NSString+Extension.h"
#import "UIColor+LXExpand.h"

@interface LXTagsView()

@property(nonatomic,strong)NSMutableArray *tagsArray;
@property(nonatomic,strong)NSMutableArray *btnMutArr;

@end

@implementation LXTagsView

-(instancetype)init{
    
    if (self = [super init]) {

    }
    
    return self;
}

#pragma mark —— set方法赋值
//标签高度
-(void)setTagHeight:(CGFloat)tagHeight{
    
    _tagHeight = tagHeight;
}
//整体左右间距
-(void)setViewHMargin:(CGFloat)viewHMargin{
    
     _viewHMargin = viewHMargin;
}
//整体上下间距
-(void)setViewVMargin:(CGFloat)viewVMargin{
    
    _viewVMargin = viewVMargin;
}
//标签之间的水平间距
-(void)setTagHMargin:(CGFloat)tagHMargin{
    
    _tagHMargin = tagHMargin;
}
//标签之间的行间距
-(void)setTagVMargin:(CGFloat)tagVMargin{
    
    _tagVMargin = tagVMargin;
}
//标签内部左右间距
-(void)setTagInnerSpace:(CGFloat)tagInnerSpace{
    
    _tagInnerSpace = tagInnerSpace;
}
//总长度
-(void)setAllWidth:(CGFloat)allWidth{
    
    _allWidth = allWidth;
}
//标签字体
-(void)setTagFont:(UIFont *)tagFont{
    
    _tagFont = tagFont;
}
//标签背景颜色
-(void)setTagBgColor:(UIColor *)tagBgColor{
    
    _tagBgColor = tagBgColor;
}
//标签字体颜色
-(void)setTagTextColor:(UIColor *)tagTextColor{
    
    _tagTextColor = tagTextColor;
}
//按钮长度
-(void)setBtnWidth:(CGFloat)btnWidth{
    
    _btnWidth = btnWidth;
}

//判断且设置默认值
-(void)judgeAndSetDefaultValue{
    
    if (self.tagHeight == 0) {
        
        self.tagHeight = 32;
    }
    
    if (self.viewHMargin == 0) {
        
        self.viewHMargin = 10;
    }
    
    if (self.viewVMargin == 0) {
        
        self.viewVMargin = 10;
    }
    
    if (self.tagHMargin == 0) {
        
        self.tagHMargin = 10;
    }
    
    if (self.tagVMargin == 0) {
        
        self.tagVMargin = 5;
    }
    
    if (self.tagInnerSpace == 0) {
        
        self.tagInnerSpace = 10;
    }
    
    if (!self.tagFont) {
        
        _tagFont  = [UIFont systemFontOfSize:15];
    }
    
    if (self.allWidth == 0) {
        
        self.allWidth = MAINSCREEN_WIDTH;
    }
    
    if (!_tagBgColor) {
        
        _tagBgColor = kRedColor;
    }
    
    if (!_tagTextColor) {
        
        _tagTextColor = kBlueColor;
    }

    if (!_cornerRadius) {
        
        _cornerRadius = 0;
    }
    
    if (!_borderWidth) {
        
        _borderWidth = 0;
    }
    
    if (!_borderColor) {
        
        _borderColor = kClearColor;
    }
}

-(void)setDataA:(NSArray *)dataA{
    
    _dataA = dataA;
    
    [self judgeAndSetDefaultValue];
    
    [self buildTags];
}

-(void)buildTags{
    
    //移除所有的tags
    for (UIButton *button in self.tagsArray) {
        
        [button removeFromSuperview];
    }
    
    [self.tagsArray removeAllObjects];
    
    for (int i = 0; i < self.dataA.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.dataA[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:self.tagFont];
        [button setBackgroundColor:self.tagBgColor];
        [button setTitleColor:self.tagTextColor forState:UIControlStateNormal];
        
        [self.btnMutArr addObject:button];
        
        button.tag = i;
        
        [UIView cornerCutToCircleWithView:button
                            AndCornerRadius:self.cornerRadius];
        
        [UIView colourToLayerOfView:button
                           WithColour:self.borderColor
                       AndBorderWidth:self.borderWidth];
        
        if (i == 0) {//设置默认
            
            [self colorForBtn:button
                    textColor:0x4c7fff
                  borderColor:0x4c7fff
                  borderWidth:1];
        }else{
            
            [self colorForBtn:button
                    textColor:0x333333
                  borderColor:0xdddddd
                  borderWidth:1];
        }
        
        @weakify(self)
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            button.selected = !button.selected;
            [self btnClickEvent:button];
            if (self.tagClick) {
                self.tagClick(self.dataA[i]);
            }
        }];
        
        [self.tagsArray addObject:button];
        
        [self addSubview:button];
    }
    //刷新布局
    [self layoutItems];
}

-(void)btnClickEvent:(UIButton *)sender{
    
    //全部置为 未选择状态
    for (int t = 0; t < self.btnMutArr.count; t++) {
        
        UIButton *btn = self.btnMutArr[t];
        
        [self colorForBtn:btn
                textColor:0x333333
              borderColor:0xdddddd
              borderWidth:0.5];
    }
    
    //选中的 置为 选择状态
    [self colorForBtn:sender
            textColor:0x4c7fff
          borderColor:0x4c7fff
          borderWidth:1];
}

-(void)colorForBtn:(UIButton *)sender
         textColor:(int)textColor
       borderColor:(int)borderColor
       borderWidth:(float)borderWidth{
    
    [sender setTitleColor:HEXCOLOR(textColor)
                 forState:UIControlStateNormal];
    
    [UIView colourToLayerOfView:sender
                       WithColour:HEXCOLOR(borderColor)
                   AndBorderWidth:borderWidth];
}

-(void)layoutItems{
    
    CGFloat viewVMargin =  self.viewVMargin;//整体上间距
    
    CGFloat viewHMargin = self.viewHMargin;//整体左右间距
    
    CGFloat tagHeight = self.tagHeight;//默认的tagHeight
    
    CGFloat tagLineWidth = viewHMargin;//单行的总宽度
    
    CGFloat allWidth = self.allWidth;//总宽度
    
    CGFloat tagVMargin = self.tagVMargin;//标签行间距
    
    CGFloat tagHMargin = self.tagHMargin;//标签之间间距
    
    CGFloat tagInnerSpace = self.tagInnerSpace;//标签内部左右间距
    
    NSUInteger count = self.tagsArray.count;
    
    __block BOOL isChange = NO;  //是否需要换行
    
    UIButton *lastItem = nil;
    
    for (NSUInteger i = 0; i < count; i++) {
        
        UIButton *item = self.tagsArray[i];
        
        NSString *tagTitle = self.dataA[i];
        
        CGFloat tagWidth  = [tagTitle sizeWithFont:self.tagFont maxSize:CGSizeMake(MAXFLOAT, tagHeight)].width + 2 *tagInnerSpace + 0.5; //(//masonry布局会四舍五入 + 0.5防止宽度不够)
        
        if (self.btnWidth == 0) {
            
            self.btnWidth = tagWidth;
        }
 
        tagLineWidth +=  self.btnWidth + tagHMargin;
        
        //当标签长度过长 限制
        if (tagLineWidth  > allWidth - viewHMargin) {
            
            isChange = YES;
            
            //标签的长度+整体左右间距 >= 总宽度
            if (self.btnWidth + 2 * tagHMargin >= allWidth) {
                
                self.btnWidth = allWidth - 2 *tagHMargin;
                
                //内边距重新处理
                [item setTitleEdgeInsets:UIEdgeInsetsMake(0, tagInnerSpace/2, 0, tagInnerSpace/2)];
                
            }
            
            //换行重新设置当前行的长度
            tagLineWidth = viewHMargin + self.btnWidth + tagHMargin;
        }
        
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(tagHeight);
            
            make.width.mas_equalTo(self.btnWidth);
            
            //第一个tag设置
            if (!lastItem) {
                
                make.top.mas_equalTo(viewVMargin);
                
            }else{
                
                //是否换行
                if (isChange) {
                    
                    make.top.mas_equalTo(lastItem.mas_bottom).offset(tagVMargin);
                    
                    isChange = NO;
                }else{
                    
                    make.left.mas_equalTo(lastItem.mas_right).offset(tagHMargin);
                    
                    make.top.mas_equalTo(lastItem.mas_top);
                }
            }
        }];
        
        lastItem = item;
    }
    //最后一个距离底部的距离
    [lastItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-viewVMargin).with.priorityHigh();
    }];
    
    [self layoutIfNeeded];
}

#pragma mark —— lazyload

-(NSMutableArray *)tagsArray{
    
    if (!_tagsArray) {
        
        _tagsArray = NSMutableArray.array;
    }
    
    return _tagsArray;
}

-(NSMutableArray *)btnMutArr{
    
    if (!_btnMutArr) {
        
        _btnMutArr = NSMutableArray.array;
    }
    
    return _btnMutArr;
}

@end
