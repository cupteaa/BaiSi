//
//  YRHRegisterController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHRegisterController.h"

@interface YRHRegisterController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation YRHRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 退出注册界面
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 注册帐号
- (IBAction)registCount:(UIButton *)button {
    if (self.leftMargin.constant == 0) {
        self.leftMargin.constant = -self.view.width;
        button.selected = YES;
    } else {
        self.leftMargin.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


















@end
