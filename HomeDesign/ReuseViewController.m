//
//  ReuseViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "ReuseViewController.h"
#import "DiyModel.h"
#import "DiyManager.h"
#import "DiyCell.h"
#import "DiyDetailViewController.h"
#import "GiFHUD.h"
#import "FMDBManager.h"

#define  SCROLLVIEW_H 47
//#define RandomValue arc4random()%256/255.0
#define kcommonUrl @"http://106.187.100.229:8090/api/design?page=%ld&order=&category=%@&"
#define kfavUrl @"http://106.187.100.229:8090/api/design?page=%ld&order=%@&category=&"
#define knewestUrl @"http://106.187.100.229:8090/api/design?page=%ld&order=&category=&"
#define kmyLovedUrl @"http://106.187.100.229:8090/api/design/list?ids=[%@]&fav"

@interface ReuseViewController ()

@property (nonatomic)DiyModel *model;

@property (nonatomic)NSMutableArray *data;

@property (nonatomic)BOOL isLoading;
@property (nonatomic)BOOL isRefresh;

@property (nonatomic)NSInteger page;

@end

@implementation ReuseViewController

#pragma mark - 生命周期
//已经加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadFromSever) name:@"send" object:nil];
    self.data = [[NSMutableArray alloc]init];
    [self createUI];
    [self firstLoad];
    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    [GiFHUD show];

}

//有警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

//将要销毁
- (void)viewWillDisappear:(BOOL)animated{
   // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"send" object:nil];
    [GiFHUD dismiss];
}

#pragma mark - 初始化
- (instancetype)initWithType:(NSString *)type{
    if (self=[super init]) {
        self.type = type;
    }
    return self;
}

- (void)createUI{
    
    self.tableView.rowHeight = 230;
    self.tableView.frame = CGRectMake(0, SCROLLVIEW_H, kScreenWidth, kScreenHeight-SCROLLVIEW_H-kNCHeight);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DiyCell" bundle:nil] forCellReuseIdentifier:@"diyCellID"];
    
    if (![self.type isEqualToString:@"myloved"]) {
        MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            self.isRefresh=YES;
            [self fetchData];
        }];
        self.tableView.header = headerView;
        
        MJRefreshBackNormalFooter *footerView = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.page++;
            [self fetchData];
            self.isLoading=YES;
        }];
        self.tableView.footer = footerView;
    }
   
}

#pragma mark - 请求数据
//首次加载
- (void)firstLoad{
    
    self.page = 1;
    self.isRefresh =NO;
    self.isLoading = NO;
    [self fetchData];
   
}
//请求数据
- (void)fetchData{
    if (![self loadFormLocal]) {
        [self loadFromSever];
        [self endRefresh];
    }
}
//本地加载
- (BOOL)loadFormLocal{
    return NO;
}

//网络加载
- (void)loadFromSever{
    if (self.data.count%15==0) {
        self.page = self.data.count/15+1;
    }else{
        [self.tableView.footer endRefreshingWithNoMoreData];
        return;
    }
    NSString *url = [self requestURL];
    [DiyManager requestDataWithUrl:url success:^(DiyModel *model) {
        self.model =model;
    
        for (Esarray *item in model.esArray) {
            if (![self repeatCheck:(item)]&&model) {
                [self.data addObject:item];
                
            }
        }
        [GiFHUD dismiss];
        [self.tableView reloadData];
        
    } failure:^{
        [GiFHUD dismiss];
    }];
}
//拼接请求url
- (NSString *)requestURL{
    if ([self.type isEqualToString:@"favs"]) {
        return [NSString stringWithFormat:kfavUrl,self.page,self.type];
    }else if (self.type ==nil){
        return [NSString stringWithFormat:knewestUrl,self.page];
    }else if([self.type isEqualToString:@"myloved"]){
        NSArray *idLists = [[FMDBManager defaultManager] showMyFavorite];
        NSString *string = [idLists componentsJoinedByString:@","];
        return [NSString stringWithFormat:kmyLovedUrl,string];
    }
    return [NSString stringWithFormat:kcommonUrl,self.page,self.type];
}

//重复检测
- (BOOL)repeatCheck:(Esarray *)model{
    if (self.data.count==0) {
        return NO;
    }
    for (NSInteger i=0;i<self.data.count;i++) {
        Esarray *item = self.data[i];
        if ([item.theId isEqualToString:model.theId]) {
            return YES;
        }else if([item.theId isEqualToString:model.theId]&&[item.flag isEqual:@"selected"]){
            [self.data replaceObjectAtIndex:i withObject:model];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"sendModel" object:model];
            return YES;
        }
    }
    return NO;
}

//结束刷新
- (void)endRefresh{
    if (self.isRefresh) {
        self.isLoading = NO;
        [self.tableView.header endRefreshing];
    }
    if (self.isLoading) {
        self.isRefresh = NO;
        [self.tableView.footer endRefreshing];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
   // NSLog(@"count:%ld",self.data.count);
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"diyCellID" forIndexPath:indexPath];
    
    [cell updateWithModel:self.data[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //修改选中状态
    for (Esarray *item in self.data) {
        item.flag = nil;
    }

    Esarray *model = self.data[indexPath.row];
    model.flag = @"selected";

    //在我的收藏里点击的tableviewCell，可以push到下一页面
    if ([self.type isEqualToString:@"myloved"]) {
        DiyDetailViewController *dvc = [[DiyDetailViewController alloc]initWithModel:model];
        dvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:dvc animated:YES];
        return;
        
    }
    //加在滚动视图上的tableViewController没有NavigationController了，需要上上一级帮助push详情页面
    [self.delegate pushNextView:model];
    
}


@end
