//
//  YRHCommentCell.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHCommentCell.h"
#import "YRHComment.h"
#import "YRHUser.h"


#import <UIImageView+WebCache.h>

@interface YRHCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentVoiceBtn;

@end

@implementation YRHCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setComment:(YRHComment *)comment
{
    _comment = comment;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image]];
    self.nameLabel.text = comment.user.username;
    self.likeCountLabel.text = comment.like_count;
    if (comment.voicetime == 0) {
        self.commentVoiceBtn.hidden = YES;
        self.commentTextLabel.hidden = NO;
        self.commentTextLabel.text = comment.content;
    } else {
        self.commentTextLabel.hidden = YES;
        self.commentVoiceBtn.hidden = NO;
        [self.commentVoiceBtn setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }
    if ([comment.user.sex isEqualToString:@"m"]) {
        self.sexImage.image = [UIImage imageNamed:@"Profile_manIcon"];
    } else {
        self.sexImage.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    frame.origin.x = margin;
//    frame.origin.y += margin;
    frame.size.width -= 2 * margin;
//    frame.size.height -= margin;
    [super setFrame:frame];
}
- (IBAction)likeBtnClick:(id)sender {
    self.likeBtn.selected = YES;
}










@end
