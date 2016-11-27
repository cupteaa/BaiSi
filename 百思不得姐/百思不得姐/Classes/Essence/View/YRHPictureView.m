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
#import "YRHProgressView.h"
#import "YRHShowPictureViewController.h"

@interface YRHPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *isGifView;
@property (weak, nonatomic) IBOutlet UIButton *seeFullPictureBtn;
/** progress view */
@property (weak, nonatomic) IBOutlet YRHProgressView *progressView;
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
    // 为图片添加点击手势
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    YRHShowPictureViewController *vc = [[YRHShowPictureViewController alloc] init];
    vc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController: vc animated:YES completion:nil];
}

- (void)setTopic:(YRHTopic *)topic
{
    _topic = topic;
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        if (topic.isBigPicure == NO) return;
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureFrame.size, YES, 0.0);
        // 将下载完的image对象绘制到图形上下文中
        CGFloat width = topic.pictureFrame.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        // 关闭上下文
        UIGraphicsEndImageContext();
    }];
    self.isGifView.hidden = !topic.is_gif;
    self.seeFullPictureBtn.hidden = !topic.isBigPicure;
    if (topic.isBigPicure) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    
}

- (IBAction)btnClick:(id)sender {
    [self showPicture];
}













@end
