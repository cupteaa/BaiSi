//
//  YRHVoiceView.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRHTopic;
@interface YRHVoiceView : UIView
/** topic */
@property (nonatomic,strong) YRHTopic *topic;
+ (instancetype)voiceView;

@end
