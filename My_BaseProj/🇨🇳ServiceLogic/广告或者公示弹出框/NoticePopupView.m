//
//  NoticePopupView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import "NoticePopupView.h"

@interface NoticePopupView ()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation NoticePopupView

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.imageView.alpha = 1;
        self.isOK = YES;
    }
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = KBuddleIMG(@"⚽️PicResource",
                                      @"开屏页面",
                                      nil,
                                      @"title4");
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _imageView;
}

@end
