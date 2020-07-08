//
//  LZBTabBar.m
//  LZBTabbarViewController
//
//  Created by zibin on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBTabBar.h"
#define default_TopLine_Height 0.5

#pragma mark- LZBTabBarItem
@implementation LZBTabBarItem
- (instancetype)initWithFrame:(CGRect)frame{
  if(self = [super initWithFrame:frame]){
      [self setupInit];
  }return self;
}

- (void)setupInit{
    self.backgroundColor = [UIColor clearColor];
    //初始化参数
    _title = @"";
    _titleOffest = UIOffsetZero;
    _unselectTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName: kWhiteColor,};
    _selectTitleAttributes = [_unselectTitleAttributes copy];
    _badgeValue = @"";
    _badgeTextColor = [UIColor whiteColor];
    _badgeTextFont = [UIFont systemFontOfSize:12.0];
    _badgeOffset = UIOffsetZero;
}

- (void)drawRect:(CGRect)rect{
    CGSize frameSize = self.frame.size;
    CGSize imageSize = CGSizeZero;
    CGSize titleSize = CGSizeZero;
    NSDictionary *titleAttributes = nil;
    UIImage *backgroundImage = nil;
    UIImage *image = nil;
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    {
        //判断是否选中
        if(self.isSelected){
            image = self.selectImage;
            backgroundImage = self.selectBackgroundImage;
            titleAttributes = self.selectTitleAttributes;
        }else{
            image = self.unSelectImage;
            backgroundImage = self.unselectBackgroundImage;
            titleAttributes = self.unselectTitleAttributes;
        }
        imageSize = (image== nil) ? CGSizeZero : image.size;
    }

    {
        if(backgroundImage) [backgroundImage drawInRect:self.bounds];
        if(self.title.length == 0){//只有图片
            [image drawInRect:CGRectMake((frameSize.width - imageSize.width) * 0.5 + self.imageOffest.horizontal,
                                         (frameSize.height - imageSize.height) * 0.5 + self.imageOffest.vertical,
                                         imageSize.width,
                                         imageSize.height)];
        }else{//图文
            titleSize = [self.title sizeWithAttributes:titleAttributes];
            CGFloat imageTopMaigin = (frameSize.height - imageSize.height - titleSize.height) * 0.5;
            [image drawInRect:CGRectMake((frameSize.width - imageSize.width) * 0.5 + self.imageOffest.horizontal,
                                         imageTopMaigin,
                                         imageSize.width,
                                         imageSize.height)];
            //必须先设置颜色
            CGContextSetFillColorWithColor(context, [titleAttributes[NSForegroundColorAttributeName] CGColor]);
            [self.title drawInRect:CGRectMake((frameSize.width - titleSize.width) * 0.5 + self.titleOffest.horizontal,
                                              imageTopMaigin+imageSize.height+self.titleOffest.vertical,
                                              titleSize.width,
                                              titleSize.height)
                    withAttributes:titleAttributes];
        }
    }

    {
        //角标
        CGRect bageBackFrame = CGRectZero;
        if(self.badgeBackgroundColor){
            CGFloat badgeBackWidthHeight = 10;
            bageBackFrame = CGRectMake(frameSize.width - badgeBackWidthHeight - self.badgeBackgroundOffset.horizontal,
                                       self.badgeBackgroundOffset.vertical,
                                       badgeBackWidthHeight,
                                       badgeBackWidthHeight);
            CGContextSetFillColorWithColor(context, self.badgeBackgroundColor.CGColor);
            CGContextFillEllipseInRect(context, bageBackFrame);
        }else if(self.badgeBackgroundImage){
            bageBackFrame = CGRectMake(frameSize.width - self.badgeBackgroundImage.size.width - self.badgeBackgroundOffset.horizontal,
                                       self.badgeBackgroundOffset.vertical,
                                       self.badgeBackgroundImage.size.width,
                                       self.badgeBackgroundImage.size.height);
            [self.badgeBackgroundImage drawInRect:bageBackFrame];
        }else{}
        //角标文字
        if(self.badgeValue){
            NSDictionary *badgeAttrubute = @{NSFontAttributeName : self.badgeTextFont,
                                            NSForegroundColorAttributeName : self.badgeTextColor};
            CGSize badgeValueSize = [self.badgeValue sizeWithAttributes:badgeAttrubute];
            //必须先设置颜色
            CGContextSetFillColorWithColor(context, self.badgeTextColor.CGColor);
            [self.badgeValue drawInRect:CGRectMake(frameSize.width - badgeValueSize.width - self.badgeOffset.horizontal,
                                                   self.badgeOffset.vertical,
                                                   badgeValueSize.width,
                                                   badgeValueSize.height)
                         withAttributes:badgeAttrubute];
        }
    }

    CGContextRestoreGState(context);
}

