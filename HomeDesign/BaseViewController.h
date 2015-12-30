//
//  BaseViewController.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "GiFHUD.h"

@interface BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic)NSInteger currentPage;
@property (nonatomic)NSInteger count;
@property (nonatomic)NSInteger start;

@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoading;

@property (nonatomic,copy)NSString *type;

@property (nonatomic)UITableView *tableView;

@property (nonatomic)id model;
@property (nonatomic)NSString *customNibName;
@property (nonatomic)NSInteger rowHeight;
@property (nonatomic)NSInteger varibleHeight;

@property (nonatomic)NSString *requestUrl;

- (void)createDataSource;

- (void)firstLoad;

@end
