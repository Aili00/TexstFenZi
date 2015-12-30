//
//  IOSFunction.m
//  iOS_md5加密
//
//  Created by 张广洋 on 15/10/14.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "IOSFunction.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import "netdb.h"
#import <CommonCrypto/CommonCrypto.h>
#import <AdSupport/AdSupport.h>//idfa用的类库

#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

@implementation IOSFunction

#pragma mark - 获取EFUNCfUUID
+(NSString *)getUUID
{
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString =
    (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    return cfuuidString;
}

#pragma mark - 获取时间戳
+(NSString *)getTimeStamp
{
    double secondTime=[[[[NSDate alloc]init] autorelease]timeIntervalSince1970];
    double millisecondTime=secondTime*1000;
    NSString * millisecondTimeStr=[NSString stringWithFormat:@"%f",millisecondTime];
    NSRange pointRange=[millisecondTimeStr rangeOfString:@"."];
    NSString * MSTime=[millisecondTimeStr substringToIndex:pointRange.location];
    return MSTime;
}

#pragma mark - 获取当前iOS操作系统版本号
+(NSString *)getSystemVersion
{
    NSString * systemversion=[[UIDevice currentDevice] systemVersion];
    return systemversion;
}

#pragma mark - 获取当前设备类型
+(NSString *)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *deviceType = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return deviceType;
}
+(NSString *)getDeviceType
{
    NSString *deviceType = [self getDeviceVersion];
    //iPhone
    if ([deviceType isEqualToString:@"iPhone1,1"])
    {
        deviceType = @"iPhone";
    }
    else if ([deviceType isEqualToString:@"iPhone1,2"])
    {
        deviceType = @"iPhone_3G";
    }
    else if ([deviceType isEqualToString:@"iPhone2,1"])
    {
        deviceType = @"iPhone_3GS";
    }
    else if ([deviceType isEqualToString:@"iPhone3,1"])
    {
        deviceType = @"iPhone_4";
    }
    else if ([deviceType isEqualToString:@"iPhone4,1"])
    {
        deviceType = @"iPhone_4S";
    }
    else if ([deviceType isEqualToString:@"iPhone5,1"])
    {
        deviceType = @"iPhone_5";
    }
    else if ([deviceType isEqualToString:@"iPod4,1"])
    {
        deviceType = @"iPod_touch_4";
    }
    else if ([deviceType isEqualToString:@"iPad3,2"])
    {
        deviceType = @"iPad_3_3G";
    }
    else if ([deviceType isEqualToString:@"iPad3,1"])
    {
        deviceType = @"iPad_3_WiFi";
    }
    else if ([deviceType isEqualToString:@"iPad2,2"])
    {
        deviceType = @"iPad_2_3G";
    }
    else if ([deviceType isEqualToString:@"iPad2,1"])
    {
        deviceType = @"iPad_2_WiFi";
    }
    else if ([deviceType isEqualToString:@"iPod5,1"])
    {
        deviceType = @"iPod_touch_5";
    }
    else if ([deviceType isEqualToString:@"iPad2,5"])
    {
        deviceType = @"iPod_Mini";
    }

    return deviceType;
}

#pragma mark - 获取MAC地址
+(NSString *)getMacaddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    if ((mib[5] = if_nametoindex("en0")) == 0)
    {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
    {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    if ((buf = malloc(len)) == NULL)
    {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0)
    {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    //	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x",
    //                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

#pragma mark - 获取IDFA
+(NSString *)getIdfa
{
    NSString *idfaStr = nil;
    if ([[self getSystemVersion] intValue] >= 6)
    {
        idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    else
    {
        idfaStr = @"";
    }
    return idfaStr;
}

#pragma mark - 判断当前网络状态,是否联网
+(BOOL)connectedToNetWork
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        printf("Error.Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

#pragma mark - 获取项目配置信息
+(NSDictionary *)getProjectInfoPlist
{
    return [[NSBundle mainBundle]infoDictionary];
}

#pragma mark - - － － － － － － － －

#pragma mark - 进行md5加密
+(NSString *)getMD5StrFromString:(NSString *)beforeMD5String
{
    const char * cString = [beforeMD5String UTF8String];
    unsigned char result[16];
    CC_MD5(cString, (CC_LONG)strlen((const char *)cString), result);
    NSString *sign= [NSString stringWithFormat:
                     @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]
                     ];
    return [sign uppercaseString];
}

#pragma mark - 进行base64位转吗
+(NSString *)encode:(const uint8_t *)input length:(NSInteger)length
{
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t *)data.mutableBytes;
    for (NSInteger i = 0; i < length; i += 3)
    {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++)
        {
            value <<= 8;
            if (j < length)
            {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    table[(value >> 18) & 0x3F];
        output[index + 1] =                    table[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    return [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
}

#pragma mark - URL转码
+(NSString *)urlEcodingFromString:(NSString *)aString
{
    NSString *result =
    (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                        (CFStringRef)aString,
                                                        NULL,
                                                        (CFStringRef)@";/?:@&=$+{}<>,",
                                                        kCFStringEncodingUTF8);
    return result;
}


@end
