//
//  DiyCell.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "DiyCell.h"
#import "Define.h"
@implementation DiyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    self.thumbImageView.clipsToBounds=YES;
    self.thumbImageView.layer.cornerRadius = 8;
}

- (void)updateWithModel:(Esarray *)model{
    
    NSURL *url = [NSURL URLWithString:model.thumb];
    [self.thumbImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"diy_placeholder.jpg"]];
   // self.thumbImageView.frame = CGRectMake(8, 8, self.frame.size.width-16,160);
   
   
    self.titleLabel.text = model.title;
    
    self.desLabel.text = model.theDescription;
    
    self.comments.text = [NSString stringWithFormat:@"%ld",[model.comments count]];
    
    self.favs.text = [NSString stringWithFormat:@"%ld",model.favs];
    
}
@end
