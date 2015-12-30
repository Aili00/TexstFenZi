//
//  DiyCell.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiyModel.h"
@interface DiyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UILabel *favs;

- (void)updateWithModel:(NSDictionary *)model;
@end
