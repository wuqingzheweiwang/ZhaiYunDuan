//
//  ZJAddDemandTableViewCell.h
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDebtPersonMangerItem.h"

@interface ZJAddDemandTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *FlagImage;
@property (weak, nonatomic) IBOutlet UILabel *ZichanNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZichanNameTextlabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *numTextlabel;
@property (weak, nonatomic) IBOutlet UILabel *allpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *allpriceTextlabel;
@property (weak, nonatomic) IBOutlet UILabel *LiutongPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *LiutongPriceTextlabel;
@property (weak, nonatomic) IBOutlet UIView *LineView;

-(void)setitem:(ZJAddDemandInfoItem *)item;
+ (CGFloat)getCellHeight;
@end
