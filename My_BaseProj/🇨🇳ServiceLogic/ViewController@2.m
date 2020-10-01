//
//  ViewController@2.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@2.h"

#import "MJRefreshComponent+Lottie.h"
#import "TestTableViewHeader.h"
#import "BaseVC+MJRefresh.h"

///视频框架
//#import <libavformat/avformat.h>
//#import <libavcodec/avcodec.h>
//#import <libswscale/swscale.h>
//#import <libavutil/avutil.h>
//#import <libswresample/swresample.h>
//#import <libavdevice/avdevice.h>
//#import <libavfilter/avfilter.h>

@interface ViewController_2 ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController_2

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:ReuseIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}
#pragma mark —— tableView
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = UITableView.new;
        _tableView.frame = self.view.bounds;
        _tableView.backgroundColor = kGrayColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_header = TestTableViewHeader.new;//self.mjRefreshGifHeader;//
        _tableView.mj_header.jsonString = @"12345.json";
        [self.view addSubview:_tableView];
    }return _tableView;
}

@end
