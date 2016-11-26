//
//  YRHVerticalButton.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHVerticalButton.h"

@implementation YRHVerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
