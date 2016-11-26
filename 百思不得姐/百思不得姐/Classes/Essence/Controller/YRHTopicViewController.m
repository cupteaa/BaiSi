//
//  YRHTopicViewController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHTopicViewController.h"
#import "YRHTopic.h"
#import "YRHTopicCell.h"
#import "YRHPictureView.h"

#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking.h>


@interface YRHTopicViewController ()
/** 所有网络请求的数据 */
@property (nonatomic,strong) NSMutableArray *topics;
/** maxtime */
@property (nonatomic,copy) NSString *maxtime;
/** current page */
@property (nonatomic,assign) NSInteger page;
/** 上一次的请求参数 */
@property (nonatomic,strong) NSDictionary *parameters;

@end

@implementation YRHTopicViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRefresh];
}
static NSString * const topicID = @"topicCell";
- (void)setupTableView
{
    // 设置内边距
    CGFloat bottom = 49;//self.tabBarController.tabBar.height;
    CGFloat top = YRHTitlesViewH + YRHTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YRHTopicCell class]) bundle:nil] forCellReuseIdentifier:topicID];
}

// 刷新
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}
- (void)loadNewTopics
{
    [self.tableView.mj_footer endRefreshing];
    // 请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    self.parameters = parameters;
    // 发送请求数据
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parameters != parameters) return;
        [self.tableView.mj_header endRefreshing];
        // 解析JSON数据
        self.topics = [YRHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 刷新表格
        [self.tableView reloadData];
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters != parameters) return;
        // 请求数据失败
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics
{
    [self.tableView.mj_header endRefreshing];
    self.page++;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    self.parameters = parameters;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parameters != parameters) return;
        [self.tableView.mj_footer endRefreshing];
        NSArray *newTopics = [YRHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters != parameters) return;
        [self.tableView.mj_footer endRefreshing];
        self.page--;
    }];
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YRHTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicID];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出cell对应的模型数据
    YRHTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消cell选中样式
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}






















@end
