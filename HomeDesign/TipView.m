//
//  TipView.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/19.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "TipView.h"
#import "Define.h"
@implementation TipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (TipView *)tipViewWithTitle:(NSString *)title{
    TipView *tipView = [[TipView alloc]initWithFrame:CGRectMake(0, 0, 100, 80) title:title];
    return tipView;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, 90, 20)];
        label.text = title;
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
    }
    return self;
}

- (void)showTipView{
    
    self.hidden=NO;
    self.backgroundColor = [UIColor darkGrayColor];
    self.alpha =0.5;
    [UIView animateWithDuration:10 animations:^{
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.hidden=YES;
    }];
    
}
@end
