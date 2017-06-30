//
//  ZJDebtStockInfoTableViewCell.m
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtStockInfoTableViewCell.h"
#define  Kheight  15
#define  Kwidth1  80
#define  Kwidth2  ZJAPPWidth-60-60-80   //股东名称内容的长度
#define  Kwidth3  40    //button的长度
#define  Kwidth4  ZJAPPWidth-60-80-15   //证件号内容的长度
@implementation ZJDebtStockInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(ZJStockInfoItem *)item
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
    self.stockholdernamelabel.top=15;
    self.stockholdernamelabel.left=self.ImageFlag.right+10;
    self.stockholdernamelabel.width=Kwidth1;
    self.stockholdernamelabel.height=Kheight;
    
    self.certificatelabel.top=40;
    self.certificatelabel.left=self.stockholdernamelabel.left;
    self.certificatelabel.width=Kwidth1;
    self.certificatelabel.height=Kheight;
    
    self.addersslabel.top=65;
    self.addersslabel.left=self.stockholdernamelabel.left;
    self.addersslabel.width=Kwidth1;
    self.addersslabel.height=Kheight;
    
    self.investmentlabel.top=90;
    self.investmentlabel.left=self.stockholdernamelabel.left;
    self.investmentlabel.width=Kwidth1;
    self.investmentlabel.height=Kheight;
    
    self.ratioinvestmentsinlabel.top=115;
    self.ratioinvestmentsinlabel.left=self.stockholdernamelabel.left;
    self.ratioinvestmentsinlabel.width=Kwidth1;
    self.ratioinvestmentsinlabel.height=Kheight;
    
    self.registcapitallabel.top=140;
    self.registcapitallabel.left=self.stockholdernamelabel.left;
    self.registcapitallabel.width=Kwidth1;
    self.registcapitallabel.height=Kheight;
    
    self.realcapitallabel.top=165;
    self.realcapitallabel.left=self.stockholdernamelabel.left;
    self.realcapitallabel.width=Kwidth1;
    self.realcapitallabel.height=Kheight;
    
    //第二排
    self.stockholdernametextlabel.top=self.stockholdernamelabel.top;
    self.stockholdernametextlabel.left=self.stockholdernamelabel.right;
    self.stockholdernametextlabel.width=Kwidth2;
    self.stockholdernametextlabel.height=Kheight;
    self.stockholdernametextlabel.text=item.shareholderName;
    
    self.certificatetextlabel.top=self.certificatelabel.top;
    self.certificatetextlabel.left=self.stockholdernametextlabel.left;
    self.certificatetextlabel.width=Kwidth4;
    self.certificatetextlabel.height=Kheight;
    self.certificatetextlabel.text=item.shareholderCode;
    
    self.addersstextlabel.top=self.addersslabel.top;
    self.addersstextlabel.left=self.stockholdernametextlabel.left;
    self.addersstextlabel.width=Kwidth4;
    self.addersstextlabel.height=Kheight;
    self.addersstextlabel.text=item.address;
    
    self.investmenttextlabel.top=self.investmentlabel.top;
    self.investmenttextlabel.left=self.stockholdernametextlabel.left;
    self.investmenttextlabel.width=Kwidth4;
    self.investmenttextlabel.height=Kheight;
    self.investmenttextlabel.text=item.amount;
    
    self.ratioinvestmentsintextlabel.top=self.ratioinvestmentsinlabel.top;
    self.ratioinvestmentsintextlabel.left=self.stockholdernametextlabel.left;
    self.ratioinvestmentsintextlabel.width=Kwidth4;
    self.ratioinvestmentsintextlabel.height=Kheight;
    self.ratioinvestmentsintextlabel.text=[NSString stringWithFormat:@"%@%@",item.proportion,@"%"];
    
    self.registcapitaltextlabel.top=self.registcapitallabel.top;
    self.registcapitaltextlabel.left=self.stockholdernametextlabel.left;
    self.registcapitaltextlabel.width=Kwidth4;
    self.registcapitaltextlabel.height=Kheight;
    self.registcapitaltextlabel.text=item.registeredCapital;
    
    self.realcapitaltextlabel.top=self.realcapitallabel.top;
    self.realcapitaltextlabel.left=self.stockholdernametextlabel.left;
    self.realcapitaltextlabel.width=Kwidth4;
    self.realcapitaltextlabel.height=Kheight;
    self.realcapitaltextlabel.text=item.actualCapital;
    
    //第三排
    self.deleteBtn.top=self.stockholdernamelabel.top;
    self.deleteBtn.left=ZJAPPWidth-Kwidth3-15;
    self.deleteBtn.width=Kwidth3;
    self.deleteBtn.height=Kheight;
    self.deleteBtn.layer.cornerRadius=3;
    self.deleteBtn.layer.masksToBounds=YES;
    
    
    self.lIneview.top=194;
    self.lIneview.left=0;
    self.lIneview.height=1;
    self.lIneview.width=ZJAPPWidth;

}
+ (CGFloat)getCellHeight
{
    return 195;
}
- (IBAction)deleteBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DebtStockDeleteActionWithItem:)]) {
        [self.delegate DebtStockDeleteActionWithItem:_item];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
