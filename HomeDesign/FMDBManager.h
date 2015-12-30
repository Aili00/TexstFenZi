//
//  FMDBManager.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiyModel.h"
@interface FMDBManager : NSObject

//单例
+ (instancetype) defaultManager;

- (void)addModel:(NSString *)modelId;

- (BOOL)modelIsExist:(NSString *)modelId;
- (NSArray *)showMyFavorite;
- (void)deleteFromDB:(NSString *)modelId;

@end
