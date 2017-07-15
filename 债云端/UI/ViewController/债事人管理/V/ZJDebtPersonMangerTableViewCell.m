//
//  ZJDebtPersonMangerTableViewCell.m
//  债云端
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtPersonMangerTableViewCell.h"
#define  Kheight  15
#define  Kwidth1  110
#define  Kwidth2  ZJAPPWidth-50-30-110
@implementation ZJDebtPersonMangerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(ZJDebtPersonMangerHomeItem *)item
{
    _item = item;
    //标志
    self.ImageFlag.top=10;
    self.ImageFlag.left=0;
    self.ImageFlag.width=50;
    self.ImageFlag.height=20;
    self.ImageFlagLabel.top=10;
    self.ImageFlagLabel.left=0;
    self.ImageFlagLabel.width=40;
    self.ImageFlagLabel.height=20;
    
    //第一排
    self.DebtPersonNameLabel.top=15;
    self.DebtPersonNameLabel.left=self.ImageFlag.right+10;
    self.DebtPersonNameLabel.width=Kwidth1;
    self.DebtPersonNameLabel.height=Kheight;
    
    self.DebtPersonNumLabel.top=40;
    self.DebtPersonNumLabel.left=self.DebtPersonNameLabel.left;
    self.DebtPersonNumLabel.width=Kwidth1;
    self.DebtPersonNumLabel.height=Kheight;
    
    self.DebtPersonTypeLabel.top=65;
    self.DebtPersonTypeLabel.left=self.DebtPersonNameLabel.left;
    self.DebtPersonTypeLabel.width=Kwidth1;
    self.DebtPersonTypeLabel.height=Kheight;

    //第二排
    self.DebtPersonNameTextLabel.top=self.DebtPersonNameLabel.top;
    self.DebtPersonNameTextLabel.left=self.DebtPersonNameLabel.right;
    self.DebtPersonNameTextLabel.width=Kwidth2;
    self.DebtPersonNameTextLabel.height=Kheight;
    
    self.DebtPersonNumTextLabel.top=self.DebtPersonNumLabel.top;
    self.DebtPersonNumTextLabel.left=self.DebtPersonNameTextLabel.left;
    self.DebtPersonNumTextLabel.width=Kwidth2;
    self.DebtPersonNumTextLabel.height=Kheight;
    
    if ([item.deptType isEqualToString:@"企业"]) {
        if (item.companyName.length>0) {
            self.DebtPersonNameTextLabel.text=item.companyName;
            self.DebtPersonNumTextLabel.text=item.companyidCode;
        }else{
            self.DebtPersonNameTextLabel.text=item.deptname;
            self.DebtPersonNumTextLabel.text=item.deptidCode;
        }
    }else{
        self.DebtPersonNameTextLabel.text=item.deptname;
        self.DebtPersonNumTextLabel.text=item.deptidCode;
    }
    
    
    
    self.DebtPersonTypeTextLabel.top=self.DebtPersonTypeLabel.top;
    self.DebtPersonTypeTextLabel.left=self.DebtPersonNameTextLabel.left;
    self.DebtPersonTypeTextLabel.width=Kwidth2;
    self.DebtPersonTypeTextLabel.height=Kheight;
    self.DebtPersonTypeTextLabel.text=item.deptType;
    
    self.lineView.top=94;
    self.lineView.left=0;
    self.lineView.height=1;
    self.lineView.width=ZJAPPWidth;
}

+ (CGFloat)getCellHeight
{
    return 95;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
