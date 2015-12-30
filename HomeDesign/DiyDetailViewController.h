//
//  DiyDetailViewController.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiyModel.h"


@interface DiyDetailViewController : UITableViewController

@property (nonatomic)Esarray *model;

- (instancetype)initWithModel:(Esarray *)model;

@end
