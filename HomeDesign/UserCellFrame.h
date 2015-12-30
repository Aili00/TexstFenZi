//
//  UserCellFrame.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiyModel.h"

@interface UserCellFrame : NSObject

@property (nonatomic)Comments *commModel;
@property (nonatomic)CGRect iconRect;
@property (nonatomic)CGRect nameRect;
@property (nonatomic)CGRect timeRect;
@property (nonatomic)CGRect contentRect;
@property (nonatomic)CGFloat rowHeight;


- (instancetype)initFrameWithModel:(Comments *)commModel;


+ (NSMutableArray *)getCellFrameListWith:(Esarray *)esaModel;
@end
