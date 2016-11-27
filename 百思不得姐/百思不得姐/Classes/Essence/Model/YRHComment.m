//
//  YRHComment.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHComment.h"

#import <MJExtension/MJExtension.h>

@implementation YRHComment
{
    CGFloat _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

- (CGFloat)cellHeight
{
    CGFloat imageMaxY = 45;
    CGFloat imageW = 35;
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake(YRHScreenW - 3 * YRHTopicCellMargin - imageW, MAXFLOAT);
        CGFloat textH = 0;
        CGFloat voiceBtnH = 0;
        if (self.voicetime == 0) { // 文字评论,计算文字高度
            voiceBtnH = 0;
            textH = [self.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0]} context:nil].size.height;
        } else { // 声音评论
            textH = 0;
            voiceBtnH = 30;
        }
        _cellHeight = imageMaxY + textH + voiceBtnH + 2 * YRHTopicCellMargin;
    }
    return _cellHeight;
}

@end
