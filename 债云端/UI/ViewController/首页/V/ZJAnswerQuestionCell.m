//
//  ZJTeacherGraceCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/8/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAnswerQuestionCell.h"

@implementation ZJAnswerQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setitem:(ZJAnswerQuestionModel *)item
{
    _item = item;
   
    self.textlabel.top = TRUE_1(15);
    self.textlabel.left = TRUE_1(15);
    self.textlabel.width = TRUE_1(55);
    self.textlabel.height = TRUE_1(15);
    
    self.detialTextALabel.top = self.textlabel.top;
    self.detialTextALabel.left = self.textlabel.right;
    self.detialTextALabel.width = ZJAPPWidth - self.textlabel.width - TRUE_1(30);
    self.detialTextALabel.height = self.textlabel.height;
    self.detialTextALabel.text = item.title;
    
    self.pushImage.top = self.detailTextLabel.top;
    self.pushImage.right = TRUE_1(15);
    self.pushImage.width = TRUE_1(15);
    self.pushImage.height = TRUE_1(15);
    
    self.bottomLine.top = self.bottom;
    self.bottomLine.left = 0;
    self.bottomLine.width = ZJAPPWidth;
    self.bottomLine.height = 1;
}

+ (CGFloat)getCellHeight
{
    return TRUE_1(45);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
