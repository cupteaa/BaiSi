//
//  YRHPublishViewController.m
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YRHPublishViewController.h"
#import "YRHVerticalButton.h"

@interface YRHPublishViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation YRHPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupButtons];
}

- (void)setupButtons
{
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    // 6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (YRHScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat margin = (YRHScreenW - maxCols * buttonW - 2 * buttonStartX) / (maxCols - 1);
    for (int i = 0; i < images.count; i++) {
        YRHVerticalButton *btn = [[YRHVerticalButton alloc] init];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置frame
        btn.width = buttonW;
        btn.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        btn.x = buttonStartX + col * buttonW + col * margin;
        btn.y = buttonStartY + row * buttonH;
        [self.view addSubview:btn];
        
    }
}

- (IBAction)cancle:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
