//
//  YRHPictureView.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHPictureView.h"
#import "YRHTopic.h"
#import <UIImageView+WebCache.h>

@interface YRHPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *isGifView;
@property (weak, nonatomic) IBOutlet UIButton *seeFullPictureBtn;
@end

@implementation YRHPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(YRHTopic *)topic
{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0]];
    self.isGifView.hidden = !topic.is_gif;
    self.seeFullPictureBtn.hidden = !topic.isBigPicure;
    if (topic.isBigPicure) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    
}


@end
