//
//  NetworkingManager.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/1.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "NetworkingManager.h"
#import "Define.h"
#import "DesignerModel.h"

@interface NetworkingManager ()

@property (nonatomic) NSString *type;

@end

@implementation NetworkingManager

+ (instancetype)defaultManager{
    static NetworkingManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetworkingManager alloc]init];
    });
    return manager;
}

//首页数据请求
+ (void)requestDataWithUrl:(NSString *)url type:(NSString *)type success:(managerBlock)success failure:(managerBlock)failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
   [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       if (responseObject) {
           
           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
           
           if ([type isEqualToString:kHomeType]) {
               [[self defaultManager]homeDataParse:(NSDictionary *)dict type:(NSString *)type];
               success();
               return ;
           }
    
       }
       success();
       
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       failure();
       NSLog(@"error:%@",error.localizedDescription);
   }];
    
}

//根据类型返回model
+ (void)requestWithUrl:(NSString *)url type:(NSString *)type success:(void (^)(id))success failure:(managerBlock)failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
     url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
           
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([type isEqualToString:kDesignerType]) {
                DesignerModel *model = [[DesignerModel alloc]initWithDictionary:dic error:nil];
                success(model);
            }else if ([type isEqualToString:kDesingerCaseType]){
                CaseModel *model = [[CaseModel alloc]initWithDictionary:dic error:nil];
                success(model);
            }
           
        }
        success(nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        failure();
        NSLog(@"error:%@",error.localizedDescription);
    }];
}

//首页数据解析
- (void)homeDataParse:(NSDictionary *)dict type:(NSString *)type{
    
    self.type = type;
    NSArray *projects = dict[@"projects"];
    
    for (NSDictionary *dic in projects) {
        AppModel *model = [[AppModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
       // NSLog(@"model:%ld",model.coverPhoto);
        
        if (![self RepeatCheck:model]) {
            [[[AppModelStore shareInstance]getDataWithType:type]addObject:model];
        }

    }
}

//重复检测
- (BOOL)RepeatCheck:(AppModel *)model{
    
        for (AppModel *item in [[AppModelStore shareInstance]getDataWithType:self.type]) {
            if (item.ModelId == model.ModelId) {
                return YES;
               }
    }
    return NO;
}









@end
