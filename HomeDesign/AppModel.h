//
//  AppModel.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/1.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

@property (nonatomic, assign) BOOL liked;

@property (nonatomic, assign) NSInteger style;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *stageShow;

@property (nonatomic, copy) NSString *buildingName;

@property (nonatomic, copy) NSString *costShow;

@property (nonatomic, assign) NSInteger likeNum;

@property (nonatomic, assign) NSInteger stage;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *areaShow;

@property (nonatomic, assign) NSInteger proceed;

@property (nonatomic, assign) NSInteger ModelId;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) NSInteger coverPhoto;

@property (nonatomic, assign) NSInteger roomStylePhotoId;

@property (nonatomic, copy) NSString *townName;

@property (nonatomic, copy) NSString *community;

@property (nonatomic, assign) NSInteger commentNum;

@property (nonatomic, copy) NSString *typeShow;

@property (nonatomic, assign) NSInteger cost;

@property (nonatomic, strong) NSArray *photos;

@property (nonatomic, copy) NSString *styleShow;

@property (nonatomic, assign) NSInteger area;

@property (nonatomic, copy) NSString *detailAddress;

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, assign) NSInteger isVisit;

@end


