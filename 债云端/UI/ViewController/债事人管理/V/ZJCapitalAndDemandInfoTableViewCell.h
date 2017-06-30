//
//  ZJCapitalAndDemandInfoTableViewCell.h
//  债云端
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDebtPersonMangerItem.h"

@protocol DebtCapitalAndDemandInfoDelegate <NSObject>

@optional

- (void)DebtCapitalAndDemandEditActionWithItem:(ZJCapitalInfoItem *)item;//编辑
- (void)DebtCapitalAndDemandDeleteActionWithItem:(ZJCapitalInfoItem *)item; //删除
@end
@interface ZJCapitalAndDemandInfoTableViewCell : UITableViewCell
@property (nonatomic, strong) ZJCapitalInfoItem *item;
@property (nonatomic, strong) id<DebtCapitalAndDemandInfoDelegate> delegate;

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


-(void)setitem:(ZJCapitalInfoItem *)item;
+ (CGFloat)getCellHeight;

@end
