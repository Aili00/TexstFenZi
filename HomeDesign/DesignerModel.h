//
//  DesignerModel.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "JSONModel.h"

@class Professionals,DesignerImage;



@protocol Professionals <NSObject>

@end
@interface Professionals : JSONModel

@property (nonatomic)NSString<Optional> *flag;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, assign) NSInteger productLikeNum;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, assign) NSInteger ideabookNum;

@property (nonatomic, assign) NSInteger bookmarkNum;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, assign) NSInteger photoLikeNum;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, strong) DesignerImage *userImage;

@property (nonatomic, assign) NSInteger userType;

@property (nonatomic, assign) NSInteger followerNum;

@property (nonatomic, assign) NSInteger projectLikeNum;

@property (nonatomic, assign) NSInteger productNum;

@property (nonatomic, assign) NSInteger projectNum;

@property (nonatomic, strong) NSArray *serviceRange;

@property (nonatomic, copy) NSString *about;

@property (nonatomic, copy) NSString *aboutProfessional;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) NSInteger photoNum;

@property (nonatomic, assign) BOOL certified;

@property (nonatomic, assign) BOOL hasFollowed;

@property (nonatomic, copy) NSString *charge;

@property (nonatomic, assign) NSInteger followingNum;

@property (nonatomic, assign) BOOL hasFollowedOther;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger userId;

@end


@interface DesignerImage : JSONModel

@property (nonatomic, copy) NSString *small;

@property (nonatomic, copy) NSString *large;

@property (nonatomic, copy) NSString *medium;

@end


@interface DesignerModel : JSONModel

@property (nonatomic, strong) NSArray<Professionals> *professionals;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger start;

@end
