//
//  ZJAddOperateTableViewCell.m
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAddOperateTableViewCell.h"

@implementation ZJAddOperateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.left=15;
    self.titleLabel.top=20;
    self.titleLabel.height=33;
    self.titleLabel.width=110;
    self.titleLabel.textColor=ZJColor_333333;
    self.InfotextFiled.top= self.titleLabel.top;
    self.InfotextFiled.left=15+110+5;
    self.InfotextFiled.height=33;
    self.InfotextFiled.width=ZJAPPWidth-15-110-5-15;
    self.InfotextFiled.layer.masksToBounds=YES;
    self.InfotextFiled.layer.cornerRadius=5;
    self.InfotextFiled.layer.borderColor=ZJColor_cccccc.CGColor;
    self.InfotextFiled.layer.borderWidth=1;
    self.InfotextFiled.textColor=ZJColor_333333;
    self.InfotextFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.InfotextFiled.frame.size.height)];
    self.InfotextFiled.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
