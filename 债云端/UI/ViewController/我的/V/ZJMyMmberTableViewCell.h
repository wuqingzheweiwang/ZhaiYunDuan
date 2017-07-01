//
//  ZJMyMmberTableViewCell.h
//  债云端
//
//  Created by 赵凯强 on 2017/6/23.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMyPageItem.h"

@interface ZJMyMmberTableViewCell : UITableViewCell
@property (nonatomic, strong) ZJReMyMemberHomeItem *item;

@property (weak, nonatomic) IBOutlet UIImageView *ImageFlag;
@property (weak, nonatomic) IBOutlet UILabel *ImageFlagLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumTextLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


-(void)setitem:(ZJReMyMemberHomeItem *)item;
+ (CGFloat)getCellHeight;

@end
