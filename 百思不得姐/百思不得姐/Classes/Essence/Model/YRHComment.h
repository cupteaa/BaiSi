//
//  YRHComment.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YRHUser;
@interface YRHComment : NSObject
/** 评论内容 */
@property (nonatomic,copy) NSString *content;
/** like count */
@property (nonatomic,copy) NSString *like_count;
/** voice time */
@property (nonatomic,assign) NSInteger voicetime;
/** user */
@property (nonatomic,strong) YRHUser *user;
/** id */
@property (nonatomic,copy) NSString *ID;


// 额外辅助属性
/** cell height */
@property (nonatomic,assign, readonly) CGFloat cellHeight;
@end
