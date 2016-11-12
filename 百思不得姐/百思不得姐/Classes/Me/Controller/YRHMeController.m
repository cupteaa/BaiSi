//
//  YRHMeController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHMeController.h"

@interface YRHMeController ()

@end

@implementation YRHMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlighedImage:@"mine-setting-icon-click" targer:self action:@selector(setting)];
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlighedImage:@"mine-moon-icon-click" targer:self action:@selector(moon)];

    self.navigationItem.rightBarButtonItems = @[item1, item2];

}

- (void)setting
{
    YRHLogFunc;
}

- (void)moon
{
    YRHLogFunc;
}

@end
