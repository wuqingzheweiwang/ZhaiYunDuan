//
//  ZJDebtpersonDemandTableViewCell.h
//  债云端
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDebtPersonMangerItem.h"

@protocol DebtDemandInfoDelegate <NSObject>

@optional

- (void)DebtDemandEditActionWithItem:(ZJDemandInfoItem *)item;//编辑
- (void)DebtDemandDeleteActionWithItem:(ZJDemandInfoItem *)item; //删除
@end
@interface ZJDebtpersonDemandTableViewCell : UITableViewCell
@property (nonatomic, strong) ZJDemandInfoItem *item;
@property (nonatomic, strong) id<DebtDemandInfoDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *ImageFlag;
@property (weak, nonatomic) IBOutlet UILabel *ImageFlagLabel;

@property (weak, nonatomic) IBOutlet UILabel *capitalnamelabel;
@property (weak, nonatomic) IBOutlet UILabel *nummerlabel;
@property (weak, nonatomic) IBOutlet UILabel *allpricelabel;
@property (weak, nonatomic) IBOutlet UILabel *liutongpricelabel;

@property (weak, nonatomic) IBOutlet UILabel *capitalnametextlabel;
@property (weak, nonatomic) IBOutlet UILabel *nummertextlabel;
@property (weak, nonatomic) IBOutlet UILabel *allpricetextlabel;
@property (weak, nonatomic) IBOutlet UILabel *liutongpricetextlabel;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UIView *lIneview;


-(void)setitem:(ZJDemandInfoItem *)item;
+ (CGFloat)getCellHeight;

@end
