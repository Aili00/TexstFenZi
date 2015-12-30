//
//  HomeDetailModel.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "HomeDetailModel.h"

@implementation HomeDetailModel

@synthesize description=_description;

@end
@implementation User

@end


@implementation Userimage

@end


@implementation Taskend

+ (NSDictionary *)objectClassInArray{
    return @{@"space" : [Space class]};
}

@end


@implementation Projectstate

//@synthesize description = _description;

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"proDescription"}];
}

@end


@implementation Space

+ (NSDictionary *)objectClassInArray{
    return @{@"img" : [Img class]};
}

@end


@implementation Img

@end













