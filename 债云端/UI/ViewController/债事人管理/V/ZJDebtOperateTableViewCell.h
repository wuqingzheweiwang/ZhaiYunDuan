//
//  ZJDebtOperateTableViewCell.h
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDebtPersonMangerItem.h"

@protocol DebtOperateInfoDelegate <NSObject>  //股权信息删除

@optional

- (void)DebtOperateDeleteActionWithItem:(ZJOperateInfoItem *)item; //删除
@end
@interface ZJDebtOperateTableViewCell : UITableViewCell
@property (nonatomic, strong) ZJOperateInfoItem *item;
@property (nonatomic, strong) id<DebtOperateInfoDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *ImageFlag;
@property (weak, nonatomic) IBOutlet UILabel *ImageFlagLabel;

@property (weak, nonatomic) IBOutlet UILabel *corporatenamelabel;   //法人名称
@property (weak, nonatomic) IBOutlet UILabel *taxnumberlabel;     //税号
@property (weak, nonatomic) IBOutlet UILabel *corporatephonelabel;        //法人电话
@property (weak, nonatomic) IBOutlet UILabel *addresslabel;   //地址
@property (weak, nonatomic) IBOutlet UILabel *lastyearsaleslabel;     //上年度销售额
@property (weak, nonatomic) IBOutlet UILabel *allsaleslabel;  //总收入
@property (weak, nonatomic) IBOutlet UILabel *annualtarifflabel;    //年度电费
@property (weak, nonatomic) IBOutlet UILabel *subordinateyearlabel;     //所属年度
@property (weak, nonatomic) IBOutlet UILabel *profitmarginlabel;  //利润率
@property (weak, nonatomic) IBOutlet UILabel *totalinvestmentlabel;    //总投资

@property (weak, nonatomic) IBOutlet UILabel *corporatenametextlabel;   //法人名称
@property (weak, nonatomic) IBOutlet UILabel *taxnumbertextlabel;     //税号
@property (weak, nonatomic) IBOutlet UILabel *corporatephonetextlabel;        //法人电话
@property (weak, nonatomic) IBOutlet UILabel *addresstextlabel;   //地址
@property (weak, nonatomic) IBOutlet UILabel *lastyearsalestextlabel;     //上年度销售额
@property (weak, nonatomic) IBOutlet UILabel *allsalestextlabel;  //总收入
@property (weak, nonatomic) IBOutlet UILabel *annualtarifftextlabel;    //年度电费
@property (weak, nonatomic) IBOutlet UILabel *subordinateyeartextlabel;     //所属年度
@property (weak, nonatomic) IBOutlet UILabel *profitmargintextlabel;  //利润率
@property (weak, nonatomic) IBOutlet UILabel *totalinvestmenttextlabel;    //总投资

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UIView *lIneview;


-(void)setitem:(ZJOperateInfoItem *)item;
+ (CGFloat)getCellHeight;

@end
