//
//  ReuseViewController.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiyModel.h"

@protocol pushDelegate <NSObject>

- (void)pushNextView:(Esarray *)model;

@end

@interface ReuseViewController : UITableViewController

@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *type;

@property (nonatomic)id<pushDelegate> delegate;

- (instancetype)initWithType:(NSString *)type;

- (void)firstLoad;

- (void)loadFromSever;

@end
