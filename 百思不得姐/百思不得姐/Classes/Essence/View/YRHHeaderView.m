//
//  YRHHeaderView.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHHeaderView.h"

@interface YRHHeaderView ()
/** label */
@property (nonatomic,weak) UILabel *label;
@end

@implementation YRHHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *HeaderID = @"HeaderID";
    YRHHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
    if (!header) {
        header = [[YRHHeaderView alloc] initWithReuseIdentifier:HeaderID];
    }
    return header;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加label
        UILabel *label = [[UILabel alloc] init];
        label.x = YRHTopicCellMargin;
        label.width = 200;
        [self.contentView addSubview:label];
        label.textColor = [UIColor purpleColor];
        label.font = [UIFont systemFontOfSize:14.0];
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text = title;
}


@end
