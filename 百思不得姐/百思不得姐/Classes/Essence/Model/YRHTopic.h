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

// 声音相关
/** 声音背景图片 */
@property (nonatomic,copy) NSString *bimageuri;
/** mp3 url */
@property (nonatomic,copy) NSString *voiceuri;
/** play count */
@property (nonatomic,assign) NSInteger playcount;
/** music length */
@property (nonatomic,assign) NSInteger voicelength;
/** music time */
@property (nonatomic,assign) NSInteger voicetime;

// 视频相关
/** mp4 url */
@property (nonatomic,copy) NSString *videouri;
/** video time */
@property (nonatomic,assign) NSInteger videotime;


// 额外辅助属性
/** cell height */
@property (nonatomic,assign, readonly) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic,assign, readonly) CGRect pictureFrame;
/** is big picture */
@property (nonatomic,assign, getter=isBigPicure) BOOL bigPicture;
/** 图片下载进度 */
@property (nonatomic,assign) CGFloat pictureProgress;
/** 声音图片的尺寸 */
@property (nonatomic,assign, readonly) CGRect voiceFrame;
/** 视频图片的尺寸 */
@property (nonatomic,assign, readonly) CGRect videoFrame;









@end