#pragma mark - config
- (void)setSelectImage:(UIImage *)selectImage
         unselectImage:(UIImage *)unSelectImage{
  if(self.selectImage != selectImage)
      self.selectImage = selectImage;
  if(self.unSelectImage != unSelectImage)
      self.unSelectImage = unSelectImage;
}

- (void)setUnSelectImage:(UIImage *)unSelectImage{
   if((_unSelectImage != unSelectImage) && unSelectImage)
       _unSelectImage = unSelectImage;
}

- (void)setSelectImage:(UIImage *)selectImage{
    if((_selectImage != selectImage) && selectImage)
        _selectImage = selectImage;
}

- (void)setBackgroundSelectedImage:(UIImage *)selectedImage
                   unselectedImage:(UIImage *)unselectedImage{
    if(self.selectBackgroundImage != selectedImage)
        self.selectBackgroundImage = selectedImage;
    if(self.unselectBackgroundImage != unselectedImage)
        self.unselectBackgroundImage = unselectedImage;
}

- (void)setUnselectBackgroundImage:(UIImage *)unselectBackgroundImage{
    if((_unselectBackgroundImage != unselectBackgroundImage) && unselectBackgroundImage)
        _unselectBackgroundImage = unselectBackgroundImage;
}

-(void)setSelectBackgroundImage:(UIImage *)selectBackgroundImage{
    if((_selectBackgroundImage != selectBackgroundImage) && selectBackgroundImage)
        _selectBackgroundImage = selectBackgroundImage;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    [self setNeedsDisplay];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self setNeedsDisplay];
}

@end

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
    self.topLine.backgroundColor  = [UIColor colorWithHexString:@"#37A6F0"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize frameSize = self.bounds.size;
    self.backgroundView.frame = self.bounds;
    self.topLine.frame = CGRectMake(0,
                                    0,
                                    frameSize.width,
                                    default_TopLine_Height);
    //布局
    NSInteger index = 0;
    self.itemWidth = frameSize.width / self.items.count;
    for (LZBTabBarItem *item in self.items) {
        CGFloat itemHeight = [item itemHeight];
        if(!itemHeight)
            itemHeight = frameSize.height;
        CGFloat itemW = self.itemWidth;
        CGFloat itemH = itemHeight;
        CGFloat itemCenterX = index *itemW + itemW *0.5;
        CGFloat itemCenterY = frameSize.height * 0.5;
        item.bounds = CGRectMake(0, 0, itemW, itemH);
        item.center = CGPointMake(itemCenterX, itemCenterY);
        [item setNeedsDisplay];
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
    for (LZBTabBarItem *item in items){
        [self addSubview:item];
        [item addTarget:self
                 action:@selector(tabbarItemDidSelected:)
       forControlEvents:UIControlEventTouchUpInside];
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
    self.currentSelectItem = item;
    if([self.delegate respondsToSelector:@selector(lzb_tabBar:didSelectItemAtIndex:)]){
        [self.delegate lzb_tabBar:self
             didSelectItemAtIndex:index];
    }
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


