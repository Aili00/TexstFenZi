//
//  DiyModel.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"
@class Esarray,Detail,Comments;


@protocol Comments

@end
@interface Comments : JSONModel

@property (nonatomic, copy) NSString<Optional> *data;

@property (nonatomic, copy) NSString<Optional> *content;

@property (nonatomic, copy) NSString<Optional> *name;

@property (nonatomic, copy) NSString<Optional> *avatar;

@end


@protocol Detail <NSObject>

@end
@interface Detail : JSONModel

@property (nonatomic, copy) NSString<Optional> *pic;

@end


//@protocol Esarray <NSObject>
//
//@end
@interface Esarray : JSONModel

@property (nonatomic, copy) NSString<Optional> *theId;

@property (nonatomic, strong) NSArray<Optional,Comments> *comments;

@property (nonatomic, strong) NSArray<Optional,Detail> *detail;

@property (nonatomic, copy) NSString<Optional> *category;

@property (nonatomic, assign) NSInteger favs;

@property (nonatomic, copy) NSString<Optional> *title;

@property (nonatomic, copy) NSString<Optional> *thumb;//封面图片

@property (nonatomic, copy) NSString<Optional> *theDescription;

@property (nonatomic,copy)NSString<Optional> *flag;
@property (nonatomic,copy)NSString<Optional> *isLoved;

@end


@interface DiyModel : JSONModel

@property (nonatomic, strong) NSMutableArray<Optional> *esArray;

@end





