//
//  YRHTabBarController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHTabBarController.h"

#import "YRHEssenceController.h"
#import "YRHNewController.h"
#import "YRHFriendTrendController.h"
#import "YRHMeController.h"

#import "YRHTabBar.h"

#import "YRHNavigationController.h"
#import "YRHTopicViewController.h"

@interface YRHTabBarController ()

/** vc */
@property (nonatomic,weak) UIViewController *vc;

@end

@implementation YRHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVcs];
}

- (void)setupChildVcs
{
    // 设置文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    // 精华
    UIViewController *vc1 = [[YRHEssenceController alloc] init];
    [self setTabBarItemWithTabBarController:vc1 Title:@"精华" image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];
    // 新帖
    UIViewController *vc2 = [[YRHNewController alloc] init];
    [self setTabBarItemWithTabBarController:vc2 Title:@"新帖" image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    // 关注
    UIViewController *vc3 = [[YRHFriendTrendController alloc] init];
    [self setTabBarItemWithTabBarController:vc3 Title:@"关注" image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    // 我
    UIViewController *vc4 = [[YRHMeController alloc] init];
    [self setTabBarItemWithTabBarController:vc4 Title:@"我" image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
    
    // 替换tabbar
    [self setValue:[[YRHTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (void)setTabBarItemWithTabBarController:(UIViewController *)vc Title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    // 包装一个导航控制器
    YRHNavigationController *nav = [[YRHNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}














@end
