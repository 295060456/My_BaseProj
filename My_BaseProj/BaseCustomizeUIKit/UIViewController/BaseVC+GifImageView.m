//
//  BaseVC+GifImageView.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+GifImageView.h"
#import <objc/runtime.h>

@implementation BaseVC (GifImageView)

static char *BaseVC_GifImageView_gifImageView;
static char *BaseVC_GifImageView_path;
static char *BaseVC_GifImageView_data;
static char *BaseVC_GifImageView_image;

@dynamic gifImageView;
@dynamic path;
@dynamic data;
@dynamic image;

#pragma mark —— lazyLoad
-(UIImageView *)gifImageView{
    UIImageView *GifImageView = objc_getAssociatedObject(self, BaseVC_GifImageView_gifImageView);
    if (!GifImageView) {
        GifImageView = UIImageView.new;
        GifImageView.image = self.image;
        [self.view addSubview:GifImageView];
        [GifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        objc_setAssociatedObject(self,
                                 BaseVC_GifImageView_gifImageView,
                                 GifImageView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return GifImageView;
}

-(NSString *)path{
    NSString *Path = objc_getAssociatedObject(self, BaseVC_GifImageView_path);
    if (!Path) {
        Path = [[NSBundle mainBundle] pathForResource:@"GIF大图"
                                                ofType:@"gif"];
        objc_setAssociatedObject(self,
                                 BaseVC_GifImageView_path,
                                 Path,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Path;
}

-(NSData *)data{
    NSData *Data = objc_getAssociatedObject(self, BaseVC_GifImageView_data);
    if (!Data) {
        Data = [NSData dataWithContentsOfFile:self.path];
        objc_setAssociatedObject(self,
                                 BaseVC_GifImageView_data,
                                 Data,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Data;
}

-(UIImage *)image{
    UIImage *Image = objc_getAssociatedObject(self, BaseVC_GifImageView_image);
    if (!Image) {
        Image = [UIImage sd_imageWithGIFData:self.data];
        objc_setAssociatedObject(self,
                                 BaseVC_GifImageView_image,
                                 Image,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Image;
}

@end
