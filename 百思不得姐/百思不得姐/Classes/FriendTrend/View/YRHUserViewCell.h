//
//  YRHUserViewCell.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YRHUserCategory;
@interface YRHUserViewCell : UITableViewCell
/** user */
@property (nonatomic,strong) YRHUserCategory *user;
@end
