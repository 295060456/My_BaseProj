//
//  MKProxy.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKProxy.h"

@interface MKProxy ()

@property(nonatomic,strong)NSObject *object;

@end

@implementation MKProxy

static MKProxy *static_mkProxy = nil;
+(MKProxy *)sharedInstance{
    @synchronized(self){
        if (!static_mkProxy) {
            static_mkProxy = MKProxy.alloc;
        }
    }return static_mkProxy;
}
/*
 NSProxy实现了包括NSObject协议在内基类所需的基础方法，但是作为一个抽象的基类并没有提供初始化的方法。它接收到任何自己没有定义的方法他都会产生一个异常，所以一个实际的子类必须提供一个初始化方法或者创建方法，并且重载forwardInvocation:方法和methodSignatureForSelector:方法来处理自己没有实现的消息
 */
- (id)transformToObject:(NSObject *)object{
    self.object = object;
    return self.object;
}
//获得调用方法的方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSMethodSignature *signature;
    if (_object) {
        signature = [self.object methodSignatureForSelector:sel];
    } else {
       signature= [super methodSignatureForSelector:sel];
    }return signature;
}
//为调用设置目标
- (void)forwardInvocation:(NSInvocation *)invocation{
    if (self.object) {
        [invocation invokeWithTarget:self.object];
    }
}
#pragma mark —— lazyLoad


@end
