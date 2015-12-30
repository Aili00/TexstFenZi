//
//  CaseCell.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/17.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CaseModel.h"
#import "DesignerModel.h"


@interface CaseCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *detail;

@property (weak, nonatomic) IBOutlet UILabel *about;

@property (weak, nonatomic) IBOutlet UIImageView *caseImage;

@property (weak, nonatomic) IBOutlet UILabel *likeNum;

- (void)updateWithData:(Projects *)Projects;
   
   
@end
