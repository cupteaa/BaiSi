//
//  YRHTabBar.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//  自定义tabbar 增加中间的发布按钮

#import "YRHTabBar.h"
#import "YRHPublishViewController.h"

@interface YRHTabBar()

/** publish */
@property (nonatomic,weak) UIButton *publishBtn;

@end

@implementation YRHTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.backgroundColor = [UIColor whiteColor];
        self.publishBtn = btn;
    }
    return self;
}

- (void)publishBtnClick
{
    YRHPublishViewController *vc = [[YRHPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

// 布局五个按钮
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 标记按钮是否添加过监听器
    static BOOL added = NO;
    // 设置发布按钮的尺寸
    self.publishBtn.bounds = CGRectMake(0, 0, self.publishBtn.currentBackgroundImage.size.width, self.publishBtn.currentBackgroundImage.size.height);
    self.publishBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    // 设置其他按钮的尺寸
    CGFloat y = 0;
    CGFloat itemW = self.bounds.size.width / 5;
    CGFloat itemH = self.bounds.size.height;
    NSInteger index = 0;
    for (UIControl *btn in self.subviews) {
        if (![btn isKindOfClass:[UIControl class]] || btn == self.publishBtn) {
            continue;
        }
        if (added == NO) {
            [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        }
        // 计算x值
        CGFloat x = itemW * ((index > 1) ? (index + 1) : index);
        btn.frame = CGRectMake(x, y, itemW, itemH);
        index++;
    }
    added = YES;
}

- (void)click
{
    // 发出tabbar被点击的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:YRHTabBarDidSelectedNotificationName object:nil userInfo:nil];
}













@end
