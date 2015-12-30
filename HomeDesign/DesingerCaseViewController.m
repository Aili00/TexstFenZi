//
//  DesingerCaseViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/17.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "DesingerCaseViewController.h"
#import "Define.h"
#import "CaseCell.h"
#import "HomeDetailViewController.h"

@interface DesingerCaseViewController ()

@end

@implementation DesingerCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.data = [[NSMutableArray alloc]init];
    
    [self firstLoad];
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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kNCHeight)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 230;
    
    [_tableView registerNib:[UINib nibWithNibName:@"CaseCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.isRefreshing = YES;
        self.currentPage = 0;
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
    
    self.count=5;
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
    
    NSString *url = [NSString stringWithFormat:kCaseUrl,self.prodession.userName,self.start,self.count];
    NSLog(@"url:%@",url);
    [NetworkingManager requestWithUrl:url type:kDesingerCaseType success:^(id model){
        // NSLog(@"%@",model);
        
        self.model=model;
       
       // NSLog(@"model=%@",model);
        for (Projects *item in self.model.projects) {
        //    NSLog(@"item:%@",item);
            if (![self repeatCheck:item]) {
                
                [self.data addObject:item];
            }
        }
        [GiFHUD dismiss];
        [self.tableView reloadData];
        [self endRefresh];
        
    } failure:^{
        [self endRefresh];
    }];
}


- (BOOL)repeatCheck:(Projects *)item{
    
    if (!self.data.count) {
        return NO;
    }
    for (Projects *oneData in self.data) {
        if (oneData.theProjectsId==item.theProjectsId) {
            return YES;
        }
    }
    return NO;
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


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // NSLog(@"count%ld",self.data.count);
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    [cell updateWithData:self.data[indexPath.row]];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeDetailViewController *hdvc = [[HomeDetailViewController alloc]init];
    
    hdvc.modelId = [self.data[indexPath.row] theProjectsId];
    NSLog(@"modelId:%ld",hdvc.modelId);
    [self.navigationController pushViewController:hdvc animated:YES];
}

@end
