//
//  AppModelStore.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/1.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "AppModelStore.h"
#import "Define.h"
@implementation AppModelStore

+ (instancetype)shareInstance{
    static AppModelStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[AppModelStore alloc]init];
    });
    return store;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _HomeData = [NSMutableArray array];
        _HomeDeatilData = [NSMutableArray array];
        _DesignerData = [NSMutableArray array];
    }
    return self;
}


- (NSMutableArray *)getDataWithType:(NSString *)type{
    
    if ([type isEqualToString:kHomeType]) {
        return _HomeData;
    }else if ([type isEqualToString:kHomeDetailType]){
        return _HomeDeatilData;
    }else if ([type isEqualToString:kDesignerType]){
        return _DesignerData;
    }
    
    
    return nil;
}
@end
