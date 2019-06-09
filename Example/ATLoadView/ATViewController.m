//
//  ATViewController.m
//  ATLoadView
//  https://github.com/ablettchen/ATLoadView
//
//  Created by ablett on 2019/5/5.
//  Copyright (c) 2019 ablett. All rights reserved.
//

#import "ATViewController.h"
#import <ATLoadView/ATLoadView.h>
#import <ATCategories.h>
#import <Masonry.h>

@interface ATViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;
@end

@implementation ATViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColorHex(0xF6F6F6A);
    self.title = @"ATLoadView";
    [self.view addSubview:self.tableView];
    self.datas = [NSMutableArray array];
    [self.datas addObjectsFromArray:@[@"Load - Default", \
                                      @"Load - Light", \
                                      @"Load - Dark", \
                                      @"Load - Gif image"]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideTop);
        make.left.bottom.right.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter, getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = 0.f;
        _tableView.estimatedSectionHeaderHeight = 0.f;
        _tableView.estimatedSectionFooterHeight = 0.f;
        _tableView.rowHeight = 50.f;
    }
    return _tableView;
}

#pragma mark - privite

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoCell"];
    if (!cell) {
        cell = [UITableViewCell new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.datas[indexPath.row]];
    if ((indexPath.row % 2) == 0) {cell.backgroundColor = UIColorHex(0x1515151A);}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.datas[indexPath.row];
    
    if ([title isEqualToString:@"Load - Default"]) {
        
        ATLoadView *view = [ATLoadView viewWithText:@"LOADING..."];
        [view showIn:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view hide];
        });
        
    }else if ([title isEqualToString:@"Load - Light"]) {
        
        ATLoadView *view = [ATLoadView viewWithLightStyle];
        [view showIn:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view hide];
        });
        
    }else if ([title isEqualToString:@"Load - Dark"]) {
        
        ATLoadView *view = [ATLoadView viewWithDarkStyle];
        [view showIn:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view hide];
        });
        
    }else if ([title isEqualToString:@"Load - Gif image"]) {

        ATLoadView *view = [ATLoadView viewWithGifImage:[YYImage imageNamed:@"popup_load_balls.gif"]];
        [view showIn:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view hide];
        });
        
    }
}

@end
