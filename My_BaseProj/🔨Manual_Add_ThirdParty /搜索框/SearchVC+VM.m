//
//  SearchVC+VM.m
//  Feidegou
//
//  Created by Kite on 2019/11/23.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "SearchVC+VM.h"

@implementation SearchVC (VM)

-(void)networking_type:(NSString *)inputStr{//按输入的订单号搜索
    NSDictionary *dic = @{
        @"currentpage":@"",//分页数 默认1
        @"pagesize":@"",//分页大小 默认12
        @"order_status":@"",//状态：0、已支付;1、已发单;2、已下单;3、已作废;4、已发货;5、已完成;默认查全部
        @"type":@"",//买家1;卖家2;默认查全部
        @"order_code":inputStr,//搜索订单号
        @"order_type":@""//1、转转;2、批发;3、厂家;默认查全部
    };
    TBVCell_style_01;
    [self networkingWithArgument:dic];
}
//正式请求
-(void)networkingWithArgument:(NSDictionary *)dic{
    if (self.dataMutArr.count) {
        [self.dataMutArr removeAllObjects];
    }

    NSString *randomStr = [EncryptUtils shuffledAlphabet:16];
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:CatfoodManageURL
                                                     parameters:@{
                                                         @"data":dic,
                                                         @"key":[RSAUtil encryptString:randomStr
                                                                             publicKey:RSA_Public_key]
                                                     }];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {

    }];
}

@end
