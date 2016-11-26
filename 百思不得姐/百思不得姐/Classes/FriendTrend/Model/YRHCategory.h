//
//  YRHCategory.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRHCategory : NSObject

/** id */
@property (nonatomic,assign) NSInteger id;
/** count */
@property (nonatomic,assign) NSInteger count;
/** name */
@property (nonatomic,copy) NSString *name;
/** users */
@property (nonatomic,strong) NSMutableArray *users;
/** user总数 */
@property (nonatomic,assign) NSInteger total;
/** current page */
@property (nonatomic,assign) NSInteger currentPage;


@end
