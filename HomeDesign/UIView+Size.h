//
//  UIView+Size.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Size)

@property (nonatomic,assign) CGFloat topX;

@property (nonatomic,assign) CGFloat topY;

@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign,readonly) CGFloat bottom;

@property (nonatomic,assign,readonly) CGFloat maxX;

@property (nonatomic,assign) CGSize  size;

@end
