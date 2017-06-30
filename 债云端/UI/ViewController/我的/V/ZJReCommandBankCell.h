//
//  ZJReCommandBankCell.h
//  债云端
//
//  Created by 赵凯强 on 2017/6/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMyPageItem.h"
@interface ZJReCommandBankCell : UITableViewCell

@property (nonatomic, strong) ZJRecomBankHomeItem *item;

@property (weak, nonatomic) IBOutlet UIImageView *ImageFlag;
@property (weak, nonatomic) IBOutlet UILabel *ImageFlagLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *debtTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *debtTextTypeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


-(void)setitem:(ZJRecomBankHomeItem *)item;
+ (CGFloat)getCellHeight;


@end
