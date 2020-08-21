//
//  LZBTabBar.m
//  LZBTabBarVC
//
//  Created by zibin on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBTabBar.h"
#import "Lottie.h"

#define default_TopLine_Height 0.5

#pragma mark - LZBTabBar

@interface LZBTabBar()

@property(nonatomic,assign)CGFloat itemWidth;
@property(nonatomic,assign)BOOL isAnimation;

@end

@implementation LZBTabBar

- (instancetype)initWithFrame:(CGRect)frame{
  if(self = [super initWithFrame:frame]){
      [self setupUI];
  }return self;
}

- (void)setupUI{
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.topLine];
    //分割线的颜色
    self.topLine.backgroundColor = [UIColor colorWithHexString:@"#37A6F0"];
}

-(void)setTabBarStyleType:(LZBTabBarStyleType)tabBarStyleType{
    if (tabBarStyleType == LZBTabBarStyleType_middleItemUp) {
        if (self.items.count % 2) {
            _tabBarStyleType = tabBarStyleType;
        }else{
            _tabBarStyleType = LZBTabBarStyleType_sysNormal;
        }
    }else{
        _tabBarStyleType = tabBarStyleType;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundView.frame = self.bounds;
    self.topLine.frame = CGRectMake(0,
                                    0,
                                    self.bounds.size.width,
                                    default_TopLine_Height);
    //布局
    NSInteger index = 0;
    Boolean isOddItems = self.items.count % 2;//items为奇数个，那么就最中间的作为突出的大头
    int y = (int)ceil(self.items.count / 2.0);//向上取整，求中位数
    self.itemWidth = self.bounds.size.width / self.items.count;
    for (LZBTabBarItem *item in self.items) {
        CGFloat itemHeight = [item itemHeight];
        if(!itemHeight)
            itemHeight = self.bounds.size.height;
        CGFloat itemW = self.itemWidth;
        CGFloat itemH = itemHeight;
        
        if (isOddItems && y == index + 1 && self.tabBarStyleType) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(itemW, itemH * 4 / 3));
                LZBTabBarItem *item_ = (LZBTabBarItem *)self.items[index - 1];
                make.left.equalTo(item_.mas_right);
                make.bottom.equalTo(self);
            }];
        }else{
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(itemW, itemH));
                if (index == 0) {
                    make.left.equalTo(self);
                }else{
                    LZBTabBarItem *item = (LZBTabBarItem *)self.items[index - 1];
                    make.left.equalTo(item.mas_right);
                }
                make.bottom.equalTo(self);
            }];
        }
        [item setNeedsDisplay];
        {
            //Lottie
            LOTAnimationView *animation = [LOTAnimationView animationNamed:self.lottieJsonNameStrMutArr[index]];
            animation.userInteractionEnabled = YES;
            [item addSubview:animation];
            [animation playWithCompletion:^(BOOL animationFinished) {
              // Do Something
            }];
        }
        index++;
    }
}
#pragma mark —— API
- (void)setItems:(NSArray<LZBTabBarItem *> *)items{
    if(items.count == 0) return;
    //移除所有子控件
    for (LZBTabBarItem *item in _items){
        [item removeFromSuperview];
    }
    _items = [items copy];
    
    for (int i = 0; i < items.count; i++) {
        [self addSubview:items[i]];
        LZBTabBarItem *item = items[i];
        item.tagger = i;
        if (i == 0) {
            item.selected = YES;//默认第一个为点击选中状态
            [item.animation playWithCompletion:^(BOOL animationFinished) {
                
            }];
        }
        @weakify(self)
        [item animationActionLZBTabBarItemBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)data;
                [self tabbarItemDidSelected:items[num.intValue]];
            }
        }];
        
        [item gestureRecognizerLZBTabBarItemBlock:^(id data,
                                                    id data2) {
            @strongify(self)
            if ([data isKindOfClass:LZBTabBarItem.class]) {
                LZBTabBarItem *item = (LZBTabBarItem *)data;
                if ([data2 isKindOfClass:UITapGestureRecognizer.class]) {
                    [self tabbarItemDidSelected:items[item.tagger]];
                }else if ([data2 isKindOfClass:UILongPressGestureRecognizer.class]){
                    NSLog(@"长按手势执行什么？");
                }else{}
            }
        }];
    }
}

- (void)tabbarItemDidSelected:(LZBTabBarItem *)item{
    if(![self.items containsObject:item]) return;
    NSInteger index = [self.items indexOfObject:item];
    if([self.delegate respondsToSelector:@selector(lzb_tabBar:shouldSelectItemAtIndex:)]){
        if(![self.delegate lzb_tabBar:self
              shouldSelectItemAtIndex:index])
            return;
    }
    if([self.delegate respondsToSelector:@selector(lzb_tabBar:didSelectItemAtIndex:)]){
        [self.delegate lzb_tabBar:self
             didSelectItemAtIndex:index];
    }
    self.currentSelectItem = item;
}

- (void)setCurrentSelectItem:(LZBTabBarItem *)currentSelectItem{
    [self setCurrentSelectItem:currentSelectItem
                     animation:self.isAnimation];
}

- (void)setCurrentSelectItem:(LZBTabBarItem *)currentSelectItem
                   animation:(BOOL)animation{
    if(_currentSelectItem == currentSelectItem) return;
    _currentSelectItem.selected = NO;
    _currentSelectItem = currentSelectItem;
    _currentSelectItem.selected = YES;
    self.isAnimation = animation;
    if(self.isAnimation)
    [self addScaleAnimationWithSuperLayer:_currentSelectItem.layer];
}

- (void)addScaleAnimationWithSuperLayer:(CALayer *)layer{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyAnimation.values = @[@0.8,@1.1,@1.0];
    keyAnimation.duration = 0.25;
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:keyAnimation
                 forKey:@"keyAnimation"];
}

#pragma mark —— LazyLoad
- (UIView *)backgroundView{
  if(_backgroundView == nil){
      _backgroundView = [UIView new];
  }return _backgroundView;
}

- (UIView *)topLine{
  if(_topLine == nil){
      _topLine = [UIView new];
  } return _topLine;
}

@end


