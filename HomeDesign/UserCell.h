//
//  UserCell.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiyModel.h"
#import "UserCellFrame.h"
@interface UserCell : UITableViewCell
@property (nonatomic)UIImageView *icon;
@property (nonatomic)UILabel *name;
@property (nonatomic)UILabel *time;
@property (nonatomic)UILabel *content;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)updateFrameWith:(UserCellFrame *)frame;

@end
