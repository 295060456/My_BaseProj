//
//  MJRefreshComponent+Lottie.m
//  My_BaseProj
//
//  Created by Jobs on 2020/10/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MJRefreshComponent+Lottie.h"
#import "NSObject+Extras.h"

@implementation MJRefreshComponent (Lottie)

static char *MJRefreshComponent_Lottie_loadingView = "MJRefreshComponent_Lottie_loadingView";
static char *MJRefreshComponent_Lottie_jsonString = "MJRefreshComponent_Lottie_jsonString";

@dynamic loadingView;
@dynamic jsonString;

#pragma mark —— 监听控件的刷新状态
-(void)setState:(MJRefreshState)state{
    if(self.jsonString.length > 0){
        switch (state){
            case MJRefreshStateIdle:{//普通闲置状态
                [self.loadingView stop];
                //self.loadingView.hidden = YES;
                break;
            }
            case MJRefreshStatePulling:{//松开就可以进行刷新的状态
                //self.loadingView.hidden = NO;
                break;
            }
            case MJRefreshStateRefreshing:{//正在刷新中的状态
                self.loadingView.animationProgress = 0;
                [self.loadingView play];
                break;
                
            }
            default:
                break;
        }
    }
}
//#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)LOTAnimationView *loadingView;
-(LOTAnimationView *)loadingView{
    LOTAnimationView *LoadingView = objc_getAssociatedObject(self, MJRefreshComponent_Lottie_loadingView);
    if (!LoadingView) {
        //1.加载本地json
        LoadingView = [LOTAnimationView animationNamed:self.jsonString];
        //2.加载后台给的json(url)
        //_loadingView = [[LOTAnimationView alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
        LoadingView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width / 2.0) - 25, 0, 50, 50);
        LoadingView.loopAnimation = YES;
        LoadingView.contentMode = UIViewContentModeScaleAspectFill;
        LoadingView.animationSpeed = 1.0;
        LoadingView.loopAnimation = YES;
        
        objc_setAssociatedObject(self,
                                 MJRefreshComponent_Lottie_loadingView,
                                 LoadingView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return LoadingView;
}

-(void)setLoadingView:(LOTAnimationView *)loadingView{
    objc_setAssociatedObject(self,
                             MJRefreshComponent_Lottie_loadingView,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *jsonString;
-(NSString *)jsonString{
    NSString *JsonString = objc_getAssociatedObject(self, MJRefreshComponent_Lottie_jsonString);
    return JsonString;
}

-(void)setJsonString:(NSString *)jsonString{
    objc_setAssociatedObject(self,
                             MJRefreshComponent_Lottie_jsonString,
                             jsonString,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addSubview:self.loadingView];
}

@end
