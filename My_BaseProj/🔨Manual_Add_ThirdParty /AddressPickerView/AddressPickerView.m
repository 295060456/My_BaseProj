//
//  AddressPickerView.m
//  CJAddressPicker
//
//  Created by 陈雄 on 2019/5/21.
//  Copyright © 2019 Chan. All rights reserved.
//

#import "AddressPickerView.h"
#define kImage(xxx) [[UIImage imageNamed:xxx]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
@interface AddressPickerView ()
<UIPickerViewDelegate,
UIPickerViewDataSource> {
    UIButton *_cancel;
    UIButton *_positive;
    UIView *_containerView;
    
    UIPickerView *_addressPicker;
    NSArray <NSDictionary *> *_dataArray;
    
    NSInteger _index1;
    NSInteger _index2;
    NSInteger _index3;
    NSInteger _index4;
}

@end

@implementation AddressPickerView

+ (instancetype)addressPickerViewWithComplete:(void (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))complete {
    return [[AddressPickerView alloc] initWithComplete:complete];
}

// MARK: - initialized Method
- (instancetype)initWithComplete:(void (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))complete {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds] ) {
        _complete = complete;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        _index1 = _index2 = _index3 = 0;
        NSString *cityPath =  [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:cityPath];
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 230)];
        _containerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_containerView];
        
        //取消
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancel setImage:kImage(@"cancel") forState:UIControlStateNormal];
        _cancel.frame = CGRectMake(25, 10, 30, 30);
        [_cancel addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_containerView addSubview:_cancel];
        
        UILabel *title = [UILabel new];
        title.frame = CGRectMake(60, 0, [UIScreen mainScreen].bounds.size.width - 60 - 60, 50);
        title.text = @"工作城市";
        title.font = [UIFont systemFontOfSize:15];
        title.textAlignment = 1;
        [_containerView addSubview:title];
        
        //确定
        _positive = [UIButton buttonWithType:UIButtonTypeCustom];
        [_positive setImage:kImage(@"positive") forState:UIControlStateNormal];
        _positive.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30 - 30, 10, 30, 30);
        [_positive addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_containerView addSubview:_positive];
        
        [UIView animateWithDuration:0.2 animations:^{
            _containerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height  - 230, [UIScreen mainScreen].bounds.size.width, 230);
        }];
        CGFloat itemW = [UIScreen mainScreen].bounds.size.width / 4.0;
        
        _addressPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50,itemW * 4 , 180)];
        _addressPicker.dataSource = self;
        _addressPicker.delegate = self;
        [_containerView addSubview:_addressPicker];
        _addressPicker.showsSelectionIndicator = YES;
    }
    return self;
}

// MARK: - private Method
- (void)buttonAction:(id)sender {
    if ([sender isEqual:_cancel]) {
        [self hide];
    } else {
        [self hide];
        if (_complete) {
            NSString *provinceStr =  _dataArray[_index1][@"state"];
            NSDictionary *json1 = _dataArray[_index1];
            NSString *cityStr = json1[@"cities"][_index2][@"city"];
            NSDictionary *json2 = _dataArray[_index1][@"cities"][_index2];
            NSString *subCityStr =  json2[@"areas"][_index2][@"county"];
            NSDictionary *json3 = _dataArray[_index1][@"cities"][_index2][@"areas"][_index3];
            NSString *streetStr = json3[@"streets"][_index4];
            _complete(provinceStr,cityStr,subCityStr,streetStr);
        }
    }
}

// MARK: - hide
- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
       self->_containerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 230);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// MARK: - UIPickerViewDataSource&Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        //省
        return _dataArray.count;
    } else if (component == 1) {
        //市
        NSDictionary *json = _dataArray[_index1];
        return ((NSArray *)json[@"cities"]).count;
    } else if (component == 2) {
        //区
        NSDictionary *json = _dataArray[_index1][@"cities"][_index2];
        return ((NSArray *)json[@"areas"]).count;
    } else if(component == 3) {
        //街道
        if (((NSArray *)_dataArray[_index1][@"cities"]).count) {
            if (((NSArray *)_dataArray[_index1][@"cities"][_index2][@"areas"]).count) {
                NSDictionary *json = _dataArray[_index1][@"cities"][_index2][@"areas"][_index3];
                return ((NSArray *)json[@"streets"]).count;
            } else  {
                return 0;
            }
        } else {
            return 0;
        }
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = [UIFont systemFontOfSize:15];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        //省
        return _dataArray[row][@"state"];
    } else if (component == 1) {
        //市
        NSDictionary *json = _dataArray[_index1];
        return json[@"cities"][row][@"city"];
    } else if (component == 2) {
        //区
        NSDictionary *json = _dataArray[_index1][@"cities"][_index2];
        return  json[@"areas"][row][@"county"];
    } else if (component == 3) {
        //街道
        NSDictionary *json = _dataArray[_index1][@"cities"][_index2][@"areas"][_index3];
        return json[@"streets"][row];
    }else {
        return @"";
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 55;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0 ) {
        _index1 = row;
    } else if (component == 1) {
        _index2 = row;
    } else if (component == 2) {
        _index3 = row;
    } else if (component == 3) {
        _index4 = row;
    }
    [pickerView reloadComponent:1];
    [pickerView reloadComponent:2];
    [pickerView reloadComponent:3];
}

// MARK: - memory management
- (void)dealloc {
    if (_dataArray) {
        _dataArray = nil;
    }
    if (_addressPicker) {
        _addressPicker = nil;
    }
}

@end
