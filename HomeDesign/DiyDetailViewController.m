//
//  DiyDetailViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "DiyDetailViewController.h"
#import "Define.h"
#import "NSString+Size.h"
#import "UserCell.h"
#import "UserCellFrame.h"
#import "CommonViewController.h"
#import "FMDBManager.h"
#import "DiyManager.h"

#define PAGE_COUNT self.model.detail.count

@interface DiyDetailViewController ()
//<BackHandle>

@property (nonatomic)UIScrollView *scrollView;

@property (nonatomic)UIPageControl *pageControl;

@property (nonatomic,strong)NSMutableArray *imageViews;

@property (nonatomic,strong)NSMutableArray *frameLists;
@end

@implementation DiyDetailViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh:) name:@"sendModel" object:nil];

    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self createHeaderView];
    [self setPageControl];
    [self customTabbar];
    [self initFrameList];//关于什么时候调换该方法。需要再弄清楚些！
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.toolbarHidden =NO;
   
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.toolbarHidden = YES;
    
}

#pragma mark- 初始化
- (instancetype)initWithModel:(Esarray *)model{
    if (self = [super init]) {
        self.model = model;
        self.frameLists = [[NSMutableArray alloc]init];
        [self initFrameList];

    }
    return self;
}


- (void)createHeaderView{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    CGSize size= self.scrollView.size;
   
    if (PAGE_COUNT>=3) {
        self.scrollView.contentSize = CGSizeMake(size.width*3, size.height);
        [self createImageViews];
    }else{
        self.scrollView.contentSize = CGSizeMake(size.width*PAGE_COUNT, size.height);
        [self createImageViewNoReuse];
    }
    
    CGFloat gap = 10;
    CGFloat desY = CGRectGetMaxY(self.scrollView.frame)+gap;
    
    NSString *str = [NSString stringWithFormat:@"%@: %@",self.model.title, self.model.theDescription];
    CGSize desSize = [NSString getSizeToString:str withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, desY, desSize.width, desSize.height+gap)];
    desLabel.text = str;
   // NSLog(@"des:%@",self.model.theDescription);
    desLabel.numberOfLines = 0;
    desLabel.font = [UIFont systemFontOfSize:15];
    
    CGFloat headerY = CGRectGetMaxY(desLabel.frame)+gap;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headerY)];
    [headerView addSubview:self.scrollView];
    [headerView addSubview:desLabel];
    
   // self.tableView.tableHeaderView.height = headerY;
    self.tableView.tableHeaderView = headerView;
    
}

- (void)initFrameList{
    
    self.frameLists = [UserCellFrame getCellFrameListWith:self.model];
}


- (void)createImageViewNoReuse{
    
    CGSize size = _scrollView.frame.size;
    for (NSUInteger iv_i = 0; iv_i<PAGE_COUNT; iv_i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(size.width*iv_i, 0, size.width, size.height);
        //imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.model.detail[iv_i] pic]] placeholderImage:[UIImage imageNamed:@"diy_placeholder.jpg"]];
        [_scrollView addSubview:imageView];
    }
}

- (void)createImageViews{
    //创建用于保存三个图片视图的数组
    _imageViews = [[NSMutableArray alloc] init];
    
    //获取滚动视图的尺寸
    CGSize size = _scrollView.frame.size;
    
    for (NSInteger i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(size.width*i, 0, size.width, size.height);
        //设置图片填充模式，默认会拉伸
       // imageView.contentMode = UIViewContentModeScaleAspectFit;
        //使用tag记录本图片视图应该贴数组中的哪张图片
        imageView.tag = (i-1+PAGE_COUNT)%PAGE_COUNT;
        //向指定的图片视图上贴图片
        //[self setImageToImageView:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.model.detail[imageView.tag] pic]] placeholderImage:[UIImage imageNamed:@"diy_placeholder.jpg"]];
        //添加到滚动视图上
        [_scrollView addSubview:imageView];
        //保存到数组
        [_imageViews addObject:imageView];
    }

}

- (void)setPageControl
{
    CGSize size = self.view.frame.size;
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(0, 150, size.width, 50);
    _pageControl.numberOfPages = PAGE_COUNT;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    //添加事件
    [_pageControl addTarget:self action:@selector(pageControlHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_pageControl];
}

- (void)pageControlHandle:(UIPageControl *)pc
{
    if (pc.currentPage == [_imageViews[0] tag]
        || pc.currentPage == 0) {
        //向右滑
        [_scrollView setContentOffset:CGPointZero animated:YES];
    } else if (pc.currentPage == [_imageViews[2] tag]
               || pc.currentPage ==self.model.detail.count-1) {
        //向左滑
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*2, 0) animated:YES];
    }
}

- (void)autoRefresh{
    //记录左右滑动的标志，1:向左滑  -1:向右滑
    char flag = 0;
    //获取偏移量
    CGFloat offset = _scrollView.contentOffset.x;
    
    if (offset >= 2*_scrollView.frame.size.width) {
        //向左滑
        flag = 1;
    } else if (offset == 0) {
        //向右滑
        flag = -1;
    } else {
        //没有滑动一页
        return;
    }
    for (UIImageView *view in _imageViews) {
        //重新设置view上的图片
        view.tag = (view.tag+flag+PAGE_COUNT)%PAGE_COUNT;
       [view sd_setImageWithURL:[NSURL URLWithString:[self.model.detail[view.tag] pic]] placeholderImage:[UIImage imageNamed:@"diy_placeholder.jpg"]];
    }
    //重新设置偏移量，使用无动画版本
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
    //设置按页控制的当前页
    _pageControl.currentPage = [_imageViews[1] tag];
}

