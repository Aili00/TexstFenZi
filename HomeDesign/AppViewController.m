//
//  AppViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "AppViewController.h"
#import "Define.h"
#import "Home.h"
#import "LoadingView.h"
#define kRowHeight 210

@interface AppViewController ()

//@property (nonatomic)LoadingView *loadingView;
@end

@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self createUI];
    //[self createAnimateView];
    
}

#pragma mark - createUI
- (void)createUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = kRowHeight;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Home" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //self.loadingView.hidden = NO;
        self.isRefreshing = YES;
        self.currentPage = 0;
        [self fetchData];
        
    }];
    self.tableView.header = headerView;
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
      
      //  self.loadingView.hidden = NO;
        self.currentPage += 10;
        [self fetchData];
        self.isLoading = YES;

    }];
    
    [headerView beginRefreshing];
    
}

//- (void)createAnimateView{
//    
//    _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
//    _loadingView.center = self.view.center;
//   // _loadingView.backgroundColor = [UIColor lightGrayColor];
//   // [self.view addSubview:_loadingView];
//}

#pragma mark - firstLoad

- (void)firstLoad{
    self.currentPage = 0;
    self.isRefreshing = NO;
    self.isLoading = NO;
  
    [self fetchData];
    
}

#pragma mark - fetchData
- (void)fetchData{
    if (![self fetchDataFromLocal]) {
        [self fetchDataFromServer];
        //[self endRefresh];
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
    self.requestUrl = [self requestUrl];
    [NetworkingManager  requestDataWithUrl:self.requestUrl type:self.type success:^{
        [self.tableView reloadData];
        [self endRefresh];
        //[self.loadingView hiddenAnimate];

    } failure:^{
       [self endRefresh];
    }];
}

//获取请求url
- (NSString *)requestUrl{
    if ([self.type isEqual:kHomeType]) {
        return [NSString stringWithFormat:kHomeUrl,self.currentPage];
    }
    return nil;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[AppModelStore shareInstance]getDataWithType:self.type].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Home *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    [cell updataForCell:[[AppModelStore shareInstance] getDataWithType:self.type][indexPath.row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
