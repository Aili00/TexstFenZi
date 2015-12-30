//
//  IOSFunction.h
//  iOS_md5加密
//
//  Created by 张广洋 on 15/10/14.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface IOSFunction : NSObject

#pragma mark - 获取参数
/**
 *	@brief	获取唯一标示
 *
 *	@return	一个字符串，该字符串是由代码获取cfuuid唯一随机字符串，
 然后把给字符串保存在共有的keychain中，保证唯一性的唯一识别字符串。
 样例：328DCE39-C501-4195-B2CC-E2CEB069FAB0
 */
+(NSString *)getUUID;


/**
 *	@brief	获取当前iOS操作系统的版本号
 *
 *	@return	字符串形式返回当前系统的版本号,样例：“7.0”
 */
+(NSString *)getSystemVersion;


/**
 *	@brief	获取设备类型
 *
 *	@return	设备类型的字符串：样例："iPod_touch_5"
 */
+(NSString *)getDeviceType;


/**
 *	@brief	获取当前设备的mac地址 iOS7以下有效，iOS7以上也能使用，但是值都是一样的。
 *
 *	@return	返回设备的mac地址，样例："70:11:24:4B:2B:5C"
 */
+(NSString *)getMacaddress;


/**
 *	@brief	获取设备的广告标示，通过设置，可以修改的一个标记，一般情况下不会变动。
 可以跨应用，跨开发者访问。调用 ADSupport框架。只支持iOS6.0以上版本。
 *
 *	@return	一串广告标示字符串，样例：“B9031A0C-0E66-40EE-ACA4-3CCB30DB9F49”
 */
+(NSString *)getIdfa;


/**
 *	@brief	获取项目配置文件的配置信息
 *
 *	@return	字典Info.plist的内容
 */
+(NSDictionary *)getProjectInfoPlist;




#pragma mark - 常用基本方法


/**
 *	@brief	MD5加密方法
 *
 *	@param 	beforeMD5String 	加密前的MD5字符串
 *
 *	@return	加密以后的MD5字符串
 */
+(NSString *)getMD5StrFromString:(NSString *)beforeMD5String;


/**
 *	@brief	64位编码
 *
 *	@param 	input 	64编码前的数据
 *	@param 	length 	64位编码前的数据长度
 *
 *	@return	64位编码以后的字符串。
 */
+(NSString *)encode:(const uint8_t *)input length:(NSInteger)length;


/**
 *	@brief	进行URL转码的方法
 *
 *	@param 	aString 	需要进行URL转吗的字符串
 *
 *	@return	URL转码以后的字符串
 */
+(NSString *)urlEcodingFromString:(NSString *)aString;

@end
