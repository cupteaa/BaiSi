//
//  YRHHeaderView.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRHHeaderView : UITableViewHeaderFooterView
/** text */
@property (nonatomic,copy) NSString *title;
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
