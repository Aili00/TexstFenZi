//
//  NSString+Size.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

+ (CGSize)getSizeToString:(NSString *)string withAttributes:(NSDictionary *)attributes;

@end
