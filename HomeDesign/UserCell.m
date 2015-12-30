//
//  UserCell.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "UserCell.h"
#import "NSString+Size.h"
#import "NSString+TimeValue.h"
@implementation UserCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.icon = [[UIImageView alloc]init];
        self.icon.clipsToBounds = YES;
        self.icon.layer.cornerRadius = 15;
        
        self.name = [[UILabel alloc]init];
        self.name.font = [UIFont systemFontOfSize:12];
        self.name.textColor = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.8];
        
        self.time = [[UILabel alloc]init];
        self.time.font = [UIFont systemFontOfSize: 11];
    
        self.content = [[UILabel alloc]init];
        self.content.numberOfLines=0;
        self.content.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.content];
    }
    return self;
}

- (void)updateFrameWith:(UserCellFrame *)frame{
    
    [self.icon setImage:[UIImage imageNamed:@"user_header2.jpg"]];
    self.icon.frame = frame.iconRect;
    
    self.name.text = @"匿名用户";
    self.name.frame = frame.nameRect;
    
    self.time.text = [NSString timeValue:frame.commModel.data];
    self.time.frame = frame.timeRect;
    
    self.content.text = frame.commModel.content;
    self.content.frame = frame.contentRect;
    
    //self.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(self.content.frame));
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
