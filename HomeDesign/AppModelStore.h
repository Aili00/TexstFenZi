//
//  AppModelStore.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/1.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModelStore : NSObject

@property (nonatomic) NSMutableArray *HomeData;

@property (nonatomic) NSMutableArray *HomeDeatilData;

@property (nonatomic,strong)NSMutableArray *DesignerData;


+ (instancetype)shareInstance;

- (NSMutableArray *)getDataWithType:(NSString *)type;

@end
