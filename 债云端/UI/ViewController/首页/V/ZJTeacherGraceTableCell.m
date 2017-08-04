//
//  ZJTeacherGraceTableCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/8/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJTeacherGraceTableCell.h"
#define  Kheight  15
#define  Kwidth1  40
#define  Kwidth2  ZJAPPWidth-50-30-40

@implementation ZJTeacherGraceTableCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(ZJTeacherGraceModel *)item
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
    self.NameLabel.top=15;
    self.NameLabel.left=self.ImageFlag.right+10;
    self.NameLabel.width=Kwidth1;
    self.NameLabel.height=Kheight;
    
    self.technicaltitleLabel.top=40;
    self.technicaltitleLabel.left=self.NameLabel.left;
    self.technicaltitleLabel.width=Kwidth1;
    self.technicaltitleLabel.height=Kheight;
    
    self.introduceLabel.top=65;
    self.introduceLabel.left=self.technicaltitleLabel.left;
    self.introduceLabel.width=Kwidth1;
    self.introduceLabel.height=Kheight;
    
    //第二排
    self.NameTextLabel.top=self.NameLabel.top;
    self.NameTextLabel.left=self.NameLabel.right;
    self.NameTextLabel.width=Kwidth2;
    self.NameTextLabel.height=Kheight;
    self.NameTextLabel.text=item.title;

    self.technicaltitleLabelTextLabel.top=self.technicaltitleLabel.top;
    self.technicaltitleLabelTextLabel.left=self.NameTextLabel.left;
    self.technicaltitleLabelTextLabel.width=Kwidth2;
    self.technicaltitleLabelTextLabel.height=Kheight;
    self.technicaltitleLabelTextLabel.text=item.detialtitle;

    
    self.introduceTextLabel.top=self.introduceLabel.top;
    self.introduceTextLabel.left=self.introduceLabel.left;
    self.introduceTextLabel.width=Kwidth2;
    self.introduceTextLabel.height=Kheight;
    self.introduceTextLabel.text=item.introduceText;
    
}

+ (CGFloat)getCellHeight
{
    return TRUE_1(105);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
