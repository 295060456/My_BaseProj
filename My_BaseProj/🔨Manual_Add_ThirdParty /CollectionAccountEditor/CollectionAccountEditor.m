//
//  CollectionAccountEditorView.m
//  gt
//
//  Created by Administrator on 10/05/2019.
//  Copyright © 2019 GT. All rights reserved.
//

#import "CollectionAccountEditor.h"

#pragma mark —— CollectionAccountEditor
@interface CollectionAccountEditor (){
}

@property(nonatomic,strong)UIView *coverView;//遮罩物
@property(nonatomic,strong)ContentView *contentView;//内容物
@property(nonatomic,assign)MoveDirection moveDirection;//移动方向
@property(nonatomic,assign)CGFloat height_contentView;//内容物高度
@property(nonatomic,copy)DataBlock hideBlock;

@end

@implementation CollectionAccountEditor

+(instancetype)initWithCovering:(HaveCovering)haveCovering
              contentViewHeight:(CGFloat)height
               contentViewBlock:(DataBlock)contentViewBlock
                    finishBlock:(NoResultBlock)finishBlock{
    UIWindow *window = nil;
    if ((@available(iOS 13.0, *))) {
        window = [SceneDelegate sharedInstance].window;
    }else{
        window = UIApplication.sharedApplication.delegate.window;
    }
//     @weakify(self)
    CollectionAccountEditor *editorView = CollectionAccountEditor.new;
    editorView.height_contentView = height;
    switch (haveCovering) {
        case HaveCovering_no:{
            [getMainWindow() addSubview:editorView.contentView];
            [UIView animateWithDuration:0.25
                             animations:^{
//                                 kStrongSelf(self);
                                 //变动以后的值
                                 [UIView animateWithDuration:0.25
                                                  animations:^{
//                                                      kStrongSelf(self);
                                                      //变动以后的值
                                                      editorView.contentView.mj_y = height;
                                                      contentViewBlock(editorView.contentView);
                                                      finishBlock();
                                                  }];
                             }];
        }
            break;
        case HaveCovering_yes:{
            [getMainWindow() addSubview:editorView.coverView];
            [getMainWindow() addSubview:editorView.contentView];
            [UIView animateWithDuration:0.25
                             animations:^{
//                                 kStrongSelf(self);
                                 //变动以后的值
                                 editorView.contentView.mj_y = height;
                                 contentViewBlock(editorView.contentView);
                                 finishBlock();
                             }];
        }
            break;
        default:
            break;
    }return editorView;
}

-(void)actionBlock:(DataBlock)block{
    self.hideBlock = block;
}

-(void)launch{
    NSLog(@"开始启动");
}

-(void)close{
    [self hideInputView];
}

-(UIView *)coverView{
    if (!_coverView) {
        _coverView = UIView.new;
        _coverView.frame = CGRectMake(0,
                                      0,
                                      MAINSCREEN_WIDTH,
                                      MAINSCREEN_HEIGHT);
#warning 如果透明度单独设置,那么加在此父控件的子控件也会呈现透明状态
        _coverView.backgroundColor = COLOR_HEX(0xb3000000, 0.7);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(hideInputView)];

        [_coverView addGestureRecognizer:tap];
    }return _coverView;
}

