//
//  ZJMyZhangDanTableViewCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyZhangDanTableViewCell.h"
@implementation ZJMyZhangDanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
}


-(void)setitem:(ZJMyZhangDanHomeItem *)item
{
    _item = item;
    _weekLabel.top = TRUE_1(24/2);
    _weekLabel.left = TRUE_1(30/2);
    _weekLabel.width = TRUE_1(50/2);
    _weekLabel.height = (self.height - _weekLabel.top - TRUE_1(20))/2;
    _weekLabel.font = ZJ_TRUE_FONT(24/2);
    
    _monthLabel.top = _weekLabel.bottom+TRUE_1(30/2);
    _monthLabel.left = _weekLabel.left;
    _monthLabel.width = _weekLabel.width+TRUE_1(10);
    _monthLabel.height = _weekLabel.height+TRUE_1(10/2);
    _monthLabel.font = ZJ_TRUE_FONT(18/2);
    
    _imageViewH.top = TRUE_1(20/2);
    _imageViewH.left = _weekLabel.right +TRUE_1(30/2);
    _imageViewH.width = TRUE_1(60/2);
    _imageViewH.height = _imageViewH.width;
    
    _textLabelH.top = TRUE_1(20/2);
    _textLabelH.left = _imageViewH.right + TRUE_1(30/2);
    _textLabelH.width = TRUE_1(100);
    _textLabelH.height = (self.height - _weekLabel.top - TRUE_1(20/2))/2;
    _textLabelH.font = ZJ_TRUE_FONT(30/2);
    
    _detialTextLabel.top = _textLabelH.bottom+TRUE_1(20/2);
    _detialTextLabel.left = _textLabelH.left;
    _detialTextLabel.width = TRUE_1(200);
    _detialTextLabel.height = _textLabelH.height;
    _detialTextLabel.font = ZJ_TRUE_FONT(24/2);
    
    _speratyView.top = _detialTextLabel.bottom+TRUE_1(5);
    _speratyView.left = 0;
    _speratyView.width = ZJAPPWidth;
    _speratyView.height = 1;

}
+ (CGFloat)getCellHeight
{
    return TRUE_1(100/2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
