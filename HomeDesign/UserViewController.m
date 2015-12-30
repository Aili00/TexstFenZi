//
//  UserViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "UserViewController.h"
#import "Define.h"
#import "ReuseViewController.h"
#import "SDImageCache.h"
#import "FMDBManager.h"
@interface UserViewController ()

//@property (nonatomic,strong)NSArray *data;


@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UILabel *cacheSize;

@property (strong, nonatomic) IBOutlet UITableView *xibTableView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.view.backgroundColor = [UIColor whiteColor];
  
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , 150)];
    headerView.image = [UIImage imageNamed:@"head_bag.jpg"];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    titleLabel.text = @"家•模样";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.center = headerView.center;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLabel];
    
    
    self.xibTableView.tableHeaderView = headerView;
    NSLog(@"沙河目录%@",NSHomeDirectory());
    [self getCacheSize];
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSInteger loveNum = [[[FMDBManager defaultManager]showMyFavorite] count];
    self.likeNum.text = [NSString stringWithFormat:@"%ld",loveNum];
    [self getCacheSize];
}

- (instancetype)init{
    if (self = [super init]) {
        UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self = [stroyBoard instantiateViewControllerWithIdentifier:@"userID"];
        
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 获取缓存文件大小
- (void)getCacheSize{
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSArray *fileList = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    
    CGFloat cacheSize = 0;
    for (NSString *fileName in fileList) {
        NSString *fullPath= [cachePath stringByAppendingPathComponent:fileName];
        CGFloat fileSize = [[NSFileManager defaultManager]attributesOfFileSystemForPath:fullPath error:nil].fileSize/1024.0/1024.0;
        cacheSize+=fileSize;
    }
    cacheSize +=[[SDImageCache sharedImageCache]getSize]/1024.0/1024.0;
    self.cacheSize.text = [NSString stringWithFormat:@"%.2lfMB",cacheSize];
}


- (void)deleteCache{
   
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    
    NSLog(@"%@",cachePath);
    NSFileManager *manager = [NSFileManager defaultManager];
   
    [manager removeItemAtPath:cachePath error:nil];
    
}
#pragma  mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            //我的收藏
        {
            ReuseViewController *rvc = [[ReuseViewController alloc]initWithType:@"myloved"];
            rvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:rvc animated:YES];
        }
            break;
        case 1:
            //清除缓存
        {
            [self deleteCache];
            self.cacheSize.text = @"0MB";
        }
            break;
        case 2:
            //关于我们
            break;
        default:
            break;
    }
    
}
@end
