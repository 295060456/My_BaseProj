//
//  LZBTabBarItem.m
//  My_BaseProj
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "LZBTabBarItem.h"
#import "LOTAnimationView+action.h"

@interface LZBTabBarItem()<UIGestureRecognizerDelegate>

@property(nonatomic,copy)MKDataBlock LZBTabBarItemBlock;
@property(nonatomic,copy)MKDataBlock LZBTabBarItemActionBlock;

//手势
@property(nonatomic,strong)UITapGestureRecognizer *tagGR;//敲击
@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;//长按

@end

@implementation LZBTabBarItem

- (instancetype)initWithFrame:(CGRect)frame{
  if(self = [super initWithFrame:frame]){
      [self setupInit];
      //添加手势
      self.tagGR.enabled = YES;
      self.longPressGR.enabled = YES;
      NSLog(@"");
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

-(void)setTagger:(NSInteger)tagger{
    _tagger = tagger;
    [self Lottie];
}

-(void)LZBTabBarItemBlock:(MKDataBlock)LZBTabBarItemBlock{
    self.LZBTabBarItemBlock = LZBTabBarItemBlock;
}

-(void)actionLZBTabBarItemBlock:(MKDataBlock)LZBTabBarItemActionBlock{
    self.LZBTabBarItemActionBlock = LZBTabBarItemActionBlock;
}

-(void)Lottie{
    //Lottie
    self.animation = [LOTAnimationView animationNamed:self.lottieJsonNameStrMutArr[self.tagger]];
//    self.animation.userInteractionEnabled = YES;
//    self.animation.loopAnimation//是否循环
//    self.animation.animationProgress//动画的进度
//    self.animation.animationDuration//动画时长
//    self.animation.isAnimationPlaying//动画是否在执行
    self.animation.animationSpeed = 3;//放慢动画播放速度?
    [self addSubview:self.animation];
    @weakify(self)
    [self.animation actionLOTAnimationViewBlock:^(id data) {
        @strongify(self)
        if (self.LZBTabBarItemActionBlock) {
            self.LZBTabBarItemActionBlock(@(self.tagger));
        }
    }];
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
                                              imageTopMaigin+imageSize.height + self.titleOffest.vertical,
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

#pragma mark —— 手势的响应事件
-(void)LZBTabBarItemTap:(UITapGestureRecognizer *)tag{
    if (self.LZBTabBarItemBlock) {
        self.LZBTabBarItemBlock(tag);
    }
}

-(void)LZBTabBarItemLongPress:(UILongPressGestureRecognizer *)longPressGesture {
    switch (longPressGesture.state) {
        case UIGestureRecognizerStatePossible:{
//            NSLog(@"没有触摸事件发生，所有手势识别的默认状态");
        }break;
        case UIGestureRecognizerStateBegan:{
            NSLog(@"一个手势已经开始  但尚未改变或者完成时");
            if (self.LZBTabBarItemBlock) {
                self.LZBTabBarItemBlock(longPressGesture);
            }
        }break;
        case UIGestureRecognizerStateChanged:{
//            NSLog(@"手势状态改变");
        }break;
        case UIGestureRecognizerStateEnded:{// = UIGestureRecognizerStateRecognized
//            NSLog(@"手势完成");
        }break;
        case UIGestureRecognizerStateCancelled:{
//            NSLog(@"手势取消，恢复至Possible状态");
        }break;
        case UIGestureRecognizerStateFailed:{
//            NSLog(@"手势失败，恢复至Possible状态");
        }break;
        default:
            break;
    }
}

#pragma mark —— lazyLoad
-(UITapGestureRecognizer *)tagGR{
    if (!_tagGR) {
        _tagGR = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                        action:@selector(LZBTabBarItemTap:)];
        _tagGR.delegate = self;
        
        _tagGR.numberOfTapsRequired = 1;//tap次数
        _tagGR.numberOfTouchesRequired = 1;//手指数
        
        [self addGestureRecognizer:_tagGR];
    }return _tagGR;
}

-(UILongPressGestureRecognizer *)longPressGR{

    /*
     * 长按手势是连续的。
     当在指定的时间段（minimumPressDuration）
     按下允许的手指的数量（numberOfTouchesRequired）
     并且触摸不超过允许的移动范围（allowableMovement）时，
     手势开始（UIGestureRecognizerStateBegan）。
     手指移动时，手势识别器转换到“更改”状态，
     并且当任何手指抬起时手势识别器结束（UIGestureRecognizerStateEnded）。
     *
     */
    
    if (!_longPressGR) {
        _longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(LZBTabBarItemLongPress:)];
        _longPressGR.delegate = self;
        
        _longPressGR.numberOfTouchesRequired = 1;//手指数
        _longPressGR.minimumPressDuration = 1;
//        _longPressGR.allowableMovement;

        [self addGestureRecognizer:_longPressGR];
    }return _longPressGR;
}

-(NSMutableArray<NSString *> *)lottieJsonNameStrMutArr{
    if (!_lottieJsonNameStrMutArr) {
        _lottieJsonNameStrMutArr = NSMutableArray.array;
        [_lottieJsonNameStrMutArr addObject:@"green_lottie_tab_discover.json"];
        [_lottieJsonNameStrMutArr addObject:@"green_lottie_tab_home.json"];
        [_lottieJsonNameStrMutArr addObject:@"green_lottie_tab_mine.json"];
        [_lottieJsonNameStrMutArr addObject:@"green_lottie_tab_mine.json"];
        [_lottieJsonNameStrMutArr addObject:@"green_lottie_tab_news.json"];
    }return _lottieJsonNameStrMutArr;
}
#pragma mark —— config
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
