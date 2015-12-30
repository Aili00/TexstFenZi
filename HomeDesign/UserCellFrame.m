//
//  UserCellFrame.m
//  HomeDesign
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import "UserCellFrame.h"
#import "NSString+Size.h"
@implementation UserCellFrame

- (instancetype)initFrameWithModel:(Comments *)commModel{
    
    if (self = [super init]) {
        
        self.commModel = commModel;
        
        CGFloat gap = 10;
        self.iconRect = CGRectMake( 8, 8, 30, 30);
        
        CGFloat nameX = CGRectGetMaxX(self.iconRect)+gap;
        CGFloat nameW = 100;
        CGFloat nameH = 21;
        self.nameRect = CGRectMake(nameX, 8, nameW, nameH);
        
        CGFloat timeX = nameX;
        CGFloat timeY = CGRectGetMaxY(self.nameRect);
        CGFloat timeW = nameW;
        CGFloat timeH = 15;
        self.timeRect = CGRectMake(timeX, timeY, timeW, timeH);
        
        CGFloat contentX = nameX;
        CGFloat contentY = CGRectGetMaxY(self.timeRect)+gap;
        //CGFloat contentW = nameW;
        CGSize contentSize = [commModel.content boundingRectWithSize:CGSizeMake(kScreenWidth-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
        self.contentRect = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
        
        self.rowHeight = CGRectGetMaxY(self.contentRect)+gap;
    }
    return self;
}

+ (NSMutableArray *)getCellFrameListWith:(Esarray *)esaModel{
    NSMutableArray *lists = [[NSMutableArray alloc]init];
    for (Comments *item in esaModel.comments) {
        UserCellFrame *frame = [[UserCellFrame alloc]initFrameWithModel:item];
        [lists addObject:frame];
    }
    
    return lists;
}

@end
