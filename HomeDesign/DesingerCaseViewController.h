//
//  DesingerCaseViewController.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/17.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerModel.h"
#import "CaseModel.h"
#import "BaseViewController.h"

@interface DesingerCaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic)NSInteger currentPage;
@property (nonatomic)NSInteger count;
@property (nonatomic)NSInteger start;

@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoading;

@property (nonatomic,copy)NSString *type;

@property (nonatomic)UITableView *tableView;

@property (nonatomic,strong)Professionals *prodession;

@property (nonatomic,strong)CaseModel *model;

@end
