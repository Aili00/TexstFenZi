//
//  HomeViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/1.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "HomeViewController.h"
#import "NetworkingManager.h"

#import "Home.h"
#define kRowHeight 210
#define ViewTag 10000

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    self.type = kHomeType;
   
    [self firstLoad];
    [self fetchData];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return kRowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeDetailViewController *hdvc = [[HomeDetailViewController alloc]init];
    AppModel *model = [[AppModelStore shareInstance]getDataWithType:self.type][indexPath.row];
    hdvc.modelId = model.ModelId;
    hdvc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:hdvc animated:YES];
    
}
#pragma  mark - UIScrollViewDelegate 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self tableViewAnimation];
}

- (void)tableViewAnimation{
    
   
    
    Home *cell = [[self.tableView visibleCells] firstObject];

    if (self.tableView.contentOffset.y >= cell.topY) {
        
        CGFloat height = cell.bottom - self.tableView.contentOffset.y;
        CGFloat scale = 1 - (height / cell.height);
        cell.coverPhoto.alpha = 1 - 0.5 *scale;
        cell.coverPhoto.frame = CGRectMake(25*scale, kRowHeight - height,kScreenWidth- 50*scale, kRowHeight);
        cell.layer.masksToBounds = YES;
    }
    if (self.tableView.contentOffset.y >= cell.topY + 70  && self.tableView.contentOffset.y <= cell.bottom-65) {
        CGFloat height = self.tableView.contentOffset.y - cell.topY + 10;
        cell.title.frame = CGRectMake(0, height, kScreenWidth, 25);
        cell.detail.frame = CGRectMake(0, height+30, kScreenWidth, 20);
    }
    if (self.tableView.contentOffset.y < cell.topY) {
        [self tableViewCellOriginalLocation:cell];
    }
    
    if ([self.tableView visibleCells].count >= 2) {
        Home *cell1 = [[self.tableView visibleCells] objectAtIndex:1];
        if (self.tableView.contentOffset.y < cell1.topY) {
            [self tableViewCellOriginalLocation:cell1];
        }
    }
}
- (void)tableViewCellOriginalLocation:(Home *)cell{
    cell.coverPhoto.frame = CGRectMake(0, 0, kScreenWidth, kRowHeight-3);
    cell.title.frame = CGRectMake(0, 80, kScreenWidth, 25);
    cell.detail.frame = CGRectMake(0, 110, kScreenWidth, 20);
    cell.coverPhoto.alpha = 1;
    
}

#pragma mark -
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.5 animations:^{
        UIView *view = [self.tabBarController.view viewWithTag:ViewTag];
        view.alpha = 0.15;
       // self.tabBarController.tabBar.hidden=YES;
       // self.tableView.frame =CGRectMake(0,kNCHeight, kScreenWidth, kScreenHeight-kNCHeight);
    }];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.5 animations:^{
        UIView *view = [self.tabBarController.view viewWithTag:ViewTag];
        view.alpha = 1;
    
           // self.tabBarController.tabBar.hidden=NO;
          //  self.tableView.frame =CGRectMake(0,kNCHeight, kScreenWidth, kScreenHeight-kNCHeight-kTabBarHeight);
    }];
    
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
