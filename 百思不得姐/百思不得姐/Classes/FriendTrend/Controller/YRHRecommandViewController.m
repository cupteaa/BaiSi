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

#import "YRHRecommandCategoryCell.h"

#import "YRHCategory.h"
#import "YRHUserCategory.h"
#import "YRHUserViewCell.h"

@interface YRHRecommandViewController ()<UITableViewDelegate,UITableViewDataSource>
// 左侧tableview
@property (weak, nonatomic) IBOutlet UITableView *leftCategoryTableView;
/** 存储右侧请求的数据 */
@property (nonatomic,strong) NSArray *categories;
// 右侧tableview
@property (weak, nonatomic) IBOutlet UITableView *rightUserTableView;
/** 存储右侧请求的数据 */
@property (nonatomic,strong) NSArray *users;

@end

@implementation YRHRecommandViewController

static NSString * const CategoryID = @"category";
static NSString * const UserID = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
    
    self.leftCategoryTableView.delegate = self;
    self.leftCategoryTableView.dataSource = self;
    
    self.rightUserTableView.delegate = self;
    self.rightUserTableView.dataSource = self;
    
    // 注册cell
    [self.leftCategoryTableView registerNib:[UINib nibWithNibName:@"YRHRecommandCategoryCell" bundle:nil] forCellReuseIdentifier: CategoryID];
    [self.rightUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YRHUserViewCell class]) bundle:nil] forCellReuseIdentifier:UserID];
    
    // 右侧tableview的内边距
    self.rightUserTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)setupUI
{
    self.title = @"推荐关注";
    // 背景色
    self.view.backgroundColor = YRHGlobalBg;
}
- (void)loadData
{
    // 显示指示器
    [SVProgressHUD show];
    // 发送请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
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



#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftCategoryTableView) {
        return self.categories.count;
    } else {
        return self.users.count;
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
        cell.user = self.users[indexPath.row];
        return cell;
    }
}

#pragma mark - 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YRHCategory *category = self.categories[indexPath.row];
    // 选中了某一行,请求这行的user数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(category.id);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.users = [YRHUserCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新右边的表格
        [self.rightUserTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YRHLog(@"数据加载失败");
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftCategoryTableView) {
        return 35;
    } else {
        return 65;
    }
}















@end
