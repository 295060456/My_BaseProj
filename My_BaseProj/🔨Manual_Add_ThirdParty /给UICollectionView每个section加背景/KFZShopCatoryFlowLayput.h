//
//  KFZShopCatoryFlowLayput.h
//  UBallLive
//
//  Created by Jobs on 2020/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 自定义section背景view 注意继承于UICollectionReusableView
 */
@interface KFZShopCatorySectionWhiteBgView : UICollectionReusableView

@property(nonatomic,strong)UIColor *bgCor;
@property(nonatomic,assign)CGFloat cornerRadius;

@end

@interface KFZShopCatoryFlowLayput : UICollectionViewFlowLayout

@property(nonatomic,strong)NSMutableArray <NSNumber *>*affectedSectionsMutArr;//受影响的section组
@property(nonatomic,assign)CGFloat offsetX;
@property(nonatomic,assign)CGFloat offsetY;
@property(nonatomic,assign)CGFloat offsetWidth;
@property(nonatomic,assign)CGFloat offsetHeight;

@end

NS_ASSUME_NONNULL_END
