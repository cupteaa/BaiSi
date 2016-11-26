//
//  YRHTopic.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHTopic.h"

@implementation YRHTopic
{
    CGFloat _cellHeight;
    CGRect _pictureFrame;
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * YRHTopicCellMargin, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0]} context:nil].size.height;
        _cellHeight = YRHTopicTextY + textH + 2 * YRHTopicCellMargin + YRHTopicBottomBarH;
        if (self.type == YRHTopicTypePicture) {
            // 计算图片的高度
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = self.height * pictureW / self.width; // 实际高度
            if (pictureH > YRHTopicCellPictureMaxH) {
                pictureH = YRHTopicCellPictureBreakH;
                self.bigPicture = YES;
            }
            // 计算图片控件的frame
            CGFloat pictureX = YRHTopicCellMargin;
            CGFloat picutreY = YRHTitlesViewY + textH + YRHTopicCellMargin;
            _pictureFrame = CGRectMake(pictureX, picutreY, pictureW, pictureH);
            _cellHeight += pictureH + YRHTopicCellMargin;
        } else if (self.type == YRHTopicTypeSound) {
            
        }
    }
    return _cellHeight;
}



@end
