//
//  ZJReCommandBankCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/6/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJReCommandBankCell.h"
#define  Kheight  TRUE_1(15)
#define  Kwidth1  TRUE_1(80)
#define  Kwidth2  ZJAPPWidth-TRUE_1(50)-TRUE_1(30)-TRUE_1(60)
@implementation ZJReCommandBankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setitem:(ZJRecomBankHomeItem *)item
{
    _item = item;
    //标志
    self.ImageFlag.top=TRUE_1(10);
    self.ImageFlag.left=0;
    self.ImageFlag.width=TRUE_1(50);
    self.ImageFlag.height=TRUE_1(20);
    
    self.ImageFlagLabel.top=TRUE_1(10);
    self.ImageFlagLabel.left=0;
    self.ImageFlagLabel.width=TRUE_1(40);
    self.ImageFlagLabel.height=TRUE_1(20);
    
    //第一排
    self.nameLabel.top=TRUE_1(15);
    self.nameLabel.left=self.ImageFlag.right+TRUE_1(10);
    self.nameLabel.width=Kwidth1;
    self.nameLabel.height=Kheight;
    self.nameLabel.font = ZJ_TRUE_FONT(15);
    
    self.phoneNumberLabel.top= self.nameLabel.bottom + TRUE_(10);
    self.phoneNumberLabel.left=self.nameLabel.left;
    self.phoneNumberLabel.width=Kwidth1;
    self.phoneNumberLabel.height=Kheight;
    self.phoneNumberLabel.font = ZJ_TRUE_FONT(15);
    
    self.adressLabel.top = self.phoneNumberLabel.bottom+ TRUE_(10);
    self.adressLabel.left = self.phoneNumberLabel.left;
    self.adressLabel.width = Kwidth1;
    self.adressLabel.height = Kheight;
    self.adressLabel.font = ZJ_TRUE_FONT(15);
    
    self.debtTypeLabel.top = self.adressLabel
    .bottom+ TRUE_(10);
    self.debtTypeLabel.left = self.adressLabel.left;
    self.debtTypeLabel.width = Kwidth1;
    self.debtTypeLabel.height = Kheight;
    self.debtTypeLabel.font = ZJ_TRUE_FONT(15);
    
    //第二排
    self.NameTextLabel.top=self.nameLabel.top;
    self.NameTextLabel.left=self.nameLabel.right;
    self.NameTextLabel.width=Kwidth2;
    self.NameTextLabel.height=Kheight;
    self.NameTextLabel.font = ZJ_TRUE_FONT(15);
    self.NameTextLabel.text=item.realName;
    
    self.phoneNumTextLabel.top=self.phoneNumberLabel.top;
    self.phoneNumTextLabel.left=self.phoneNumberLabel.right;
    self.phoneNumTextLabel.width=Kwidth2;
    self.phoneNumTextLabel.height=Kheight;
    self.phoneNumTextLabel.font = ZJ_TRUE_FONT(15);
    self.phoneNumTextLabel.text=item.phoneNumber;

    self.adressTextLabel.top=self.adressLabel.top;
    self.adressTextLabel.left=self.adressLabel.right;
    self.adressTextLabel.width=Kwidth2;
    self.adressTextLabel.height=Kheight;
    self.adressTextLabel.font = ZJ_TRUE_FONT(15);
    self.adressTextLabel.text=item.address;
    
    self.debtTextTypeLabel.top=self.debtTypeLabel.top;
    self.debtTextTypeLabel.left=self.debtTypeLabel.right;
    self.debtTextTypeLabel.width=Kwidth2;
    self.debtTextTypeLabel.height=Kheight;
    self.debtTextTypeLabel.font = ZJ_TRUE_FONT(15);
    self.debtTextTypeLabel.text=item.type;
    
    self.lineView.top= self.debtTextTypeLabel.bottom+TRUE_1(10);
    self.lineView.left=0;
    self.lineView.height=TRUE_1(1);
    self.lineView.width=ZJAPPWidth;
}
+ (CGFloat)getCellHeight
{
    return TRUE_1(120);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
