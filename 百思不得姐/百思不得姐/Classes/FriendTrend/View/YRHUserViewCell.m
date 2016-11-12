//
//  YRHUserViewCell.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHUserViewCell.h"
#import "YRHUserCategory.h"
#import <UIImageView+WebCache.h>

@interface YRHUserViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *funCount;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@end

@implementation YRHUserViewCell

- (void)setUser:(YRHUserCategory *)user
{
    _user = user;
    self.name.text = user.screen_name;
    self.funCount.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.header sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
