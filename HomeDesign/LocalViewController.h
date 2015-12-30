//
//  LocalViewController.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  PassCity <NSObject>

- (void)refreshCity:(NSString *)city;

@end

@interface LocalViewController : UITableViewController

@property (nonatomic, strong) NSMutableDictionary *cities;

@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;


@property (nonatomic)id<PassCity> delegate;

@end
