//
//  ZJAddDemandTableViewCell.m
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAddDemandTableViewCell.h"
#define  Kheight  15
#define  Kwidth  80
#define  Kwidth3  ZJAPPWidth-60-80-15
@implementation ZJAddDemandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(ZJAddDemandInfoItem *)item
{
    //标志
    self.FlagImage.top=(120-15)/2;
    self.FlagImage.left=15;
    self.FlagImage.width=15;
    self.FlagImage.height=15;
    
    
    //第一排
    self.ZichanNameLabel.top=15;
    self.ZichanNameLabel.left=self.FlagImage.right+10;
    self.ZichanNameLabel.width=Kwidth;
    self.ZichanNameLabel.height=Kheight;
    
    self.numLabel.top=40;
    self.numLabel.left=self.ZichanNameLabel.left;
    self.numLabel.width=Kwidth;
    self.numLabel.height=Kheight;
    
    self.allpriceLabel.top=65;
    self.allpriceLabel.left=self.ZichanNameLabel.left;
    self.allpriceLabel.width=Kwidth;
    self.allpriceLabel.height=Kheight;
    
    self.LiutongPriceLabel.top=90;
    self.LiutongPriceLabel.left=self.ZichanNameLabel.left;
    self.LiutongPriceLabel.width=Kwidth;
    self.LiutongPriceLabel.height=Kheight;
    
    
    //第二排
    self.ZichanNameTextlabel.top=self.ZichanNameLabel.top;
    self.ZichanNameTextlabel.left=self.ZichanNameLabel.right;
    self.ZichanNameTextlabel.width=Kwidth3;
    self.ZichanNameTextlabel.height=Kheight;
    
    self.numTextlabel.top=self.numLabel.top;
    self.numTextlabel.left=self.numLabel.right;
    self.numTextlabel.width=Kwidth3;
    self.numTextlabel.height=Kheight;
    
    self.allpriceTextlabel.top=self.allpriceLabel.top;
    self.allpriceTextlabel.left=self.allpriceLabel.right;
    self.allpriceTextlabel.width=Kwidth3;
    self.allpriceTextlabel.height=Kheight;
    
    self.LiutongPriceTextlabel.top=self.LiutongPriceLabel.top;
    self.LiutongPriceTextlabel.left=self.LiutongPriceLabel.right;
    self.LiutongPriceTextlabel.width=Kwidth3;
    self.LiutongPriceTextlabel.height=Kheight;
    
    self.LineView.top=119;
    self.LineView.left=0;
    self.LineView.height=1;
    self.LineView.width=ZJAPPWidth;
}
+ (CGFloat)getCellHeight
{
    return 120;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
