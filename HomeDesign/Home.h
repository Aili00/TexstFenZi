//
//  Home.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
@interface Home : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverPhoto;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;

- (void)updataForCell:(AppModel *)model;
@end
