//
//  DesingerViewController.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/15.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DesingerViewController : UIViewController

@property (nonatomic)NSString *city;
@property (nonatomic)NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray *data;

@property (nonatomic)NSInteger flag;

- (void)fetchDataFromServer;

@end
