//
//  AppModel.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/1.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ModelId = [value integerValue];
    }
}

@end

//@implementation User
//
//@end
//
//
//@implementation Userimage
//
//@end