-(ContentView *)contentView{
    if (!_contentView) {
        _contentView = ContentView.new;
        _contentView.frame = CGRectMake(0,
                                        self.height_contentView,
                                        MAINSCREEN_WIDTH,
                                        MAINSCREEN_HEIGHT);
        _contentView.backgroundColor = kWhiteColor;
        @weakify(self)
        [_contentView actionBlock:^(id data) {
            NSLog(@"%@",data);
            NSLog(@"%d",[data intValue]);
            @strongify(self)
            switch ([data intValue]) {
                case MoveDirection_vertical:{
                    [self hideInputView_vertical];
                }
                    break;
                case MoveDirection_horizont:{
                    [self hideInputView_horizont];
                }
                    break;
                default:
                    break;
            }
        }];
        [UIView cornerCutToCircleWithView:_contentView
                          AndCornerRadius:8];
    }return _contentView;
}
//垂直消失
-(void)hideInputView_vertical{
    @weakify(self)
    [UIView animateWithDuration:0.25f
                     animations:^{
                         @strongify(self)
                         if (self.contentView.mj_y <= self.contentView.height / 2) {
                             self.contentView.mj_y = self.height_contentView;
                             self.contentView.mj_x = 0;
                             self.coverView.alpha = 1;
                         } else {
                             self.contentView.mj_y = MAINSCREEN_HEIGHT;
                             self.contentView.mj_x = 0;
                             self.coverView.alpha = 0;
                         }
                     }
                     completion:^(BOOL finished) {//结束销毁
                         @strongify(self)
                         if (self.contentView.mj_y > self.contentView.height / 2) {
                             [self.contentView removeFromSuperview];
                             self.contentView = nil;
                             if (self.coverView) {
                                 [self.coverView removeFromSuperview];
                                 self.coverView = nil;
                             }
                         }else return;
                     }];
    self.hideBlock(@1);
}
//水平消失
-(void)hideInputView_horizont{
    @weakify(self)
    [UIView animateWithDuration:0.25f
                     animations:^{
                         @strongify(self)
                         if (self.contentView.mj_x <= MAINSCREEN_WIDTH / 2) {//回原位
                             self.contentView.mj_x = 0;
                             self.contentView.mj_y = self.height_contentView;
                             self.coverView.alpha = 1;
                         }else{
                             self.contentView.mj_x = MAINSCREEN_WIDTH;
                             self.contentView.mj_y = self.height_contentView;
                             self.coverView.alpha = 0;
                         }
                     }
                     completion:^(BOOL finished) {//结束销毁
                         @strongify(self)
                         if (self.contentView.mj_x > MAINSCREEN_WIDTH / 2) {
                             [self.contentView removeFromSuperview];
                             self.contentView = nil;
                             if (self.coverView) {
                                 [self.coverView removeFromSuperview];
                                 self.coverView = nil;
                             }
                         }else return;
                     }];
     self.hideBlock(@1);
}
//点击遮罩部分消失
-(void)hideInputView{
    @weakify(self)
    [UIView animateWithDuration:0.25f
                     animations:^{
                         @strongify(self)
                         self.contentView.mj_y = MAINSCREEN_HEIGHT;
                         self.contentView.mj_x = 0;
                         self.coverView.alpha = 0;
                     }
                     completion:^(BOOL finished) {//结束销毁
                         @strongify(self)
                         [self.contentView removeFromSuperview];
                         self.contentView = nil;
                         if (self.coverView) {
                             [self.coverView removeFromSuperview];
                             self.coverView = nil;
                         }
                     }];
    self.hideBlock(@1);
}

@end

#pragma mark —— contentView
@interface ContentView ()

@property(nonatomic,copy)DataBlock block;
@property(nonatomic,assign)MoveDirection moveDirection;

@end

@implementation ContentView

- (void)touchesMoved:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    NSLog(@"touchesMoved");
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self];
    //以前的point
    CGPoint preP = [touch previousLocationInView:self];
    //x轴偏移的量
    CGFloat offsetX = currentP.x - preP.x;
    //Y轴偏移的量
    CGFloat offsetY = currentP.y - preP.y;
    if (self.mj_x >= 0) {//禁止左边界超出
        //判断是水平 还是 垂直
        if (fabs(offsetX) > fabs(offsetY)) {//水平:X水平偏移量大于Y垂直偏移量
            if (self.mj_y > self.height) {//已经垂直移动，禁止水平移动(抛出)
            }else{
                self.moveDirection = MoveDirection_horizont;
                self.transform = CGAffineTransformTranslate(self.transform, offsetX, 0);
            }
        }else if (fabs(offsetX) <= fabs(offsetY)){//垂直:Y垂直偏移量大于X水平偏移量
            if (self.mj_x > 0) {//已经水平移动，禁止垂直移动(抛出)
            }else{
                self.moveDirection = MoveDirection_vertical;
                self.transform = CGAffineTransformTranslate(self.transform, 0, offsetY);
            }
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    NSLog(@"touchesEnded");
    switch (self.moveDirection) {
        case MoveDirection_vertical:{
            [self back:MoveDirection_vertical];
        }
            break;
        case MoveDirection_horizont:{
            [self back:MoveDirection_horizont];
        }
            break;
        default:
            break;
    }
}

- (void)back:(MoveDirection)moveDirection{
    switch (moveDirection) {
        case MoveDirection_horizont:{
            self.block(@(MoveDirection_horizont));
        }
            break;
        case MoveDirection_vertical:{
            self.block(@(MoveDirection_vertical));
        }
            break;
        default:
            break;
    }
}

-(void)actionBlock:(DataBlock)block{
    self.block = block;
}

@end
