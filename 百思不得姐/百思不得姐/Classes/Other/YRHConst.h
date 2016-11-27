//
//  YRHConst.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YRHTopicTypeAll = 1,
    YRHTopicTypeVideo = 41,
    YRHTopicTypeSound = 31,
    YRHTopicTypePicture = 10,
    YRHTopicTypeWord = 29
}YRHTopicType;

extern CGFloat const YRHTitlesViewH;
extern CGFloat const YRHTitlesViewY;
extern CGFloat const YRHNavgationBarH;

// 精华 间隔
extern CGFloat const YRHTopicCellMargin;
// 精华 底部按钮高度
extern CGFloat const YRHTopicBottomBarH;
// 精华 正文的y值
extern CGFloat const YRHTopicTextY;
// 图片帖子 长度超过1000为大图
extern CGFloat const YRHTopicCellPictureMaxH;
// 大图显示的高度
extern CGFloat const YRHTopicCellPictureBreakH;

// tabbar被选中的通知的名字
extern NSString * const YRHTabBarDidSelectedNotificationName;
