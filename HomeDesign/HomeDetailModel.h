//
//  HomeDetailModel.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"

@class User,Userimage,Taskend,Projectstate,Space,Img;
@interface HomeDetailModel : JSONModel


@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, strong) User *user;

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

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) NSInteger coverPhoto;

@property (nonatomic, assign) NSInteger roomStylePhotoId;

@property (nonatomic, copy) NSString *townName;

@property (nonatomic, copy) NSString *community;

@property (nonatomic, assign) NSInteger commentNum;

@property (nonatomic, copy) NSString *typeShow;

@property (nonatomic, strong) NSArray *photos;

@property (nonatomic, copy) NSString *styleShow;

@property (nonatomic, strong) Taskend *taskEnd;

@property (nonatomic, assign) NSInteger area;

@property (nonatomic, assign) NSInteger cost;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, assign) NSInteger isVisit;

@property (nonatomic, copy) NSString *detailAddress;

@property (nonatomic, copy) NSString *description;

@end

@interface User : JSONModel

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, copy) NSString *charge;

@property (nonatomic, copy) NSString *about;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, assign) BOOL hasFollowedOther;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) BOOL hasFollowed;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, strong) Userimage *userImage;

@property (nonatomic, assign) BOOL certified;

@property (nonatomic, copy) NSString *account;

@end

@interface Userimage : JSONModel

@property (nonatomic, copy) NSString *small;

@property (nonatomic, copy) NSString *large;

@property (nonatomic, copy) NSString *medium;

@end

@interface Taskend : JSONModel

@property (nonatomic, strong) NSArray *space;

@property (nonatomic, strong) Projectstate *projectState;

@end

@interface Projectstate : JSONModel

@property (nonatomic, assign) NSInteger photoCount;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *proDescription;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger projectId;

@end

@interface Space : JSONModel

@property (nonatomic, strong) NSArray *img;

@property (nonatomic, copy) NSString *name;

@end

@interface Img : JSONModel

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *photoDescription;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, copy) NSString *photoId;

@property (nonatomic, assign) NSInteger height;

@end








