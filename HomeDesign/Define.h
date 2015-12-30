//
//  Define.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/6.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#ifndef HomeDesign_Define_h
#define HomeDesign_Define_h


#pragma mark   第三方库头文件--------------------------

#import <AFNetworking/AFNetworking.h>
#import <UIKit+AFNetworking.h>

#import "MJRefresh.h"
#import <JSONModel/JSONModel.h>
#import "UIImageView+WebCache.h"

#pragma mark   自定义类头文件--------------------------

#import "CaseModel.h"
#import "AppModel.h"
#import "AppModelStore.h"
#import "NetworkingManager.h"
#import "AppViewController.h"
#import "HomeDetailViewController.h"


#import "UIImage+Resize.h"
#import "UIView+Size.h"

//获取首页图片拼接路径
#import "GetImageUrl.h"

#pragma mark   宏定义--------------------------

#define kScreenSize [UIScreen mainScreen].bounds.size
#define kScreenWidth kScreenSize.width
#define kScreenHeight kScreenSize.height

#define kTabBarHeight 49
#define kNCHeight 64


#pragma mark   接口--------------------------

//首页
#define kHomeUrl @"http://api.guju.com.cn/v2/project/list?&start=%ld&count=10"
//http://api.guju.com.cn/v2/project/25034/v2?userId=0
//首页图片
#define kHomeImageUrl @"http://gooju.cn/dimages/%ld_0_w608_h0_m0.jpg"

//#define kHomeDetailUrl @"http://api.guju.com.cn/v2/project/%ld/v2"
//首页详情
#define kHomeDetailUrl @"http://api.guju.com.cn/v2/project/%ld/v2?userId=0"

//创意生活
#define KDiyCommonUrl @"http://106.187.100.229:8090/api/design/%@/comment"
//设计师
#define kDesignerUrl @"http://api.guju.com.cn/v2/user/professionals?start=%ld&count=12&user=null&city=%@"
//设计师案例
#define kCaseUrl @"http://api.guju.com.cn/v2/user/%@/projects?start=%ld&count=%ld&user=null&"



#pragma mark   页面类型--------------------------
//首页
#define kHomeType @"home"
//首页详情页
#define kHomeDetailType @"homeDetail"
//设计师首页
#define kDesignerType @"designer"

//设计师多案例页
#define kDesingerCaseType @"desingerCase"

#endif
