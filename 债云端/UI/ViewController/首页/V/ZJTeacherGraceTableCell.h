//
//  ZJTeacherGraceTableCell.h
//  债云端
//
//  Created by 赵凯强 on 2017/8/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJHomeItem.h"
@interface ZJTeacherGraceTableCell : UITableViewCell
@property (nonatomic, strong) ZJTeacherGraceModel *item;

@property (weak, nonatomic) IBOutlet UIImageView *ImageFlag;
@property (weak, nonatomic) IBOutlet UILabel *ImageFlagLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicaltitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *technicaltitleLabelTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceTextLabel;


-(void)setitem:(ZJTeacherGraceModel *)item;
+ (CGFloat)getCellHeight;

@end
