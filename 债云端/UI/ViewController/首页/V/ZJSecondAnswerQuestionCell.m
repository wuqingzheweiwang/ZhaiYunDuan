//
//  ZJSecondAnswerQuestionCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/8/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJSecondAnswerQuestionCell.h"

@implementation ZJSecondAnswerQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setitem:(ZJAnswerQuestionModel *)item
{
    _item = item;
    
    self.textLanbel.top = TRUE_1(15);
    self.textLanbel.left = TRUE_1(15);
    self.textLanbel.width = ZJAPPWidth - TRUE_1(30) - self.pushImageV.width;
    self.textLanbel.height = TRUE_1(15);
    self.textLanbel.text = item.detialTitle;
    
    self.pushImageV.top = self.textLanbel.top;
    self.pushImageV.right = TRUE_1(15);
    self.pushImageV.width = TRUE_1(15);
    self.pushImageV.height = TRUE_1(15);
    
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
