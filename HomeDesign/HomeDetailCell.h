//
//  HomeDetailCell.h
//  HomeDesign
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 李彩玉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailModel.h"
#import "Define.h"

@interface HomeDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *topLine;


//@property (weak, nonatomic) IBOutlet UIView *leftLine;
//
//@property (weak, nonatomic) IBOutlet UIView *rightLine;
@property (weak, nonatomic) IBOutlet UIView *leftLine;

@property (weak, nonatomic) IBOutlet UIView *rightLine;


@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *firstImage;

@property (weak, nonatomic) IBOutlet UIImageView *otherImage;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier index:(NSInteger)index;

- (void)updataCellWithName:(NSString *)name imageUrl:(NSString *)url index:(NSInteger)index;
@end
