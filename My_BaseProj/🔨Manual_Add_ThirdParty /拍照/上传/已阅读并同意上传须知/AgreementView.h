//
//  AgreementView.h
//  Shooting
//
//  Created by Jobs on 2020/9/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgreementView : UIView

@property(nonatomic,strong)UIButton *agreementBtn;

-(void)actionAgreementViewBtnBlock:(MKDataBlock)agreementViewBtnBlock;
-(void)actionAgreementViewLinkBlock:(MKDataBlock)agreementViewLinkBlock;

@end

NS_ASSUME_NONNULL_END

