//
//  ZJBankCardTableViewCell.h
//  债云端
//
//  Created by 赵凯强 on 2017/5/7.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBankCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backgroundV;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *bankNameL;

@property (weak, nonatomic) IBOutlet UILabel *bankCardType;

@property (weak, nonatomic) IBOutlet UILabel *cardNumber;

@end
