//
//  HDHeaderView.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/11.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "HDHeaderView.h"
#define GAP 10

@interface HDHeaderView ()

@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *detail;
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel *desLabel;

@end

@implementation HDHeaderView

- (instancetype)initWithModel:(HomeDetailModel *)model{
    if (self = [super init]) {
        
        self.image= [UIImage imageNamed:@"head_bag.jpg"];

        self.title =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20,21)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont boldSystemFontOfSize:17];
        self.title.text = model.title;
        
        CGFloat detailY = CGRectGetMaxY(self.title.frame)+GAP;
        self.detail = [[UILabel alloc]initWithFrame:CGRectMake(10, detailY, kScreenWidth-20, 21)];
        self.detail.text = [NSString stringWithFormat:@"•%@ •%@ -%@",model.typeShow,model.styleShow,model.user.realName];
        self.detail.font = [UIFont systemFontOfSize:16];
        self.detail.textAlignment = NSTextAlignmentCenter;
       
        CGFloat iconY = CGRectGetMaxY(self.detail.frame)+GAP;
        self.icon = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-50)/2, iconY, 50, 50)];
        self.icon.clipsToBounds = YES;
        self.icon.layer.cornerRadius = 25;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:model.user.userImage.large] placeholderImage:[UIImage imageNamed:@"photo"]];
        
        NSString *theDescription = model.taskEnd.projectState.proDescription;
        CGSize desSize = [theDescription boundingRectWithSize:CGSizeMake(kScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        CGFloat desY = CGRectGetMaxY(self.icon.frame)+GAP;
        self.desLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, desY,kScreenWidth-20, desSize.height)];
        self.desLabel.font = [UIFont systemFontOfSize:15];
       // NSLog(@"description:%@",theDescription);
        if ([theDescription isEqualToString:@""]) {
            self.desLabel.text = @"简介:该案例占无简介";
        }else{
            self.desLabel.text = [NSString stringWithFormat:@"简介:%@",theDescription];
            
        }
        
        self.desLabel.numberOfLines = 0;
    
        self.frame = CGRectMake(0, 0, kScreenWidth, desY+desSize.height+GAP);
        
        [self addSubview:self.title];
        [self addSubview:self.detail];
        [self addSubview:self.icon];
        [self addSubview:self.desLabel];
      
    }
    
    return self;
}

@end

