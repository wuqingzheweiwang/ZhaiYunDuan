//
//  ZJAddEditCapitalTableViewCell.m
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAddEditCapitalTableViewCell.h"

@implementation ZJAddEditCapitalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.left=15;
    self.titleLabel.top=20;
    self.titleLabel.height=33;
    self.titleLabel.width=140;
    self.titleLabel.textColor=ZJColor_333333;
    self.InfotextFiled.top= self.titleLabel.top;
    self.InfotextFiled.left=15+140+5;
    self.InfotextFiled.height=33;
    self.InfotextFiled.width=ZJAPPWidth-15-140-5-15;
    self.InfotextFiled.layer.masksToBounds=YES;
    self.InfotextFiled.layer.cornerRadius=5;
    self.InfotextFiled.layer.borderColor=ZJColor_cccccc.CGColor;
    self.InfotextFiled.layer.borderWidth=1;
    self.InfotextFiled.textColor=ZJColor_333333;
    self.InfotextFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.InfotextFiled.frame.size.height)];
    self.InfotextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.FirstBtn.top=20;
    self.FirstBtn.left=15+140+5;
    self.FirstBtn.width=80;
    self.FirstBtn.height=33;
    self.FirstBtn.hidden=YES;
    self.SecondBtn.top=20;
    self.SecondBtn.left=15+140+(ZJAPPWidth-15-140)/2;
    self.SecondBtn.width=80;
    self.SecondBtn.height=33;
    self.SecondBtn.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
