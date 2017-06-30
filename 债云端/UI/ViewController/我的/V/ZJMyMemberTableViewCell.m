//  我的会员cell
//  ZJMyMemberTableViewCell.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/2.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyMemberTableViewCell.h"

@implementation ZJMyMemberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame=CGRectMake(0, 0, ZJAPPWidth, TRUE_1(100));
    // 我的会员前面图片
    _imageHeader.top = TRUE_1(25/2);
    _imageHeader.left = TRUE_1(30/2);
    _imageHeader.width = TRUE_1(50/2);
    _imageHeader.height = TRUE_1(50/2);
    _imageHeader.layer.masksToBounds = YES;
    _imageHeader.layer.cornerRadius = TRUE_1(25/2);
    
    // 我的会员
    _myMemeber.top = _imageHeader.top;
    _myMemeber.left = _imageHeader.right+TRUE_1(30/2);
    _myMemeber.width = TRUE_1(100);
    _myMemeber.height = _imageHeader.height;
    _myMemeber.font = ZJ_TRUE_FONT(28/2);
    // 分割线
    _centerXLine.top = self.frame.size.height/2;
    _centerXLine.left = 0;
    _centerXLine.width = ZJAPPWidth;
    _centerXLine.height = 1;
    
    
    // 推荐备案数
    _recommandLabel_1.top = _centerXLine.bottom+TRUE_1(3);
    _recommandLabel_1.left = 0;
    _recommandLabel_1.width = (ZJAPPWidth-TRUE_1(3))/4;
    _recommandLabel_1.height = self.frame.size.height/4;
    _recommandLabel_1.font = ZJ_TRUE_FONT(28/2);
    // 推荐备案数Label
    _recommandRecoardLabel.top = _recommandLabel_1.bottom-TRUE_1(7);
    _recommandRecoardLabel.left = 0;
    _recommandRecoardLabel.width = _recommandLabel_1.width;
    _recommandRecoardLabel.height = _recommandLabel_1.height;
    [_recommandRecoardLabel setFont:ZJ_TRUE_FONT(18/2)];
    // 整个button
    _recommandRecoardBut.top = _centerXLine.bottom;
    _recommandRecoardBut.left = 0;
    _recommandRecoardBut.width = _recommandLabel_1.width;
    _recommandRecoardBut.height = self.frame.size.height/2;
    // 分割线
    _imageline_1.top = _recommandLabel_1.top + TRUE_1(7);
    _imageline_1.left = _recommandRecoardBut.right;
    _imageline_1.width = TRUE_1(1);
    _imageline_1.height = self.frame.size.height/2 - TRUE_1(10)*2;
    _imageline_1.backgroundColor = ZJColor_dddddd;

    
    // 推荐行长数
    _recommandLabel_2.top = _recommandLabel_1.top;
    _recommandLabel_2.left = _imageline_1.right;
    _recommandLabel_2.width = _recommandLabel_1.width;
    _recommandLabel_2.height = _recommandLabel_1.height;
    _recommandLabel_2.font = ZJ_TRUE_FONT(28/2);

    //推荐行长数Label
    _recommandBankManger.top = _recommandRecoardLabel.top;
    _recommandBankManger.left = _imageline_1.right;
    _recommandBankManger.width = _recommandRecoardLabel.width;
    _recommandBankManger.height = _recommandRecoardLabel.height;
    _recommandBankManger.font = ZJ_TRUE_FONT(18/2);
    // 整个button
    _recommandBankBut.top = _centerXLine.bottom;
    _recommandBankBut.left = _imageline_1.right;
    _recommandBankBut.width = _recommandRecoardBut.width;
    _recommandBankBut.height = _recommandRecoardBut.height;
    // 分割线
    _imagelable_2.top = _imageline_1.top;
    _imagelable_2.left = _recommandBankBut.right;
    _imagelable_2.width = _imageline_1.width;
    _imagelable_2.height = _imageline_1.height;
    _imagelable_2.backgroundColor = ZJColor_dddddd;

    
    // 解债数
    _recommandLabel_3.top = _recommandLabel_2.top;
    _recommandLabel_3.left = _imagelable_2.right;
    _recommandLabel_3.width = _recommandLabel_2.width;
    _recommandLabel_3.height = _recommandLabel_2.height;
    _recommandLabel_3.font = ZJ_TRUE_FONT(28/2);

    //  解债数Label
    _dismissDebtCount.top = _recommandBankManger.top;
    _dismissDebtCount.left = _imagelable_2.right;
    _dismissDebtCount.width = _recommandBankManger.width;
    _dismissDebtCount.height = _recommandBankManger.height;
    _dismissDebtCount.font = ZJ_TRUE_FONT(18/2);
    //  整个button
    _dismissDebtBut.top = _centerXLine.bottom;
    _dismissDebtBut.left = _imagelable_2.right;
    _dismissDebtBut.width = _recommandBankBut.width;
    _dismissDebtBut.height = _recommandBankBut.height;
    // 分割线
    _imagelabel_3.top = _imagelable_2.top;
    _imagelabel_3.left = _dismissDebtCount.right;
    _imagelabel_3.width = _imagelable_2.width;
    _imagelabel_3.height = _imagelable_2.height;
    _imagelabel_3.backgroundColor = ZJColor_dddddd;

    // 解债数
    _recommandLabel_4.top = _recommandLabel_3.top;
    _recommandLabel_4.left = _imagelabel_3.right;
    _recommandLabel_4.width = _recommandLabel_3.width;
    _recommandLabel_4.height = _recommandLabel_3.height;
    _recommandLabel_4.font = ZJ_TRUE_FONT(28/2);

    //  解债数Label
    _recomMember.top = _dismissDebtCount.top;
    _recomMember.left = _imagelabel_3.right;
    _recomMember.width = _dismissDebtCount.width;
    _recomMember.height = _dismissDebtCount.height;
    _recomMember.font = ZJ_TRUE_FONT(18/2);
    //  整个button
    _recomMemberBut.top = _centerXLine.bottom;
    _recomMemberBut.left = _imagelabel_3.right;
    _recomMemberBut.width = _dismissDebtBut.width;
    _recomMemberBut.height = _dismissDebtBut.height;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
