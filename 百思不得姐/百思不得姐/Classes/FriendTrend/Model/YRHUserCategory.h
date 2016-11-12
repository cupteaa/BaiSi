//
//  YRHUserCategory.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRHUserCategory : NSObject
/** follow count */
@property (nonatomic,assign) NSInteger fans_count;
/** name */
@property (nonatomic,copy) NSString *screen_name;
/** icon */
@property (nonatomic,strong) NSString *header;
@end
