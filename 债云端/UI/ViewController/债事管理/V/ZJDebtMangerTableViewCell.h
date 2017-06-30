//
//  ZJDebtMangerTableViewCell.h
//  债云端
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDebtMangerItem.h"
@protocol DebtMangerHomeDelegate <NSObject>

@optional

- (void)DebtMangerHomePayActionWithItem:(ZJDebtMangerHomeItem *)item;
- (void)DebtMangerHomeSeeDetailActionWithItem:(ZJDebtMangerHomeItem *)item;
@end
@interface ZJDebtMangerTableViewCell : UITableViewCell
@property (nonatomic, strong) ZJDebtMangerHomeItem *item;
@property (nonatomic, strong) id<DebtMangerHomeDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *ImageFlag;
@property (weak, nonatomic) IBOutlet UILabel *ImageFlagLabel;

@property (weak, nonatomic) IBOutlet UILabel *Lurushijian1;
@property (weak, nonatomic) IBOutlet UILabel *Zhaiquanren1;
@property (weak, nonatomic) IBOutlet UILabel *Zhaiwuren1;
@property (weak, nonatomic) IBOutlet UILabel *Zhutijine1;

@property (weak, nonatomic) IBOutlet UILabel *LuruTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZhaiquanrenTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZhaiwurenTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *MoneyTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *alreadPostLabel;
@property (weak, nonatomic) IBOutlet UILabel *alreadSolvedLabel;
@property (weak, nonatomic) IBOutlet UILabel *alreadPayLabel;
@property (weak, nonatomic) IBOutlet UIButton *PayBtn;
@property (weak, nonatomic) IBOutlet UIButton *SeeDetailBtn;

@property (weak, nonatomic) IBOutlet UIView *lIneview;



-(void)setitem:(ZJDebtMangerHomeItem *)item;
+ (CGFloat)getCellHeight;
@end
