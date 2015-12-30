//
//  UIView+Size.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "UIView+Size.h"

@implementation UIView (Size)

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)width {
    return self.frame.size.width;
}

#pragma mark -

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)height {
    return self.frame.size.height;
}

#pragma mark -

- (void)setTopX:(CGFloat)topX {
    CGRect rect = self.frame;
    rect.origin.x = topX;
    self.frame = rect;
}

- (CGFloat)topX {
    return self.frame.origin.x;
}

#pragma mark -

- (void)setTopY:(CGFloat)topY {
    CGRect rect = self.frame;
    rect.origin.y = topY;
    self.frame = rect;
}

- (CGFloat)topY {
    return self.frame.origin.y;
}

#pragma mark -

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)maxX {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

@end
