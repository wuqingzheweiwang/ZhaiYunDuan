//
//  ZJCapitalAndDemandInfoTableViewCell.m
//  债云端
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJCapitalAndDemandInfoTableViewCell.h"
#define  Kheight  15
#define  Kwidth1  80
#define  Kwidth2  200
#define  Kwidth3  40
@implementation ZJCapitalAndDemandInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(ZJCapitalInfoItem *)item
{
     _item = item;
    //标志
    self.ImageFlag.top=10;
    self.ImageFlag.left=0;
    self.ImageFlag.width=50;
    self.ImageFlag.height=20;
    self.ImageFlagLabel.top=10;
    self.ImageFlagLabel.left=0;
    self.ImageFlagLabel.width=40;
    self.ImageFlagLabel.height=20;
    
    //第一排
    self.capitalnamelabel.top=15;
    self.capitalnamelabel.left=self.ImageFlag.right+10;
    self.capitalnamelabel.width=Kwidth1;
    self.capitalnamelabel.height=Kheight;
    
    self.nummerlabel.top=40;
    self.nummerlabel.left=self.capitalnamelabel.left;
    self.nummerlabel.width=Kwidth1;
    self.nummerlabel.height=Kheight;
    
    self.allpricelabel.top=65;
    self.allpricelabel.left=self.capitalnamelabel.left;
    self.allpricelabel.width=Kwidth1;
    self.allpricelabel.height=Kheight;
    
    self.liutongpricelabel.top=90;
    self.liutongpricelabel.left=self.capitalnamelabel.left;
    self.liutongpricelabel.width=Kwidth1;
    self.liutongpricelabel.height=Kheight;

    
    //第二排
    self.capitalnametextlabel.top=self.capitalnamelabel.top;
    self.capitalnametextlabel.left=self.capitalnamelabel.right;
    self.capitalnametextlabel.width=Kwidth2;
    self.capitalnametextlabel.height=Kheight;
    self.capitalnametextlabel.text=item.capitalname;
    
    self.nummertextlabel.top=self.nummerlabel.top;
    self.nummertextlabel.left=self.capitalnametextlabel.left;
    self.nummertextlabel.width=Kwidth2;
    self.nummertextlabel.height=Kheight;
    self.nummertextlabel.text=item.assetNum;
    
    self.allpricetextlabel.top=self.allpricelabel.top;
    self.allpricetextlabel.left=self.capitalnametextlabel.left;
    self.allpricetextlabel.width=Kwidth2;
    self.allpricetextlabel.height=Kheight;
    self.allpricetextlabel.text=item.totalAmout;
    
    self.liutongpricetextlabel.top=self.liutongpricelabel.top;
    self.liutongpricetextlabel.left=self.capitalnametextlabel.left;
    self.liutongpricetextlabel.width=Kwidth2;
    self.liutongpricetextlabel.height=Kheight;
    if (item.tradeableAssets.length>0) {
        self.liutongpricetextlabel.text=item.tradeableAssets;
    }
    
    //第三排
    
    self.editBtn.top=self.allpricelabel.top;
    self.editBtn.left=ZJAPPWidth-Kwidth3-15;
    self.editBtn.width=Kwidth3;
    self.editBtn.height=Kheight;
    self.editBtn.layer.cornerRadius=3;
    self.editBtn.layer.masksToBounds=YES;
    
    self.deleteBtn.top=self.liutongpricelabel.top;
    self.deleteBtn.left=ZJAPPWidth-Kwidth3-15;
    self.deleteBtn.width=Kwidth3;
    self.deleteBtn.height=Kheight;
    self.deleteBtn.layer.cornerRadius=3;
    self.deleteBtn.layer.masksToBounds=YES;
    
    
    self.lIneview.top=119;
    self.lIneview.left=0;
    self.lIneview.height=1;
    self.lIneview.width=ZJAPPWidth;

}
+ (CGFloat)getCellHeight
{
    return 120;
}
- (IBAction)editBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DebtCapitalAndDemandEditActionWithItem:)]) {
        [self.delegate DebtCapitalAndDemandEditActionWithItem:_item];
    }
}
- (IBAction)deleteBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DebtCapitalAndDemandDeleteActionWithItem:)]) {
        [self.delegate DebtCapitalAndDemandDeleteActionWithItem:_item];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
