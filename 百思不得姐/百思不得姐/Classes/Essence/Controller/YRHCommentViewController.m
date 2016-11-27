//
//  YRHCommentViewController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHCommentViewController.h"
#import "YRHTopicCell.h"
#import "YRHTopic.h"
#import "YRHComment.h"
#import "YRHHeaderView.h"
#import "YRHCommentCell.h"

#import <AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD.h>

@interface YRHCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *commentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
/** 热门评论 */
@property (nonatomic,strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic,strong) NSMutableArray *latestComments;
/** manager */
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** current page */
@property (nonatomic,assign) NSInteger page;
@end

@implementation YRHCommentViewController

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)latestComments
{
    if (!_latestComments) {
        _latestComments = [NSMutableArray array];
    }
    return _latestComments;
}
#pragma mark - 系统回调函数
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setupBasic];
    [self setupHeader];
    [self setupRefresh];
    
}


static NSString * const CommentId = @"comment";
- (void)setupBasic
{
    self.title = @"评论";
    self.tableView.contentInset = UIEdgeInsetsMake(YRHNavgationBarH, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(YRHNavgationBarH + 20, 0, 0, 0);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlighedImage:@"comment_nav_item_share_icon_click" targer:self action:@selector(share)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // cell的高度
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YRHCommentCell class]) bundle:nil] forCellReuseIdentifier:CommentId];
}

#pragma mark - tableView头部内容
- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];
    
    YRHTopicCell *cell = [YRHTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(YRHScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    header.height = YRHTopicCellMargin + self.topic.cellHeight;
    self.tableView.tableHeaderView = header;
}
#pragma mark - 数据刷新
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadCommentData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
//    YRHLog(@"%@",note.userInfo);
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部的约束
    self.bottomMargin.constant = YRHScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 取消所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
}
#pragma mark - 加载评论数据
- (void)loadCommentData
{
    // 取消之前所有的加载请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.hotComments = [YRHComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [YRHComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.page = 1;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        // 控制footer的状态
        NSInteger totalCount = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= totalCount) { // 评论加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreComments
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.page + 1;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @"1";
    parameters[@"page"] = @(page);
    YRHComment *lastComment = [self.latestComments lastObject];
    parameters[@"lastcid"] = lastComment.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *newsComments = [YRHComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newsComments];
        self.page = page;
        [self.tableView reloadData];
        NSInteger totalCount = [responseObject[@"total"] integerValue];
        if (self.latestComments.count + self.hotComments.count >= totalCount) {
            self.tableView.mj_footer.hidden = YES;
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    self.tableView.mj_footer.hidden = (latestCount == 0);
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YRHCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentId];
    YRHComment *comment = [self commentAtIndexPath:indexPath];
    cell.comment = comment;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YRHComment *comment = [self commentAtIndexPath:indexPath];
    return comment.cellHeight;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    return @"最新评论";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YRHHeaderView *header = [YRHHeaderView headerViewWithTableView:tableView];
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (YRHComment *)commentAtIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}


#pragma mark - <UITableViewDelegate>

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YRHCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 弹出action sheet
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *likeBtn = [UIAlertAction actionWithTitle:@"赞" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cell.likeBtn.selected = YES;
    }];
    UIAlertAction *replyBtn = [UIAlertAction actionWithTitle:@"回复" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.commentLabel becomeFirstResponder];
    }];
    UIAlertAction *jubaoBtn = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showSuccessWithStatus:@"举报成功,我们会尽快处理"];
    }];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [likeBtn setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [replyBtn setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [jubaoBtn setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [cancelBtn setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertVc addAction:likeBtn];
    [alertVc addAction:replyBtn];
    [alertVc addAction:jubaoBtn];
    [alertVc addAction:cancelBtn];

    [self.navigationController presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - 按钮点击事件
- (void)share
{
    YRHLogFunc;
}
- (IBAction)voiceButton:(id)sender {
    
}
- (IBAction)atSomebodyButton:(id)sender {
    
}
@end
