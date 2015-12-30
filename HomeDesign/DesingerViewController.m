//
//  DesingerViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/15.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "DesingerViewController.h"
#import "DesignerCell.h"
#import "DesignerModel.h"
#import "Define.h"
#import "LoadingView.h"
#import "LocalViewController.h"
#import "DesingerCaseViewController.h"
#import "GiFHUD.h"
@interface DesingerViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,PassCity>

@property (nonatomic,strong)DesignerModel *model;

@property (nonatomic)UITableView *tableView;
@property (nonatomic)LoadingView *loadingView;

@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoading;

@property (nonatomic)NSString *type;

@property (nonatomic)BOOL isAlertShow;

@end

@implementation DesingerViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.data = [[NSMutableArray alloc]init];
    self.type = kDesignerType;
    [self createUI];
    [self firstLoad];
    [self customNavigationItem];
    //[self addObserver:self forKeyPath:@"self.city" options:NSKeyValueObservingOptionNew|
    // NSKeyValueObservingOptionOld context:nil];
    
   self.navigationItem.title = @"全国";
   // self.tabBarController.title  =@"设计师";
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD show];
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.flag&&(!self.isAlertShow)) {
        [self.data removeAllObjects];
        [self fetchDataFromServer];
        self.navigationItem.title = self.city;
    }
    
    [GiFHUD dismiss];
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    
//    [self.data removeAllObjects];
//    [self fetchDataFromServer];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableview


- (void)createUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kNCHeight)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 90;
    
    [_tableView registerNib:[UINib nibWithNibName:@"DesignerCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
//    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
//    self.loadingView.center = self.view.center;
//    [self.view addSubview:_loadingView];
    
    MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.isRefreshing = YES;
        self.currentPage = 0;
        [self fetchData];
        
    }];

    self.tableView.header = headerView;
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.currentPage += 12;
        [self fetchData];
        self.isLoading = YES;
        
    }];
    
    [headerView beginRefreshing];
}

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
    
    [self getCity];
    NSString *url = [NSString stringWithFormat:kDesignerUrl,self.currentPage,self.city];
    [NetworkingManager requestWithUrl:url type:self.type success:^(id model){
       // NSLog(@"%@",model);
        
        self.model=model;
        
        for (Professionals *item in self.model.professionals) {
           
            if (![self repeatCheck:item]) {
                [self.data addObject:item];
            }
        }
        
        if (self.data.count==0) {
            self.flag = 0;
            self.navigationItem.title = @"全国";
            [self fetchDataFromServer];
            if (!self.isAlertShow) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"该地区占无查询结果,请重新选择地区" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
                self.isAlertShow=YES;
            }
        }
        
        [self.tableView reloadData];
        [self endRefresh];
      //  [self.loadingView hiddenAnimate];
        
    } failure:^{
        [self endRefresh];
        [GiFHUD dismiss];
    }];
}

- (void)getCity{
   
    if (self.flag==0) {
         self.city = @"";
        
    }
   
}

- (void)refreshCity:(NSString *)city{
    self.city = city;
//    if (self.flag) {
//        [self.data removeAllObjects];
//        [self fetchDataFromServer];
//    }
}
//重复检测
- (BOOL)repeatCheck:(Professionals *)item{
    
    for (Professionals *list in self.data) {
        if ([list.userName isEqualToString:item.userName]) {
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

#pragma mark  - 定位

- (void)customNavigationItem{
    // self.navigationItem.rightBarButtonItem
    UIButton *localButton = [UIButton buttonWithType:UIButtonTypeCustom];
    localButton.frame = CGRectMake(0, 0, 44, 44);
    [localButton setImage:[UIImage imageNamed:@"queue_message_file_map"] forState:UIControlStateNormal];
    [localButton addTarget:self action:@selector(onLocal) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:localButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)onLocal{
    
    LocalViewController *lvc = [[LocalViewController alloc]init];
    lvc.title = @"城市";
    lvc.delegate = self;
    self.isAlertShow=NO;
    [self.navigationController pushViewController:lvc animated:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // NSLog(@"count%ld",self.data.count);
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DesignerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell updateWithData:self.data[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    DesingerCaseViewController *dcvc = [[DesingerCaseViewController alloc]init];
    dcvc.prodession = self.data[indexPath.row];
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:dcvc animated:YES];
}

#pragma mark - UIAlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:YES];
            break;
            
        case 1:
            [self onLocal];
            break;
            
        default:
            break;
    }
}

@end
