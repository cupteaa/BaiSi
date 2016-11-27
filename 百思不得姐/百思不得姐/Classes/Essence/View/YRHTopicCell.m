//
//  YRHTopicCell.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHTopicCell.h"
#import "YRHTopic.h"
#import <UIImageView+WebCache.h>
#import "YRHPictureView.h"
#import "YRHVoiceView.h"
#import "YRHVideoView.h"

@interface YRHTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *loveCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *hateCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *repostCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentCountBtn;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** picture view */
@property (nonatomic,weak) YRHPictureView *pictureView;
/** voice view */
@property (nonatomic,weak) YRHVoiceView *voiceView;
/** video view */
@property (nonatomic,weak) YRHVideoView *videoView;


@end

@implementation YRHTopicCell

- (YRHPictureView *)pictureView
{
    if (!_pictureView) {
        YRHPictureView *picture = [YRHPictureView pictureView];
        [self.contentView addSubview:picture];
        _pictureView = picture;
    }
    return _pictureView;
}

- (YRHVoiceView *)voiceView
{
    if (!_voiceView) {
        YRHVoiceView *view = [YRHVoiceView voiceView];
        [self.contentView addSubview:view];
        _voiceView = view;
    }
    return _voiceView;
}

- (YRHVideoView *)videoView
{
    if (!_videoView) {
        YRHVideoView *videoView = [YRHVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}


- (void)setTopic:(YRHTopic *)topic
{
    _topic = topic;
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    self.text_label.text = topic.text;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image]];
    
    [self setupButtonTitle:self.loveCountBtn count:topic.love placeholder:@"顶"];
    [self setupButtonTitle:self.hateCountBtn count:topic.hate placeholder:@"踩"];
    [self setupButtonTitle:self.repostCountBtn count:topic.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commentCountBtn count:topic.comment placeholder:@"评论"];
    self.pictureView.hidden = YES;
    self.voiceView.hidden = YES;
    self.videoView.hidden = YES;
    if (topic.type == YRHTopicTypePicture) { // 图片
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureFrame;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == YRHTopicTypeSound) { // 声音
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceFrame;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == YRHTopicTypeVideo) { // 视频
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoFrame;
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }
}

- (void)setupButtonTitle:(UIButton *)btn count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count >= 10000) {
        placeholder = [NSString stringWithFormat:@"%ld万", count / 10000];
    } else {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [btn setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    [super setFrame:frame];
    
}


















@end
