//
//  FMDBManager.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "FMDBManager.h"
#import <FMDB.h>

@interface FMDBManager ()

@property (nonatomic)FMDatabase *db;

@end

@implementation FMDBManager

+ (instancetype)defaultManager{
    static FMDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc]init];
    });
    return manager;
}


- (instancetype)init{
    
    self=[super init];
    if (self) {
        NSString *path = [NSString stringWithFormat:@"%@/Documents/myDB.sqlite",NSHomeDirectory()];
        _db = [[FMDatabase alloc]initWithPath:path];
        
        if (_db) {
            [_db open];
            [self createTable];
        }
    }
    
    return self;
}

- (void)createTable{
    
//     NSString *sql = @"create table if not exists modelInfo(serial integer  Primary Key Autoincrement,modelTitle Varchar(1024),modelId Varchar(1024),iconUrl Varchar(1024),modelDetail Varchar(1024),modelFavs integer,modelComments integer";
    
    NSString *sql = @"create table if not exists modelInfo(serial integer  Primary Key Autoincrement,modelId Varchar(1024))";
    
    [_db executeUpdate:sql];
}

- (void)addModel:(NSString *)modelId{
    
    NSString *sql =@"insert into modelInfo(modelId) values(?)";
    if ([self modelIsExist:modelId]) {
        return;
    }
    [_db open];
    NSString *string = [NSString stringWithFormat:@"\"%@\"",modelId];
    [_db executeUpdate:sql,string];
    [_db close];
}

- (BOOL)modelIsExist:(NSString *)modelId{
    [_db open];
    NSString *sql =@"select * from modelInfo where modelId = ?";
    FMResultSet *rs = [_db executeQuery:sql,modelId];
    while ([rs next]) {
        [_db close];
        return YES;
    }
    [_db close];
    return NO;
}

- (NSArray *)showMyFavorite{
    NSString *sql = @"select * from modelInfo";
    [_db open];
   
    FMResultSet *result = [_db executeQuery:sql];
    NSMutableArray *lists = [[NSMutableArray alloc]init];
    
    while ([result next]) {
        NSString *modelId = [result stringForColumn:@"modelId"];
        [lists addObject:modelId];
        
    }
    [_db close];
    return lists;
}

- (void)deleteFromDB:(NSString *)modelId{
   NSString *sql = @"delete from modelInfo where modelId = ?";
    [_db open];
    [_db executeUpdate:sql,modelId];
    [_db close];

}



@end
