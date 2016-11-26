//
//  YRHEssenceController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHEssenceController.h"
#import "YRHtestViewController.h"
#import "YRHRecommandTagController.h"

#import "YRHTopicViewController.h"

@interface YRHEssenceController ()<UIScrollViewDelegate>
/** indicator */
@property (nonatomic,weak) UIView *indicator;
/** current selected btn */
@property (nonatomic,weak) UIButton *selectedBtn;

@property (nonatomic,weak) UIView *titlesView;

@property (nonatomic,weak) UIScrollView *contentView;
@end

@implementation YRHEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏信息
    [self setupNavgation];
    // 添加子控制器
    [self setupChildVcs];
    // 设置titleView
    [self setupTitleView];
    
    [self setupScrollView];
    
}

- (void)setupChildVcs
{
    YRHTopicViewController *all = [[YRHTopicViewController alloc] init];
    all.title = @"全部";
    all.type = YRHTopicTypeAll;
    [self addChildViewController:all];
    
    YRHTopicViewController *video = [[YRHTopicViewController alloc] init];
    video.title = @"视频";
    video.type = YRHTopicTypeVideo;
    [self addChildViewController:video];
    
    YRHTopicViewController *picture = [[YRHTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = YRHTopicTypePicture;
    [self addChildViewController:picture];
    
    YRHTopicViewController *word = [[YRHTopicViewController alloc] init];
    word.title = @"段子";
    word.type = YRHTopicTypeWord;
    [self addChildViewController:word];
    
    YRHTopicViewController *voice = [[YRHTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = YRHTopicTypeSound;
    [self addChildViewController:voice];
    
}

- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)setupTitleView
{
    // view的整体
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 64, self.view.width, 35);
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    // 选中指示器
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = titleView.height - indicator.height;
    
    self.indicator = indicator;
    // view内部的标签
    CGFloat btnW = self.view.width / self.childViewControllers.count;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnW, 0, btnW, 35);
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
        // 默认选中第一个按钮
        if (i == 0) {
            btn.enabled = NO;
            self.selectedBtn = btn;
            [btn.titleLabel sizeToFit];
            self.indicator.width = btn.width;
            self.indicator.x = btn.x;
        }
    }
    [titleView addSubview:indicator];
}

- (void)btnClick:(UIButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.width = btn.width;
        self.indicator.x = btn.x;
    }];
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = btn.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}

- (void)setupNavgation
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlighedImage:@"MainTagSubIconClick" targer:self action:@selector(tagClick)];
}

- (void)tagClick
{
    YRHRecommandTagController *tagVc = [[YRHRecommandTagController alloc] init];
    [self.navigationController pushViewController:tagVc animated:YES];
}


#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self btnClick:self.titlesView.subviews[index]];
}




















@end









