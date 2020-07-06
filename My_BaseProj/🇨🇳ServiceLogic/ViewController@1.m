//
//  ViewController@1.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@1.h"
#import "HistoryDataListTBV.h"
#import "HistoryDataListTBVCell.h"

#import "LGiOSBtn.h"

@interface ViewController_1 ()<UITextFieldDelegate,DZDeleteButtonDelegate>{

}

//@property (nonatomic, assign) BOOL isShowEmailSuffix;   //是否在输入@后显示email后缀
//@property (nonatomic, assign) BOOL isAutoCompleterEmailSuffix;  //是否自动补全email后缀
@property(nonatomic,strong)ZYTextField_01 *textField;
@property(nonatomic,strong)UIView *mainView;
@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)DataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation ViewController_1

- (void)dealloc {
    
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)pushFromVC:(UIViewController *)rootVC
             requestParams:(nullable id)requestParams
                   success:(DataBlock)block
                  animated:(BOOL)animated{

    ViewController_1 *vc = ViewController_1.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;

    if (rootVC.navigationController) {
        vc.isPush = YES;
        vc.isPresent = NO;
        [rootVC.navigationController pushViewController:vc
                                               animated:animated];
    }else{
        vc.isPush = NO;
        vc.isPresent = YES;
        [rootVC presentViewController:vc
                             animated:animated
                           completion:^{}];
    }return vc;
}

#pragma mark - Lifecycle
-(instancetype)init{
    
    if (self = [super init]) {
        
    }return self;
}

-(void)viewDidLoad{
    
    
    LGiOSBtn *button = [[LGiOSBtn alloc] init];
    [button setImage:[UIImage imageNamed:@"图片"] forState:UIControlStateNormal];
    [button setTitle:@"百思" forState:UIControlStateNormal];
    button.delegate = self;
    button.frame = CGRectMake(20, 20, 60, 80);
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    self.view.backgroundColor = RandomColor;
    
//    [self setView:self.mainView];
//
//    NSLog(@"%@",self.mainView);
//
//    [self.mainView addSubview:self.textField];
//
//    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.mainView).offset(SCALING_RATIO(30));
//
//        make.top.equalTo(self.mainView).offset(SCALING_RATIO(30) + rectOfStatusbar + rectOfNavigationbar);
//
//        make.right.equalTo(self.mainView).offset(-SCALING_RATIO(30));
//
//        make.height.mas_equalTo((SCALING_RATIO(100)));
//    }];
}

- (void)btnClick {
    NSLog(@"点击button");
}

- (void)deleteButtonRemoveSelf:(LGiOSBtn *)button {
    NSLog(@"已经删除，要做什么事");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

#pragma mark ======== UITextFieldDelegate ======
//询问委托人是否应该在指定的文本字段中开始编辑
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;

//告诉委托人在指定的文本字段中开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}

//询问委托人是否应在指定的文本字段中停止编辑
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;

//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSLog(@"123");
    
    NSLog(@"%@",textField.text);

    [self.textField store:textField.text];
}

//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason;

//询问委托人是否应该更改指定的文本
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField;

//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    kRedColor;
    return YES;
}

#pragma mark ======== LazyLoad ======
-(UIView *)mainView{
    
    if (!_mainView) {
        
        _mainView = UIView.new;
        
        if (@available(iOS 13.0, *)) {
            _mainView.frame = [SceneDelegate sharedInstance].window.frame;
        }else{
            _mainView.frame = UIApplication.sharedApplication.delegate.window.frame;
        }
    }
    
    return _mainView;
}

-(ZYTextField_01 *)textField{
    
    if (!_textField) {
        
        _textField = [[ZYTextField_01 alloc]initWithFrame:CGRectZero
                                          documentName:@"KKK"
                                    isStoreHistoryInfo:isStoreHistoryInfo_YES];
        
        [UIView cornerCutToCircleWithView:_textField
                          AndCornerRadius:4];
        
        [UIView colourToLayerOfView:_textField
                         WithColour:kCyanColor
                     AndBorderWidth:1.0f];
        
        _textField.delegate = self;
        
//        _textField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    
    return _textField;
}

//https://www.jianshu.com/p/a1e967dead48

//http://devma.cn/blog/2016/04/01/ru-he-sheng-cheng-wen-zi-lou-kong-de-tu-pian/

@end
