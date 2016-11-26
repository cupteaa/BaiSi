//
//  YRHRecommandTag.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRHRecommandTag : NSObject
/** name */
@property (nonatomic,copy) NSString *theme_name;
/** icon */
@property (nonatomic,copy) NSString *image_list;
/** count */
@property (nonatomic,assign) NSInteger sub_number;

@end
