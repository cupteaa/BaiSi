//
//  YRHRecommandTagCell.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHRecommandTagCell.h"
#import "YRHRecommandTag.h"
#import <UIImageView+WebCache.h>

@interface YRHRecommandTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@end

@implementation YRHRecommandTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommandTag:(YRHRecommandTag *)recommandTag
{
    _recommandTag = recommandTag;
    self.nameLabel.text = recommandTag.theme_name;
    self.countLabel.text = [NSString stringWithFormat:@"%zd人已订阅",recommandTag.sub_number];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:recommandTag.image_list]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
