//
//  ZJBankCardTableViewCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/7.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBankCardTableViewCell.h"

@implementation ZJBankCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _backgroundV.top = TRUE_1(40/2);
    _backgroundV.left = TRUE_1(125/2);
    _backgroundV.width = ZJAPPWidth - TRUE_1(125);
    _backgroundV.height = TRUE_1(200/2);
    _backgroundV.layer.masksToBounds = YES;
    _backgroundV.layer.cornerRadius = 5;

    
    _imageV.top = TRUE_1(30/2);
    _imageV.left = TRUE_1(30/2);
    _imageV.width = TRUE_1(60/2);
    _imageV.height = TRUE_1(60/2);
    
    _bankNameL.top = _imageV.top;
    _bankNameL.left = _imageV.right + TRUE_1(30/2);
    _bankNameL.width = _backgroundV.width - _backgroundV.left;
    _bankNameL.height = _imageV.height/2;
    _bankNameL.font = ZJ_TRUE_FONT_1(17);
    
    _bankCardType.top = _bankNameL.bottom+TRUE_1(10/2);
    _bankCardType.left = _bankNameL.left;
    _bankCardType.width =  _bankNameL.width;
    _bankCardType.height =  _bankNameL.height;
    _bankCardType.font = ZJ_TRUE_FONT(12);

    _cardNumber.top = _bankCardType.bottom +TRUE_1(40/2);
    _cardNumber.left = _imageV.right;
    _cardNumber.width = ZJAPPWidth - _cardNumber.left * 2;
    _cardNumber.height = _bankCardType.height;
    _cardNumber.font = ZJ_TRUE_FONT(15);

    self.frame = CGRectMake(0, 0, ZJAPPWidth, TRUE_1(240/2));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
