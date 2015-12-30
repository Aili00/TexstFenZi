//
//  HomeDetailViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "Define.h"
#import "HomeDetailModel.h"
#import "HomeDetailManager.h"
#import "HomeDetailCell.h"
#import "HDHeaderView.h"
#import "GiFHUD.h"

@interface HomeDetailViewController ()

@property (nonatomic,strong)HomeDetailModel *model;
@property (nonatomic,strong)HDHeaderView *headerView;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD show];
    self.tableView.separatorColor= [UIColor clearColor];
    [self loadData];
    
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [GiFHUD dismiss];
}

- (void)loadData{
    
    NSString *url = [NSString stringWithFormat:kHomeDetailUrl,self.modelId];
    NSLog(@"url:%@",url);
    [HomeDetailManager requestDataWithUrl:url success:^(HomeDetailModel *model) {
        self.model =model;
        
        HDHeaderView *headerView = [[HDHeaderView alloc]initWithModel:self.model];
        self.tableView.tableHeaderView = headerView;
    
        [self.tableView reloadData];
        [GiFHUD dismiss];
        
        
    } failure:^{
        [GiFHUD dismiss];
    }];
}



#pragma mark - UItableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model.taskEnd.space.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model.taskEnd.space[section][@"img"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger photoId = [self.model.taskEnd.space[indexPath.section][@"img"][indexPath.row][@"photoId"] integerValue];
    
    NSString *path = [NSString stringWithFormat:kHomeImageUrl,photoId];
    
    NSString *name = self.model.taskEnd.space[indexPath.section][@"name"];
    
    if (indexPath.row==0) {
        HomeDetailCell *cell = [[HomeDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headCepllID" index:0];
        [cell updataCellWithName:name imageUrl:path index:0];
        return cell;
        
    }
    
    HomeDetailCell *cell = [[HomeDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normalCellID" index:1];
    [cell updataCellWithName:nil imageUrl:path index:1];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 208;
    }
    return 155;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark - UItableViewDelegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
