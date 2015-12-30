//
//  DiyManager.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "DiyManager.h"
#import "IOSFunction.h"
@implementation DiyManager

//请求创意首页数据
+ (void)requestDataWithUrl:(NSString *)url success:(void (^)(DiyModel *))success failure:(void (^)(void))failure{
    
//    NSString *str = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"str=%@",str);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
   // NSString *result =[IOSFunction urlEcodingFromString:url];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // NSLog(@"response:%@",responseObject);
        DiyModel *model = [[DiyModel alloc]init];
      NSArray *ary  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      
        for (NSDictionary *item in ary) {
            Esarray *obj = [[Esarray alloc]initWithDictionary:item error:nil];
            [model.esArray addObject:obj];
        }
        
        //NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//  DiyModel *model =[[DiyModel alloc]initWithString:str usingEncoding:NSUTF8StringEncoding error:nil];
       
 // [model setValuesForKeysWithDictionary:responseObject];
        
       // NSLog(@"model:%@",model);
        success(model);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        failure();
        NSLog(@"error:%@",error.localizedDescription);
    }];
}

//发送评论
+ (void)sentCommonWithUrl:(NSString *)url content:(NSString *)content success:(void (^)(void))success failure:(void (^)(void))failure{
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:@{@"content":content} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"response:%@",dic);
        success();
        NSLog(@"send sueecee");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure();
        NSLog(@"error:%@",error.localizedDescription);
    }];
}

//设置收藏数据
+ (void)setFavsDataWithUrl:(NSString *)url success:(managerBlock)success failure:(managerBlock)failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            success();
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure();
        NSLog(@"error:%@",error.localizedDescription);
    }];
}


////获取收藏
//+ (void)getFavsDataWithUrl:(NSString *)url success:(void(^)(DiyModel *))success failure:(void(^)(void)) failure{
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (responseObject) {
//            
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//             DiyModel *model = [[DiyModel alloc]initWithDictionary:dic error:nil];
//            success(model);
//            return ;
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//       
//        failure();
//        NSLog(@"error:%@",error.localizedDescription);
//    }];
//}

@end
