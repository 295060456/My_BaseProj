//
//  HotLabel.m
//  My_BaseProj
//
//  Created by Administrator on 08/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "HotLabel.h"

@interface HotLabel (){
    
}

//内容物对父控件而言
@property(nonatomic,assign)CGFloat topOffset;//上边距
//内容物之间
@property(nonatomic,assign)CGFloat eachOffset;//标签互相之间的距离
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,strong)NSMutableArray *labelMutArr;
//动态运算值————当前状态下最后一个label,右下角的x轴坐标
@property(nonatomic,assign)CGFloat lastPoint;

@property(nonatomic,copy)MKDataBlock heightBlock;

@end

@implementation HotLabel

-(instancetype)initWithTopOffset:(CGFloat)topOffset
                       eachOffset:(CGFloat)eachOffset{
    
    if (self = [super init]) {
        
        self.topOffset = topOffset;
        
        self.eachOffset = eachOffset;
        
        self.lastPoint = 0.00f;
        
        self.row = 0;
        
    }return self;
}

-(void)actionBlock:(MKDataBlock)Block{
    
    self.heightBlock = Block;
}

-(void)hotLabelWithDataArr:(NSArray *)dataArr{
    
    //label.mj_w + 间隔(eachOffset) = 一组
    for (int i = 0; i < dataArr.count; i++) {

        UILabel *lable = UILabel.new;
        
        lable.backgroundColor = RandomColor;

        lable.text = dataArr[i];
        
        [lable sizeToFit];//根据数据撑开Lable 得到其Size值
        
        [self addSubview:lable];
        
        UILabel *lab = self.labelMutArr.lastObject;
        
        if (lab) {
            
            self.lastPoint = lab.mj_x + lab.mj_w;
            
            if (self.lastPoint + lable.mj_w > self.mj_x + self.mj_w) {//提行
                
                ++self.row;
                
                lable.origin = CGPointMake(self.mj_x, self.topOffset + self.row * (lable.mj_h + self.eachOffset));
                
            }else{//本行执行
                
                UILabel *lab = self.labelMutArr.lastObject;
                
                lable.origin = CGPointMake(lab.mj_x + lab.mj_w + self.eachOffset, lab.mj_y);
            }
        }else{
            
            lable.origin = CGPointMake(self.mj_x, self.topOffset);//第一个基准值
        }
        
        [self.labelMutArr addObject:lable];
        
//        NSLog(@"%f",self.lastPoint);
    }
    
    if (self.heightBlock) {
        
        self.heightBlock(self.labelMutArr.lastObject);
    }
}

-(NSMutableArray *)labelMutArr{
    
    if (!_labelMutArr) {
        
        _labelMutArr = NSMutableArray.array;
    }
    
    return _labelMutArr;
}


@end
