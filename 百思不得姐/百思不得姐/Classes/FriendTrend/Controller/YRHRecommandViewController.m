//
//  YRHRecommandViewController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHRecommandViewController.h"

#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh.h>

#import "YRHRecommandCategoryCell.h"

#import "YRHCategory.h"
#import "YRHUserCategory.h"
#import "YRHUserViewCell.h"

#define YRHSelectedCategory self.categories[self.leftCategoryTableView.indexPathForSelectedRow.row]

@interface YRHRecommandViewController ()<UITableViewDelegate,UITableViewDataSource>
// 左侧tableview
@property (weak, nonatomic) IBOutlet UITableView *leftCategoryTableView;
/** 存储右侧请求的数据 */
@property (nonatomic,strong) NSArray *categories;
// 右侧tableview
@property (weak, nonatomic) IBOutlet UITableView *rightUserTableView;
/** AFN请求管理者 */
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** 请求参数 */
@property (nonatomic,strong) NSMutableDictionary *parameters;

@end

@implementation YRHRecommandViewController

static NSString * const CategoryID = @"category";
static NSString * const UserID = @"user";

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
    [self loadCategoryData];
    
    [self setupRefresh];
}

- (void)setupUI
{
    self.title = @"推荐关注";
    // 背景色
    self.view.backgroundColor = YRHGlobalBg;
    
    self.leftCategoryTableView.delegate = self;
    self.leftCategoryTableView.dataSource = self;
    self.rightUserTableView.delegate = self;
    self.rightUserTableView.dataSource = self;
    
    // 注册cell
    [self.leftCategoryTableView registerNib:[UINib nibWithNibName:@"YRHRecommandCategoryCell" bundle:nil] forCellReuseIdentifier: CategoryID];
    [self.rightUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YRHUserViewCell class]) bundle:nil] forCellReuseIdentifier:UserID];
    
    // 右侧tableview的内边距
//    self.rightUserTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    UIView *view = [[UIView alloc] init];
    self.leftCategoryTableView.tableFooterView = view;
    self.rightUserTableView.tableFooterView = view;
}
- (void)loadCategoryData
{
    // 显示指示器
    [SVProgressHUD show];
    // 发送请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//        YRHLog(@"----");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏hud
        [SVProgressHUD dismiss];
        // 解析服务器返回的JSON数据
        self.categories = [YRHCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [self.leftCategoryTableView reloadData];
        // 默认选中第一行
        [self.leftCategoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self tableView:self.rightUserTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
    }];
    
}

#pragma mark - 加载数据
// 添加刷新控件
- (void)setupRefresh
{
    self.rightUserTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsersData)];
    self.rightUserTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsersData)];
}
// 加载用户数据
- (void)loadNewUsersData
{
    YRHCategory *c = YRHSelectedCategory;
    // 设置当前页码为1
    c.currentPage = 1;
    // 设置请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(c.id);
    parameters[@"page"] = @(c.currentPage);
    self.parameters = parameters;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组转成模型数组
        NSArray *users = [YRHUserCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 清除所有旧数据
        [c.users removeAllObjects];
        // 将请求到的数据赋值给对应的模型
        [c.users addObjectsFromArray:users];
        // 保存user总数
        c.total = [responseObject[@"total"] integerValue];
        // 参数不一致,这次请求回来的数据不是最新点击应该请求回来的数据
        if (self.parameters != parameters) return;
        // 刷新右边的表格
        [self.rightUserTableView reloadData];
        // 结束刷新
        [self.rightUserTableView.mj_header endRefreshing];
        // 让底部控件结束刷新
        [self checkOutFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters != parameters) {
            return;
        }
        YRHLog(@"数据加载失败");
        // 底部控件结束刷新
        [self.rightUserTableView.mj_footer endRefreshing];
    }];
}

- (void)loadMoreUsersData
{
    YRHCategory *c = YRHSelectedCategory;
    // 设置请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(c.id);
    parameters[@"page"] = @(++c.currentPage);
    self.parameters = parameters;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [YRHUserCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 将数据添加到当前类别对应的用户数组中
        [c.users addObjectsFromArray:users];
        if (self.parameters != parameters) {
            return;
        }
        // 刷新表格
        [self.rightUserTableView reloadData];
        // 让底部控件结束刷新
        [self checkOutFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters != parameters) {
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        [self.rightUserTableView.mj_footer endRefreshing];
        
    }];
}
// 时刻监测footer的状态
- (void)checkOutFooterState
{
    YRHCategory *rc = YRHSelectedCategory;
    // 每次刷新右边的数据时,都控制footer的隐藏或显示
    self.rightUserTableView.mj_footer.hidden = (rc.users.count == 0);// 没有数据就隐藏
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) {
        // 数据已经加载完毕
        [self.rightUserTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        // 还没有加载完
        [self.rightUserTableView.mj_footer endRefreshing];
    }
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftCategoryTableView) {
        return self.categories.count;
    } else {
        [self checkOutFooterState];
        YRHCategory *c = self.categories[self.leftCategoryTableView.indexPathForSelectedRow.row];
        return c.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftCategoryTableView) {
        YRHRecommandCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryID];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else {
        YRHUserViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UserID];
        YRHCategory *c = self.categories[self.leftCategoryTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        return cell;
    }
}

#pragma mark - 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.rightUserTableView.mj_header endRefreshing];
    [self.rightUserTableView.mj_footer endRefreshing];
    YRHCategory *category = self.categories[indexPath.row];
    if (category.users.count > 0) {
        // 显示已经加载的数据
        [self.rightUserTableView reloadData];
    } else {
        // 刷新表格:马上显示当前的数据,不让用户看到上一个category的数据残留
        [self.rightUserTableView reloadData];
        // 开始下拉刷新
        [self.rightUserTableView.mj_header beginRefreshing];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftCategoryTableView) {
        return 35;
    } else {
        return 65;
    }
}

- (void)dealloc
{
    // 控制器销毁,取消所有操作
    [self.manager.operationQueue cancelAllOperations];
}















@end