- (void)customTabbar{
    
    CGFloat viewW = 100;
    CGFloat viewH = 30;
    CGFloat imageViewW = 20;
    CGFloat labelW = 50;
    CGFloat gap = 10;
    
    UITapGestureRecognizer *tgr1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onshare:)];
    UIView *forwardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    [forwardView addGestureRecognizer:tgr1];
    
    UIImageView *forwardImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, imageViewW, imageViewW)];
    forwardImageView.image = [UIImage imageNamed:@"toolbar_icon_share"];
    
    UILabel *forwardLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageViewW+gap, 0, labelW, viewH)];
    forwardLabel.text = @"分享";
    forwardLabel.textColor = [UIColor grayColor];
    
    [forwardView addSubview:forwardImageView];
    [forwardView addSubview:forwardLabel];
    //[forwardView addSubview:lineIV];
    
    
    UITapGestureRecognizer *tgr2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oncommon:)];
    UIView *commView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    [commView addGestureRecognizer:tgr2];
    
    UIImageView *commImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,5, imageViewW, imageViewW)];
    commImageView.image = [UIImage imageNamed:@"toolbar_icon_comment"];
    
    UILabel *commLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageViewW+gap, 0, labelW, viewH)];
    commLabel.text = @"评论";
    commLabel.textColor = [UIColor grayColor];
    
    [commView addSubview:commImageView];
    [commView addSubview:commLabel];
    
    
    UITapGestureRecognizer *tgr3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onfavourite:)];
    UIView *collectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    [collectView addGestureRecognizer:tgr3];
    
    
    UIImageView *collectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, imageViewW, imageViewW)];
    NSString *string = [NSString stringWithFormat:@"\"%@\"",self.model.theId];
    if ([[FMDBManager defaultManager] modelIsExist:string]) {
        collectImageView.image = [UIImage imageNamed:@"iconfont-shoucang1"];
    }else{
         collectImageView.image = [UIImage imageNamed:@"iconfont-shoucang"];
    }
   
    UILabel *collectLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageViewW+gap, 0, labelW, viewH)];
    collectLabel.text = @"收藏";
    collectLabel.textColor  = [UIColor grayColor];
    
    [collectView addSubview:collectImageView];
    [collectView addSubview:collectLabel];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:forwardView];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:commView];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithCustomView:collectView];
   
    UIBarButtonItem *fixSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixSpace.width=30;
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    self.toolbarItems = @[fixSpace,item1,spaceItem,item2,spaceItem,item3,fixSpace];
    self.navigationController.toolbar.barTintColor =[UIColor whiteColor];

    //[self.navigationController setToolbarHidden:NO animated:YES];
}

#pragma mark - 单击手势处理
//分享
- (void)onshare:(UITapGestureRecognizer *)tgr{
    NSLog(@"aa");
}

//评论
- (void)oncommon:(UITapGestureRecognizer *)tgr{
    NSLog(@"bb");
    CommonViewController *cvc = [[CommonViewController alloc]init];
    //cvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
   // cvc.delegate = self;
    cvc.theId = self.model.theId;
    [self presentViewController:cvc animated:YES completion:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh:) name:@"send" object:nil];
    
}

- (void)refresh:(NSNotification *)center{
    self.model = center.object;
    [self initFrameList];
    [self.tableView reloadData];
}

//收藏
- (void)onfavourite:(UITapGestureRecognizer *)tgr{
    
    [[FMDBManager defaultManager]addModel:self.model.theId];
    
    UIImageView *favImageView =  tgr.view.subviews[0];
    [favImageView setImage:[UIImage imageNamed:@"iconfont-shoucang1"]];
    self.model.isLoved = @"YES";
    
    NSString *url = [NSString stringWithFormat:@"http://106.187.100.229:8090/api/design/%@/fav",self.model.theId];
    NSLog(@"url:%@",url);
    [DiyManager setFavsDataWithUrl:url success:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"send" object:nil];
    } failure:^{

    }];
 
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return [self.frameLists[indexPath.row] rowHeight];
    //return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.model.comments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
   
    //Comments *commModel =self.model.comments[indexPath.row];
    if (cell==nil) {
        cell = [[UserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    
    [cell updateFrameWith:self.frameLists[indexPath.row]];
    return cell;
}




#pragma mark - 协议方法
- (void)showToorbar{
    [self.navigationController setToolbarHidden:NO animated:NO];
    self.navigationController.toolbar.alpha = 0;
}


#pragma mark - scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (PAGE_COUNT>=3) {
         [self autoRefresh];
    }else{
        self.pageControl.currentPage =_scrollView.contentOffset.x/_scrollView.frame.size.width;
    }
   
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (PAGE_COUNT>=3) {
         [self autoRefresh];
    }else{
        self.pageControl.currentPage =_scrollView.contentOffset.x/_scrollView.frame.size.width;
    }
}

#pragma mark-系统
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
//- (void)viewWillDisappear:(BOOL)animated{
//    [self.navigationController setToolbarHidden:YES animated:NO];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"send" object:nil];
//}


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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
