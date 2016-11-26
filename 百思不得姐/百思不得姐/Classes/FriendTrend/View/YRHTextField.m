//
//  YRHTextField.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHTextField.h"

@implementation YRHTextField

static NSString * const YRHPlaceHolderColorKeyPath = @"_placeholderLabel.textColor";


- (void)drawPlaceholderInRect:(CGRect)rect
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    attrs[NSFontAttributeName] = self.font;
    [self.placeholder drawInRect:CGRectMake(0, 13, rect.size.width, 25) withAttributes:attrs];
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    //设置光标颜色与文字颜色一致
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
}

// 当前文本框聚焦时就会调用
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:YRHPlaceHolderColorKeyPath];
    return [super becomeFirstResponder];
}

// 当前文本框失去焦点的时候调用
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:YRHPlaceHolderColorKeyPath];
    return [super resignFirstResponder];
}













@end
