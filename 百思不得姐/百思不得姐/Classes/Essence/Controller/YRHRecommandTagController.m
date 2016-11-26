//
//  YRHRecommandTagController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHRecommandTagController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import "YRHRecommandTag.h"
#import "YRHRecommandTagCell.h"

@interface YRHRecommandTagController ()
/** 网络请求的所有数据 */
@property (nonatomic,strong) NSArray *tags;
/** manager */
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation YRHRecommandTagController

static NSString * const tagID = @"tagCell";
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

- (void)setupTableView
{
    // 设置内边距
    CGFloat bottom = 49;//self.tabBarController.tabBar.height;
    CGFloat top = YRHTitlesViewH + YRHTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)setupUI
{
    self.title = @"推荐订阅";
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = YRHGlobalBg;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"YRHRecommandTagCell" bundle:nil] forCellReuseIdentifier:tagID];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

// 请求数据
- (void)loadData
{
    // 0.显示遮盖
    [SVProgressHUD show];
    // 1.设置请求参数 http://api.budejie.com/api/api_open.php?a=tag_recommend&action=sub&c=topic
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    // 2.请求数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 数据请求成功,隐藏遮盖
        [SVProgressHUD dismiss];
        // 解析服务器返回的数据
        self.tags = [YRHRecommandTag mj_objectArrayWithKeyValuesArray:responseObject];
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 数据请求失败
        [SVProgressHUD showErrorWithStatus:@"数据请求失败"];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YRHRecommandTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagID];
    cell.recommandTag = self.tags[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}




















@end
