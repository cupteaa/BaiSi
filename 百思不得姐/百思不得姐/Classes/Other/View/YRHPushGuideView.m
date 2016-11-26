//
//  YRHPushGuideView.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHPushGuideView.h"

@implementation YRHPushGuideView

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    // 获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获取沙盒中的版本号
    NSString *sandBoxVersion = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    // 两个版本号不一致,显示引导页面
    if (![currentVersion isEqualToString:sandBoxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        YRHPushGuideView *pushView = [YRHPushGuideView guideView];
        pushView.frame = window.bounds;
        [window addSubview:pushView];
        // 保存新的版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// 创建view的快速方法
+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (IBAction)close:(id)sender {
    
    [self removeFromSuperview];
}

@end
