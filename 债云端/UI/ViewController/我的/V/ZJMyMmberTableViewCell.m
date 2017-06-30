//
//  ZJMyMmberTableViewCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/6/23.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyMmberTableViewCell.h"
#define  Kheight  TRUE_1(15)
#define  Kwidth1  TRUE_1(70)
#define  Kwidth2  ZJAPPWidth-TRUE_1(50)-TRUE_1(30)-TRUE_1(60)
@implementation ZJMyMmberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   

}
-(void)setitem:(ZJMyMemberHomeItem *)item
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
    
    self.phoneNumberLabel.top=self.nameLabel.bottom+TRUE_1(10);
    self.phoneNumberLabel.left=self.nameLabel.left;
    self.phoneNumberLabel.width=Kwidth1;
    self.phoneNumberLabel.height=Kheight;
    self.phoneNumberLabel.font = ZJ_TRUE_FONT(15);

    //第二排
    self.NameTextLabel.top=self.nameLabel.top;
    self.NameTextLabel.left=self.nameLabel.right;
    self.NameTextLabel.width=Kwidth2;
    self.NameTextLabel.height=Kheight;
    self.NameTextLabel.font = ZJ_TRUE_FONT(15);
//    self.NameTextLabel.text=item.deptname;
    
    self.phoneNumTextLabel.top=self.phoneNumberLabel.top;
    self.phoneNumTextLabel.left=self.phoneNumberLabel.right;
    self.phoneNumTextLabel.width=Kwidth2;
    self.phoneNumTextLabel.height=Kheight;
    self.phoneNumTextLabel.font = ZJ_TRUE_FONT(15);
//    self.phoneNumTextLabel.text=item.deptidCode;
    
    
    self.lineView.top= self.phoneNumTextLabel.bottom +TRUE_1(5);
    self.lineView.left=0;
    self.lineView.height=TRUE_1(1);
    self.lineView.width=ZJAPPWidth;
}
+ (CGFloat)getCellHeight
{
    return TRUE_1(60);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
