//
//  LoadingView.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/15.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (nonatomic)UIImageView *loadingView;
@property (nonatomic,strong)NSMutableArray *imageViews;

@end


@implementation LoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self createAnimateView];
        
    }
    return self;
}

- (void)createAnimateView{
    
    self.loadingView = [[UIImageView alloc]initWithFrame:self.frame];
    [self addSubview:_loadingView];
    [self createImages];
    self.loadingView.animationImages = self.imageViews;
    self.loadingView.animationDuration = 2;
   //self.loadingView.animationRepeatCount = 0;
    [self.loadingView startAnimating];
}

- (void)createImages{
    
    self.imageViews = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<24; i++) {
        NSString *name = [NSString stringWithFormat:@"loading_%ld",i];
        UIImage  *image =[UIImage imageNamed:name];
        [self.imageViews addObject:image];
    }
}


- (void)hiddenAnimate{
    
    [UIView animateWithDuration:3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        //self.hidden = YES;
        self.alpha = 1;
        [self removeFromSuperview];
    }];
    
}
@end
