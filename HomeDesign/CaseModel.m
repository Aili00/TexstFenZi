//
//  CaseModel.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/17.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "CaseModel.h"

@implementation CaseModel


//+ (NSDictionary *)objectClassInArray{
//    return @{@"projects" : [Projects class]};
//}


@end
@implementation Projects

//+ (NSDictionary *)objectClassInArray{
//    return @{@"photos" : [Photos class]};
//}


+(JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"theProjectsId",@"description":@"theDescription"}];
}
@end


@implementation Photos

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"thePhotoId"}];
}

@end


