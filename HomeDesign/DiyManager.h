//
//  DiyManager.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiyModel.h"

typedef void(^managerBlock) (void);

@interface DiyManager : NSObject

+ (void)requestDataWithUrl:(NSString *)url success:(void(^)(DiyModel *))success failure:(void(^)(void))failure;

+ (void)sentCommonWithUrl:(NSString *)url content:(NSString *)content success:(void(^)(void))success failure:(void(^)(void))failure;

+ (void)setFavsDataWithUrl:(NSString *)url success:(managerBlock)success failure:(managerBlock)failure;

//+ (void)getFavsDataWithUrl:(NSString *)url success:(void(^)(DiyModel *))success failure:(void(^)(void)) failure;

@end
