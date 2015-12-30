//
//  DiyModel.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "DiyModel.h"

@implementation DiyModel


+ (NSDictionary *)objectClassInArray{
    return @{@"esArray" : [NSMutableArray class]};
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.esArray = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
@implementation Esarray

//+ (NSDictionary *)objectClassInArray{
//    return @{@"detail" : [Detail class], @"comments" : [Comments class]};
//}

//@synthesize description=_description;
+ (JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"theDescription",@"_id":@"theId"}];
}


@end


@implementation Detail

@end


@implementation Comments

@end


