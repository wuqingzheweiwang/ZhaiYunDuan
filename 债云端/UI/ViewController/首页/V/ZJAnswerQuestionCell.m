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
    self.textlabel.width = TRUE_1(65);
    self.textlabel.height = TRUE_1(15);
    
    self.detialTextALabel.top = self.textlabel.top;
    self.detialTextALabel.left = self.textlabel.right;
    self.detialTextALabel.width = ZJAPPWidth - self.textlabel.width - TRUE_1(30);
    self.detialTextALabel.height = self.textlabel.height;
    self.detialTextALabel.text = item.title;
    
    
    self.pushImage.top = self.detialTextALabel.top+TRUE_1(2);
    self.pushImage.right =ZJAPPWidth- TRUE_1(15);
    self.pushImage.width = TRUE_1(6);
    self.pushImage.height = TRUE_1(11);
    
    self.bottomLine.top = self.detialTextALabel.bottom+TRUE_1(15);
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
