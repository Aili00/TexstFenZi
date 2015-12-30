 //
//  HomeDetailManager.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "HomeDetailManager.h"

@implementation HomeDetailManager

+ (void)requestDataWithUrl:(NSString *)url success:(void (^)(HomeDetailModel *))success failure:(void (^)(void))failure{
    
//    NSString * str=[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"%@",str);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
            HomeDetailModel *model = [[HomeDetailModel alloc]initWithDictionary:dict error:nil];
         
            success(model);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure();
        NSLog(@"error=%@",error.localizedDescription);
    }];
}

@end
