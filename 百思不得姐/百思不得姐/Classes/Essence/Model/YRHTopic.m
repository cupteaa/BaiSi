//
//  YRHTopic.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHTopic.h"
#import <MJExtension/MJExtension.h>

@implementation YRHTopic
{
    CGFloat _cellHeight;
    CGRect _pictureFrame;
    CGRect _voiceFrame;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake(YRHScreenW - 4 * YRHTopicCellMargin, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil].size.height;
        _cellHeight = YRHTopicTextY + textH + 2 * YRHTopicCellMargin + YRHTopicBottomBarH;
        if (self.type == YRHTopicTypePicture) { // 图片帖子
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
        } else if (self.type == YRHTopicTypeSound) { // 声音帖子
            CGFloat voiceX = YRHTopicCellMargin;
            CGFloat voiceY = YRHTitlesViewY + textH + YRHTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = self.height * voiceW / self.width;
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + YRHTopicCellMargin;
        } else if (self.type == YRHTopicTypeVideo) { // 视频
            CGFloat videoX = YRHTopicCellMargin;
            CGFloat videoY = YRHTitlesViewY + textH + YRHTopicCellMargin;
            CGFloat videoH;
            CGFloat videoW;
            if (self.height > self.width) {
                videoH = YRHScreenH * 0.5;
                videoW = self.width * (videoH / self.height);
            } else {
                videoW = maxSize.width;
                videoH = self.height * videoW / self.width;
            }
            _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + YRHTopicCellMargin;
        }
    }
    return _cellHeight;
}



@end
