//
//  NSString+Size.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "NSString+Size.h"
#import "Define.h"
@implementation NSString (Size)

+ (CGSize)getSizeToString:(NSString *)string withAttributes:(NSDictionary *)attributes{
    CGSize size = [string boundingRectWithSize:CGSizeMake(kScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}

@end
