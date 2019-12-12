//
//  YBNotificationManager.h
//  Created by Aalto on 2018/12/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <Foundation/Foundation.h>
FOUNDATION_EXTERN NSString * const kNotify_IsBackExchangeRefresh;
FOUNDATION_EXTERN NSString * const kNotify_IsLoginRefresh;
FOUNDATION_EXTERN NSString * const kNotify_IsLoginOutRefresh;
FOUNDATION_EXTERN NSString * const kNotify_editAccount_01;
//FOUNDATION_EXTERN NSString * const kNotify_editAccount_02;

FOUNDATION_EXTERN NSString * const kNotify_IsRegisterSuccessBindingGoogleSuccessRefresh;

FOUNDATION_EXTERN NSString * const kNotify_IsSelectedNoTransactionTabarRefresh;
FOUNDATION_EXTERN NSString * const kNotify_IsPayCellInPostAdsRefresh;

FOUNDATION_EXTERN NSString * const kNotify_jumpAssetVC;
FOUNDATION_EXTERN NSString * const kNotify_IsStopTimeRefresh;
FOUNDATION_EXTERN NSString * const kNotify_IsPayStopTimeRefresh;
FOUNDATION_EXTERN NSString * const kNotify_NetWorkingStatusRefresh;
extern NSString* const kUserAssert;
extern NSString* const kIsBuyTip;
extern NSString* const kIsScanTip;

extern NSString* const KNotToRemindWhenNext;

extern NSString* const kIsLogin;

extern NSString* const kUserName;
extern NSString* const kUserPW;
extern NSString* const kUserInfo;

extern NSString* const kFixedAccountsInTransactions;

extern NSString* const kPayMethodesInPostAds;
extern NSString* const kLimitAccountsInPostAds;
extern NSString* const kFixedAccountsInPostAds;

extern NSString* const kFixedAccountsSelectedItemInPostAds;

extern NSString* const kControlNumberInPostAds;
extern NSString* const kControlTimeInPostAds;

extern NSString* const kNumberAndTimeInPostAds;
extern NSString* const kPaymentWaysInPostAds;
extern NSString* const kCheckNoOpenPayMethodesInPostAds;

extern NSString* const kIndexSection;
extern NSString* const kIndexInfo;
extern NSString* const kIndexRow;

extern NSString* const kType ;
extern NSString* const kIsOn ;
extern NSString* const kImg;
extern NSString* const kTip;
extern NSString* const kSubTip;
extern NSString* const kUrl;
extern NSString* const kArr;
extern NSString* const kData;

extern NSString* const kHomeCoinListDataKey;
extern NSString* const kHomeBannerDataKey;

extern NSString* const kNotify_HomeRootVC;

NS_ASSUME_NONNULL_BEGIN

@interface YBNotificationManager : NSObject
@end

NS_ASSUME_NONNULL_END
