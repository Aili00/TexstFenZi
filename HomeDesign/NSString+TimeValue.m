//
//  NSString+TimeValue.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/18.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "NSString+TimeValue.h"

@implementation NSString (TimeValue)

+ (NSString *)timeValue:(NSString *)string{
    
    NSInteger year = [[string substringToIndex:4] integerValue];
    NSInteger month = [[string substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger day = [[string substringWithRange:NSMakeRange(8, 2)] integerValue];
    NSInteger hour = [[string substringWithRange:NSMakeRange(11, 2)] integerValue];
    NSInteger minute = [[string substringWithRange:NSMakeRange(14, 2)]integerValue];
    
    hour+=8;
    if (hour==24) {
        hour=0;
        day++;
        if (day==28&&month==2) {
            day=0;
            month++;
        }else if (day==30&&(month==4||month==6||month==9||month==11)){
            day=0;
            month++;
        }else if (day==31&&(month==1||month==3||month==5||month==7||month==8||month==10||month==12)){
            day=0;
            month++;
        }
    }
    if (month==13) {
        month=0;
        year++;
    }
    
    NSString *result = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld  %.2ld:%.2ld",year,month,day,hour,minute];
    
    return result;
}

@end
