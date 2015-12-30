//
//  NetworkingManager.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/1.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^managerBlock) (void);

@interface NetworkingManager : NSObject

+ (instancetype)defaultManager;

+ (void)requestDataWithUrl:(NSString *)url type:(NSString *)type  success:(managerBlock)success failure:(managerBlock)failure;

+ (void)requestWithUrl:(NSString *)url type:(NSString *)type success:(void(^)(id))success failure:(managerBlock)failure;



@end
