//
//  UIBarButtonItem+YRHBarButtonItem.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIBarButtonItem+YRHBarButtonItem.h"

@implementation UIBarButtonItem (YRHBarButtonItem)
+ (instancetype)itemWithImage:(NSString *)image highlighedImage:(NSString *)highlighedImage targer:(id)targer action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlighedImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:targer action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}
@end
