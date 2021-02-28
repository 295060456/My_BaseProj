//
//  MKProxy.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKProxy : NSProxy

+ (MKProxy *)sharedInstance;
/**
*  NSProxy实现了包括NSObject协议在内基类所需的基础方法，但是作为一个抽象的基类并没有提供初始化的方法.它接收到任何自己没有定义的方法他都会产生一个异常，所以一个实际的子类必须提供一个初始化方法或者创建方法，并且重载forwardInvocation:方法和methodSignatureForSelector:方法来处理自己没有实现的消息。这也是NSProxy的主要功能，负责把消息转发给真正的target的代理类，NSProxy正是代理的意思。

   这个类实现消息转发，相当于代理。因为iOS不允许多继承，那么消息转发机制可以让类同时拥有多个类的方法实现
   NSProxy是一个类似于NSObject的根类

   1、先设置一个类GTProxy,继承NSProxy
   2、为GTProxy设置一个NSObject 属性
   3、自定义一个转换方法,相当于给 NSObject 属性赋值
   4、然后通过这个属性获得调用方法的方法签名methodSignatureForSelector:
   5、为调用设置目标forwardInvocation:

*/

- (id)transformToObject:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END
