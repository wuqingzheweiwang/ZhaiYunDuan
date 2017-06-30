//
//  ZJPersonBaseInfoTableViewCell.h
//  债云端
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDebtPersonMangerItem.h"

@interface ZJPersonBaseInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *InfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *InfoTextLabel;


-(void)setitem:(NSDictionary *)item;
+ (CGFloat)getCellHeight;
@end
