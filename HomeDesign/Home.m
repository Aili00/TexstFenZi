//
//  Home.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "Home.h"
#import "LoadingView.h"

@interface Home ()
@property (nonatomic)LoadingView *loadingView;
//@property (nonatomic)NSInteger flag;

@end

@implementation Home

- (void)awakeFromNib {
//    // Initialization code
//    _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
//    _loadingView.center = self.contentView.center;
//    [self.contentView addSubview:_loadingView];

}


- (void)layoutSubviews{
    [super layoutSubviews];
   
//    if (_flag) {
//        return;
//    }
    
//    _loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
//    _loadingView.center = self.contentView.center;
//    [self.contentView addSubview:_loadingView];

    //[self layoutIfNeeded];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updataForCell:(AppModel *)model{
    
    NSString *path = [NSString stringWithFormat:kHomeImageUrl,model.coverPhoto];
           [_coverPhoto sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [self.loadingView hiddenAnimate];
//        self.flag = 1;
    }];
    
    self.title.text = [NSString stringWithFormat:@"风格 %@",model.styleShow];
    
    NSString *provinceName = @"";
    if (![model.provinceName isEqual:@""]) {
        provinceName = [NSString stringWithFormat:@"#%@",model.provinceName];
    }
    self.detail.text = [NSString stringWithFormat:@"%@ •%@平米 •%@万元",provinceName,model.areaShow,model.costShow];

}
@end

