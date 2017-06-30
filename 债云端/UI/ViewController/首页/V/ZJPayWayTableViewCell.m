//
//  ZJPayWayTableViewCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/4/28.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJPayWayTableViewCell.h"

@implementation ZJPayWayTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];

    _imageV.top = (self.height -_imageV.height)/2;
    _imageV.left = TRUE_1(60);
    _imageV.width = TRUE_1(60);
    _imageV.height = TRUE_1(60);
    
    

    _textLab.top = _imageV.top;
    _textLab.left = _imageV.right+TRUE_1(20/2);
    _textLab.width = TRUE_1(140);
    _textLab.height = _imageV.height;
    _textLab.font = ZJ_TRUE_FONT(12);
    
    _selectBut.top = _textLab.top;
    _selectBut.right = ZJAPPWidth - TRUE_1(60/2);
    _selectBut.width = TRUE_1(40/2);
    _selectBut.height = TRUE_1(40/2);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
