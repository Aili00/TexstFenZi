//
//  CaseCell.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/17.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "CaseCell.h"
#import "UIImageView+WebCache.h"
#import "Define.h"
@implementation CaseCell

- (void)awakeFromNib {
    // Initialization code
    
    self.caseImage.clipsToBounds = YES;
    self.caseImage.layer.cornerRadius = 8;
    self.about.numberOfLines=0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    self.icon.clipsToBounds = YES;
//    self.icon.layer.cornerRadius = 34;
//    
//    self.detail.frame = CGRectMake(0, CGRectGetMaxY(self.icon.frame)+20, kScreenWidth, 40);
//    
//    self.about.numberOfLines=0;
//}

- (void)updateWithData:(Projects *)projects{
    
    NSString *url = [NSString stringWithFormat:kHomeImageUrl,projects.coverPhoto];
    [self.caseImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"diy_placeholder.jpg"]];

    self.about.text = projects.title;
    self.detail.text = [NSString stringWithFormat:@"%@•%@平米•%@万元",projects.styleShow,projects.areaShow,projects.costShow];
    
    self.likeNum.text = [NSString stringWithFormat:@"%ld",projects.likeNum];
   
}
@end
