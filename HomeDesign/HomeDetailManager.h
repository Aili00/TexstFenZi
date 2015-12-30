//
//  HomeDetailManager.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeDetailModel.h"
#import "Define.h"
@interface HomeDetailManager : NSObject

+ (void)requestDataWithUrl:(NSString *)url  success:(void(^)(HomeDetailModel *))success failure:(void(^)(void))failure;

@end
