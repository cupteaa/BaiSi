//
//  YRHVoiceView.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHVoiceView.h"
#import "YRHTopic.h"
#import <UIImageView+WebCache.h>

@interface YRHVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceLengthLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@end

@implementation YRHVoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(YRHTopic *)topic
{
    _topic = topic;
    // image
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0]];
    // play count
    self.playCountLabel.text = [NSString stringWithFormat:@"播放%zd次",topic.playcount];
    NSInteger min = topic.voicetime / 60;
    NSInteger sec = topic.voicetime % 60;
    self.voiceLengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
}
- (IBAction)playVoice:(id)sender {
}

@end
