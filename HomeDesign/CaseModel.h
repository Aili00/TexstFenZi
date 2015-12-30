//
//  CaseModel.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/17.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "JSONModel.h"

@class Projects,Photos;


@protocol Photos <NSObject>

@end
@interface Photos : JSONModel

@property (nonatomic, assign) NSInteger thePhotoId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end



@protocol Projects <NSObject>

@end

@interface Projects : JSONModel

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

@property (nonatomic, assign) NSInteger theProjectsId;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) NSInteger coverPhoto;

@property (nonatomic, assign) NSInteger roomStylePhotoId;

@property (nonatomic, copy) NSString *townName;

@property (nonatomic, copy) NSString *community;

@property (nonatomic, assign) NSInteger commentNum;

@property (nonatomic, copy) NSString *typeShow;

@property (nonatomic, assign) NSInteger cost;

@property (nonatomic, strong) NSArray<Photos> *photos;

@property (nonatomic, copy) NSString *styleShow;

@property (nonatomic, assign) NSInteger area;

@property (nonatomic, copy) NSString *detailAddress;

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, assign) NSInteger isVisit;

@property (nonatomic, copy) NSString *theDescription;

@end




@interface CaseModel : JSONModel

@property (nonatomic, assign) NSInteger start;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<Projects> *projects;


@end
