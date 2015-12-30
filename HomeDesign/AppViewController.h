//
//  AppViewController.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSString *type;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSString *requestUrl;
@property (nonatomic) UITableView *tableView;

@property (nonatomic) BOOL isRefreshing;
@property (nonatomic) BOOL isLoading;

- (void)firstLoad;
- (void)fetchData;
@end
