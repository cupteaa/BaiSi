//
//  YRHRecommandCategoryCell.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHRecommandCategoryCell.h"
#import "YRHCategory.h"

@interface YRHRecommandCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *selectedFlag;

@end

@implementation YRHRecommandCategoryCell

- (void)setCategory:(YRHCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = YRHRGBColor(244, 244, 244);
    self.selectedFlag.backgroundColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedFlag.hidden = !selected;
    self.selectedFlag.backgroundColor = [UIColor redColor];

    self.textLabel.textColor = selected ? [UIColor redColor] : YRHRGBColor(78, 78, 78);
}














@end
