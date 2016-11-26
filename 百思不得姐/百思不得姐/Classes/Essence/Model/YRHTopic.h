//
//  YRHTopic.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRHTopic : NSObject
/** 正文 */
@property (nonatomic,copy) NSString *text;
/** name */
@property (nonatomic,copy) NSString *name;
/** image url */
@property (nonatomic,copy) NSString *profile_image;
/** create time */
@property (nonatomic,copy) NSString *create_time;
/** love */
@property (nonatomic,assign) NSInteger love;
/** hate */
@property (nonatomic,assign) NSInteger hate;
/** repost count */
@property (nonatomic,assign) NSInteger repost;
/** comment count */
@property (nonatomic,assign) NSInteger comment;


// 图片相关
/** 图片高度 */
@property (nonatomic,assign) CGFloat height;
/** 图片宽度 */
@property (nonatomic,assign) CGFloat width;
/** url */
@property (nonatomic,copy) NSString *image0;
/** is gif */
@property (nonatomic,assign, getter=isGif) NSInteger is_gif;
/** 帖子类型 */
@property (nonatomic,assign) YRHTopicType type;

// 额外辅助属性
/** cell height */
@property (nonatomic,assign, readonly) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic,assign, readonly) CGRect pictureFrame;
/** is big picture */
@property (nonatomic,assign, getter=isBigPicure) BOOL bigPicture;










@end
