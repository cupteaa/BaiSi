//
//  YRHCommentCell.h
//  百思不得姐
//
//  Created by 于亚伟 on 2016/11/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRHComment;
@interface YRHCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
/** comment */
@property (nonatomic,strong) YRHComment *comment;
@end
