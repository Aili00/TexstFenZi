//
//  BaseViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.data = [[NSMutableArray alloc]init];
   
    [self createUI];
    
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --------------------------
- (void)createUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kNCHeight+self.varibleHeight)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = self.rowHeight;
    
    [_tableView registerNib:[UINib nibWithNibName:self.customNibName bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.isRefreshing = YES;
        self.currentPage = self.start;
        [self fetchData];
        
    }];
    
    self.tableView.header = headerView;
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.start += self.count;
        [self fetchData];
        self.isLoading = YES;
        
    }];
    
    [headerView beginRefreshing];
}

//首次加载
#pragma mark - firstLoad

- (void)firstLoad{
   
    self.start = 0;
    self.isRefreshing = NO;
    self.isLoading = NO;
    
    [self fetchData];
    
}

//请求数据
- (void)fetchData{
    if (![self fetchDataFromLocal]) {
        [self fetchDataFromServer];
    }
}

//本地加载
- (BOOL)fetchDataFromLocal{
    return NO;
}

//网络加载
- (void)fetchDataFromServer{
    
    if (self.isLoading) {
        return;
    }
    
    [NetworkingManager requestWithUrl:self.requestUrl type:self.type success:^(id model){
        // NSLog(@"%@",model);
        
        self.model=model;
        [self createDataSource];
        
        [GiFHUD dismiss];
        [self.tableView reloadData];
        [self endRefresh];
       
    } failure:^{
        [self endRefresh];
    }];
}

//停止刷新
- (void)endRefresh{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.tableView.header endRefreshing];
        
    }
    
    if (self.isLoading) {
        self.isLoading = NO;
        [self.tableView.footer endRefreshing];
    }
}

//获取数据源
- (void)createDataSource{
    
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // NSLog(@"count%ld",self.data.count);
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    return cell;
    
}


@end
