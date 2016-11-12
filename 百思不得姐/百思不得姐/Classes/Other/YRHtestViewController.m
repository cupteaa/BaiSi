//
//  YRHtestViewController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHtestViewController.h"

@interface YRHtestViewController ()

@end

@implementation YRHtestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"test";
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = YRHRGBColor(200, 50, 30);
    [self.navigationController pushViewController:vc animated:YES];
}



@end
