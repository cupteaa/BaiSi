//
//  YRHEssenceController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHEssenceController.h"
#import "YRHtestViewController.h"

@interface YRHEssenceController ()

@end

@implementation YRHEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlighedImage:@"MainTagSubIconClick" targer:self action:@selector(btnClick)];
}

- (void)btnClick
{
    YRHLogFunc;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YRHtestViewController *vc = [[YRHtestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
