//
//  DiyViewController.m
//  HomeDesign
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "DiyViewController.h"
#import "ReuseViewController.h"
#import "Define.h"
#import "DiyDetailViewController.h"
#define BUTTON_BASE_TAG 100
#define TITLE_W kScreenWidth/6
#define TITLE_H 45

@interface DiyViewController ()<UIScrollViewDelegate,pushDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic,strong) NSArray *titlesAry;

@property (nonatomic,strong)NSMutableArray *buttonAry;
@end

@implementation DiyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createTitleScrollView];
    [self createContentScrollView];
    
}

//标题滚动视图
- (void)createTitleScrollView{
    
    //消除导航对滚动视图的影响
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    self.titleScrollView.delegate = self;
    
    NSString *titles= [[NSBundle mainBundle]pathForResource:@"diy_titles" ofType:@"plist"];
    self.titlesAry = [NSArray arrayWithContentsOfFile:titles];
    self.buttonAry = [NSMutableArray array];
    
    for (NSInteger btn_i=0; btn_i<_titlesAry.count; btn_i++) {
        
//        TitleLabel *titleLabel = [[TitleLabel alloc]initWithFrame:CGRectMake(TITLE_W*btn_i, 0, TITLE_W, TITLE_H)];
//        titleLabel.text = _titlesAry[btn_i][@"title"];
//        titleLabel.userInteractionEnabled = YES;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(TITLE_W*btn_i, 0, TITLE_W, TITLE_H);
        
        [btn setTitle:_titlesAry[btn_i][@"title"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = BUTTON_BASE_TAG +btn_i;
      //  btn.backgroundColor = [UIColor blackColor];
      //  [titleLabel addSubview:btn];
        [self.buttonAry addObject:btn];
        [self.titleScrollView addSubview:btn];
    }
    [self.buttonAry[0] setSelected:YES];
    self.titleScrollView.contentSize = CGSizeMake(TITLE_W*_titlesAry.count,0);

}

//标题点击事件
- (void)onClick:(UIButton *)button{
    
    [self setSelecteStateWithTag:button.tag];
    CGFloat offsetX = (button.tag-BUTTON_BASE_TAG)*self.contentScrollView.size.width;
    
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
}

//设置button的选中状态
- (void)setSelecteStateWithTag:(NSInteger)tag{
    for (UIButton *btn in _buttonAry) {
        if (btn.tag==tag) {
            btn.selected = YES;
        }else{
            btn.selected=NO;
        }
    }
}
//内容滚动视图
- (void)createContentScrollView{
    
    for (NSInteger vc_i=0; vc_i<_titlesAry.count; vc_i++) {
        ReuseViewController *rvc = [[ReuseViewController alloc]initWithType:self.titlesAry[vc_i][@"category"]];
        rvc.view.frame = CGRectMake(kScreenWidth*vc_i, 0, kScreenWidth, self.contentScrollView.height);
       // rvc.type = self.titlesAry[vc_i][@"category"];
       // NSLog(@"type1:%@",rvc.type);
        rvc.delegate = self;
        [self.contentScrollView addSubview:rvc.view];
    }
    self.contentScrollView.contentSize = CGSizeMake(self.titlesAry.count*kScreenWidth,0);
    self.contentScrollView.size = kScreenSize;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    self.contentScrollView.bounces= NO;
    self.contentScrollView.showsHorizontalScrollIndicator=NO;
}

#pragma mark-push 代理方法
- (void)pushNextView:(Esarray *)model{
    
    DiyDetailViewController *dvc = [[DiyDetailViewController alloc]init];
    dvc.model = model;
    dvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dvc animated:YES];
    
}

#pragma  mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (scrollView == self.contentScrollView) {
        NSInteger btn_tag = scrollView.mj_offsetX/scrollView.width+BUTTON_BASE_TAG;
       // NSLog(@"%ld",btn_tag);
        [self setSelecteStateWithTag:btn_tag];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView == self.contentScrollView) {
              
        NSInteger btn_tag = scrollView.mj_offsetX/scrollView.width+BUTTON_BASE_TAG;
      //  NSLog(@"%ld",btn_tag);
        [self setSelecteStateWithTag:btn_tag];
    }
}

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
