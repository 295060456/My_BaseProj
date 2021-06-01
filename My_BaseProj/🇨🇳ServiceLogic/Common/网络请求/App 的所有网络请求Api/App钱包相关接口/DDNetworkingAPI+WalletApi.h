//
//  DDNetworkingAPI+WalletApi.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "DDNetworkingAPI.h"
 

NS_ASSUME_NONNULL_BEGIN

@interface DDNetworkingAPI (WalletApi)

#pragma mark —— App钱包相关接口
/// 查询游戏钱包接口
+(void)gamePursePOST:(id _Nullable)parameters
        successBlock:(MKDataBlock _Nullable)successBlock;
/// 二期抖币流水
+(void)myGoldGET:(id _Nullable)parameters
    successBlock:(MKDataBlock _Nullable)successBlock
    failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 钱包流水（二期)
+(void)myPurseFlowGET:(id _Nullable)parameters
         successBlock:(MKDataBlock _Nullable)successBlock
         failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 获取钱包用户信息二期
+(void)myUserWalletPOST:(id _Nullable)parameters
           successBlock:(MKDataBlock _Nullable)successBlock;
/// app端转账（转账即可畅玩游戏）
+(void)transferPOST:(id _Nullable)parameters
       successBlock:(MKDataBlock _Nullable)successBlock
       failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 包网回调地址
+(void)transferCallBackPOST:(id _Nullable)parameters
               successBlock:(MKDataBlock _Nullable)successBlock
               failureBlock:(MKDataBlock _Nullable)failureBlock;
/// 包网回调校验地址
+(void)transferVerifyPOST:(id _Nullable)parameters
             successBlock:(MKDataBlock _Nullable)successBlock
             failureBlock:(MKDataBlock _Nullable)failureBlock;

/// GET /app/pay/payMoneyList支付金额列表
+(void)PayMoneyListGET:(id)parameters
          successBlock:(MKDataBlock)successBlock
          failureBlock:(MKDataBlock)failureBlock;
//POST /app/pay/req请求发起支付
+(void)payReqPOST:(id)parameters
          successBlock:(MKDataBlock)successBlock
          failureBlock:(MKDataBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
