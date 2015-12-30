//
//  DesignerCell.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "DesignerCell.h"
#import "UIImageView+WebCache.h"
@implementation DesignerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.icon.clipsToBounds = YES;
    self.icon.layer.cornerRadius = 25;
}

- (void)updateWithData:(Professionals *)model{
    
   // NSLog(@"model=%@",model);
   // NSLog(@"userimage:%@",model.userImage.medium);
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.userImage.medium] placeholderImage:[UIImage imageNamed:@"user_header1"]];
    self.name.text = model.realName;
    
    NSString *sex=@"女";
    if (model.sex) {
        sex = @"男";
    }
    self.detail.text = [NSString stringWithFormat:@"%@ |%@ |案例 %ld",model.city,sex,model.projectNum];
    
    self.about.text = model.about;
}
@end
