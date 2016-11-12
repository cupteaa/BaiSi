//
//  YRHNewController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHNewController.h"

@interface YRHNewController ()

@end

@implementation YRHNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlighedImage:@"MainTagSubIconClick" targer:self action:@selector(btnClick)];
    
}
- (void)btnClick
{
    YRHLogFunc;
}



@end
