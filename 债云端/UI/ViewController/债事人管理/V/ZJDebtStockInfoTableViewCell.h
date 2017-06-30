//
//  ZJDebtStockInfoTableViewCell.h
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDebtPersonMangerItem.h"

@protocol DebtStockInfoDelegate <NSObject>  //股权信息删除

@optional

- (void)DebtStockDeleteActionWithItem:(ZJStockInfoItem *)item; //删除
@end
@interface ZJDebtStockInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) ZJStockInfoItem *item;
@property (nonatomic, strong) id<DebtStockInfoDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *ImageFlag;
@property (weak, nonatomic) IBOutlet UILabel *ImageFlagLabel;

@property (weak, nonatomic) IBOutlet UILabel *stockholdernamelabel;
@property (weak, nonatomic) IBOutlet UILabel *certificatelabel;
@property (weak, nonatomic) IBOutlet UILabel *addersslabel;
@property (weak, nonatomic) IBOutlet UILabel *investmentlabel;   //投资金额
@property (weak, nonatomic) IBOutlet UILabel *registcapitallabel;     //注册资本
@property (weak, nonatomic) IBOutlet UILabel *ratioinvestmentsinlabel;  //投资比例
@property (weak, nonatomic) IBOutlet UILabel *realcapitallabel;    //实到资本

@property (weak, nonatomic) IBOutlet UILabel *stockholdernametextlabel;
@property (weak, nonatomic) IBOutlet UILabel *certificatetextlabel;
@property (weak, nonatomic) IBOutlet UILabel *addersstextlabel;
@property (weak, nonatomic) IBOutlet UILabel *investmenttextlabel;   //投资金额
@property (weak, nonatomic) IBOutlet UILabel *registcapitaltextlabel;     //注册资本
@property (weak, nonatomic) IBOutlet UILabel *ratioinvestmentsintextlabel;  //投资比例
@property (weak, nonatomic) IBOutlet UILabel *realcapitaltextlabel;    //实到资本

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UIView *lIneview;


-(void)setitem:(ZJStockInfoItem *)item;
+ (CGFloat)getCellHeight;


@end
