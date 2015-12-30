//
//  LocalViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "LocalViewController.h"
#import "DesingerViewController.h"



@implementation LocalViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.arrayCitys = [NSMutableArray array];
        self.keys = [NSMutableArray array];
        self.arrayHotCity = [NSMutableArray arrayWithObjects:@"北京市",@"上海市",@"天津市",@"西安市",@"重庆市",@"沈阳市",@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市",@"广州市", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self getCityData];
}


- (void)getCityData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"citydict" ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    NSString *strHot = @"热门城市";
    [self.keys insertObject:strHot atIndex:0];
    [self.cities setObject:_arrayHotCity forKey:strHot];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return _keys.count;
}

//区的title(侧边标题栏，会自适应宽度)

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray *lists = [NSMutableArray arrayWithArray:_keys];
    [lists replaceObjectAtIndex:0 withObject:@"热"];
    return lists;
}

//每个区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    NSString *key = [_keys objectAtIndex:indexPath.section];
    cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

//区的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

//区的视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.tableView.frame.size.width, 20)];
    bgView.backgroundColor = [UIColor whiteColor];

    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0,bgView.frame.size.width, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    NSString *key = [_keys objectAtIndex:section];
    if ([key rangeOfString:@"热"].location != NSNotFound) {
        titleLabel.text = @"热门城市";
    }
    else
        titleLabel.text = key;
    
    [bgView addSubview:titleLabel];
    
    return bgView;
}

//选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSString *key = _keys[indexPath.section];
    NSArray *citySection = _cities[key];
    NSString *title = citySection[indexPath.row];
    
      title = [title substringToIndex:2];
    
    if ([title isEqualToString:@"浦东"]) {
        title = @"浦东新区";
    }
    
    // NSLog(@"title%@,length=%ld",title,title.length);
   
    [self.delegate refreshCity:title];
    [(DesingerViewController *)self.delegate setFlag:1];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
