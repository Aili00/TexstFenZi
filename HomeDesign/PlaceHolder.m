//
//  PlaceHolder.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/15.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "PlaceHolder.h"

@interface PlaceHolder()

@property (nonatomic,strong)UILabel *placeholderLabel;
@end

@implementation PlaceHolder

//懒加载
- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.numberOfLines = 0;
        self.placeholderLabel = label;
    }
    return self.placeholderLabel;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame: frame]) {
//        self.alwaysBounceVertical = YES;
//        self.textColor = [UIColor blackColor];
//        
//    }
//}
@end
