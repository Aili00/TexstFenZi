//
//  HomeDetailCell.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "HomeDetailCell.h"

@implementation HomeDetailCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier index:(NSInteger)index{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle]loadNibNamed:@"HomeDetailCell" owner:self options:nil][index];
    }
    return self;
}

- (void)updataCellWithName:(NSString *)name imageUrl:(NSString *)url index:(NSInteger)index{
    
    if (index) {
        [self.otherImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }else{
        [self.firstImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.name.text = name;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if (selected) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.name.backgroundColor = [UIColor lightGrayColor];
        self.topLine.backgroundColor = [UIColor lightGrayColor];
        self.leftLine.backgroundColor = [UIColor lightGrayColor];
        self.rightLine.backgroundColor = [UIColor lightGrayColor];
        
    }
}

@end
