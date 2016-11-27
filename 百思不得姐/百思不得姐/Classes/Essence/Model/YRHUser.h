//
//  YRHUser.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRHUser : NSObject

/** username */
@property (nonatomic,copy) NSString *username;
/** sex */
@property (nonatomic,copy) NSString *sex;
/** icon */
@property (nonatomic,copy) NSString *profile_image;
/** personal page */
@property (nonatomic,copy) NSString *personal_page;
/** like count */
@property (nonatomic,assign) NSInteger total_cmt_like_count;
/** is vip */
@property (nonatomic,assign) BOOL is_vip;

@end
