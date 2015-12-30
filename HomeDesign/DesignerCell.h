//
//  DesignerCell.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerModel.h"

@interface DesignerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *detail;

@property (weak, nonatomic) IBOutlet UILabel *about;

- (void)updateWithData:(Professionals *)model;

@end
