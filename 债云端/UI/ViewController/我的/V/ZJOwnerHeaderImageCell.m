//
//  ZJOwnerHeaderImageCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/16.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJOwnerHeaderImageCell.h"

@implementation ZJOwnerHeaderImageCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _imageLabel_1.top = TRUE_1(65/2);
    _imageLabel_1.left = TRUE_1(30/2);
    _imageLabel_1.width = TRUE_1(70/2);
    _imageLabel_1.height = TRUE_1(160/2) - _imageLabel_1.top*2;
    _imageLabel_1.font = ZJ_TRUE_FONT(15);
    
    _imageLabel_2.top = TRUE_1(30/2);
    _imageLabel_2.left = TRUE_1(30/2);
    _imageLabel_2.width = TRUE_1(70/2);
    _imageLabel_2.height = TRUE_1(90/2) - _imageLabel_2.top*2;
    _imageLabel_2.font = ZJ_TRUE_FONT(15);

    // 头像
    _headerimageV.top = TRUE_1(10);
    _headerimageV.height = TRUE_1(160/2) - _headerimageV.top*2;
    _headerimageV.width = _headerimageV.height;
    _headerimageV.left = ZJAPPWidth -_imageLabel_1.left*2 - _headerimageV.width;
    _headerimageV.clipsToBounds=YES;
    _headerimageV.contentMode=UIViewContentModeScaleAspectFill;
    _headerimageV.layer.masksToBounds = YES;
    _headerimageV.layer.cornerRadius = _headerimageV.height/2;
    //  给头像加一个圆形边框
    _headerimageV.layer.borderWidth = 1.5f;
    _headerimageV.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // 姓名
    _namedetialLab.top = TRUE_1(35/2);
    _namedetialLab.width = TRUE_1(80);
    _namedetialLab.right = _headerimageV.right -_namedetialLab.width;
    _namedetialLab.height = TRUE_1(90/2) - _namedetialLab.top*2;
    
    _namedetialLab.textAlignment = NSTextAlignmentRight;
    _namedetialLab.font = ZJ_TRUE_FONT(12);
    
    _nextbut_1.top = _imageLabel_1.top;
    _nextbut_1.width = TRUE_1(6);
    _nextbut_1.height = TRUE_1(11);
    _nextbut_1.left = ZJAPPWidth- _nextbut_1.width*2 - TRUE_1(15/2);
    
    _nextbut_2.top = _imageLabel_2.top+TRUE_1(2);
    _nextbut_2.width = TRUE_1(6);
    _nextbut_2.height = TRUE_1(11);
    _nextbut_2.left = ZJAPPWidth- _nextbut_2.width*2- TRUE_1(15/2);
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
