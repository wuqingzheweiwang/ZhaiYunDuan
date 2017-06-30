//
//  ZJDebtPersonMangerTableViewCell.h
//  债云端
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDebtPersonMangerItem.h"
@interface ZJDebtPersonMangerTableViewCell : UITableViewCell
@property (nonatomic, strong) ZJDebtPersonMangerHomeItem *item;

@property (weak, nonatomic) IBOutlet UIImageView *ImageFlag;
@property (weak, nonatomic) IBOutlet UILabel *ImageFlagLabel;
@property (weak, nonatomic) IBOutlet UILabel *DebtPersonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *DebtPersonNameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *DebtPersonNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *DebtPersonNumTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *DebtPersonTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *DebtPersonTypeTextLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


-(void)setitem:(ZJDebtPersonMangerHomeItem *)item;
+ (CGFloat)getCellHeight;
@end
