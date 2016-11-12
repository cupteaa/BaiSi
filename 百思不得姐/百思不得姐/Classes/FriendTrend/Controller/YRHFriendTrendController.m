//
//  YRHFriendTrendController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHFriendTrendController.h"
#import "YRHRecommandViewController.h"

@interface YRHFriendTrendController ()

@end

@implementation YRHFriendTrendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlighedImage:@"friendsRecommentIcon-click" targer:self action:@selector(btnClick)];
}

- (void)btnClick
{
    YRHRecommandViewController *vc = [[YRHRecommandViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
