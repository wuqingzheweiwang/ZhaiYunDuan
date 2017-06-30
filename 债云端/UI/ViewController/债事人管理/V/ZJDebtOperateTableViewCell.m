//
//  ZJDebtOperateTableViewCell.m
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtOperateTableViewCell.h"
#define  Kheight  15
#define  Kwidth1  110
#define  Kwidth2  ZJAPPWidth-60-110-60  //法人名称内容的长度
#define  Kwidth3  ZJAPPWidth-60-110-15  //税号内容的长度
#define  Kwidth4  40    //button的长度

@implementation ZJDebtOperateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(ZJOperateInfoItem *)item
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
    self.corporatenamelabel.top=15;
    self.corporatenamelabel.left=self.ImageFlag.right+10;
    self.corporatenamelabel.width=Kwidth1;
    self.corporatenamelabel.height=Kheight;
    
    self.taxnumberlabel.top=40;
    self.taxnumberlabel.left=self.corporatenamelabel.left;
    self.taxnumberlabel.width=Kwidth1;
    self.taxnumberlabel.height=Kheight;
    
    self.corporatephonelabel.top=65;
    self.corporatephonelabel.left=self.corporatenamelabel.left;
    self.corporatephonelabel.width=Kwidth1;
    self.corporatephonelabel.height=Kheight;
    
    self.addresslabel.top=90;
    self.addresslabel.left=self.corporatenamelabel.left;
    self.addresslabel.width=Kwidth1;
    self.addresslabel.height=Kheight;
    
    self.lastyearsaleslabel.top=115;
    self.lastyearsaleslabel.left=self.corporatenamelabel.left;
    self.lastyearsaleslabel.width=Kwidth1;
    self.lastyearsaleslabel.height=Kheight;
    
    self.allsaleslabel.top=140;
    self.allsaleslabel.left=self.corporatenamelabel.left;
    self.allsaleslabel.width=Kwidth1;
    self.allsaleslabel.height=Kheight;
    
    self.annualtarifflabel.top=165;
    self.annualtarifflabel.left=self.corporatenamelabel.left;
    self.annualtarifflabel.width=Kwidth1;
    self.annualtarifflabel.height=Kheight;
    
    self.subordinateyearlabel.top=190;
    self.subordinateyearlabel.left=self.corporatenamelabel.left;
    self.subordinateyearlabel.width=Kwidth1;
    self.subordinateyearlabel.height=Kheight;
    
    self.profitmarginlabel.top=215;
    self.profitmarginlabel.left=self.corporatenamelabel.left;
    self.profitmarginlabel.width=Kwidth1;
    self.profitmarginlabel.height=Kheight;
    
    self.totalinvestmentlabel.top=240;
    self.totalinvestmentlabel.left=self.corporatenamelabel.left;
    self.totalinvestmentlabel.width=Kwidth1;
    self.totalinvestmentlabel.height=Kheight;
    
    //第二排
    self.corporatenametextlabel.top=self.corporatenamelabel.top;
    self.corporatenametextlabel.left=self.corporatenamelabel.right;
    self.corporatenametextlabel.width=Kwidth2;
    self.corporatenametextlabel.height=Kheight;
    self.corporatenametextlabel.text=item.legalPersonName;
    
    self.taxnumbertextlabel.top=self.taxnumberlabel.top;
    self.taxnumbertextlabel.left=self.corporatenametextlabel.left;
    self.taxnumbertextlabel.width=Kwidth3;
    self.taxnumbertextlabel.height=Kheight;
    self.taxnumbertextlabel.text=item.taxNumber;
    
    self.corporatephonetextlabel.top=self.corporatephonelabel.top;
    self.corporatephonetextlabel.left=self.corporatenametextlabel.left;
    self.corporatephonetextlabel.width=Kwidth3;
    self.corporatephonetextlabel.height=Kheight;
    self.corporatephonetextlabel.text=item.phoneNumber;
    
    self.addresstextlabel.top=self.addresslabel.top;
    self.addresstextlabel.left=self.corporatenametextlabel.left;
    self.addresstextlabel.width=Kwidth3;
    self.addresstextlabel.height=Kheight;
    self.addresstextlabel.text=item.address;
    
    self.lastyearsalestextlabel.top=self.lastyearsaleslabel.top;
    self.lastyearsalestextlabel.left=self.corporatenametextlabel.left;
    self.lastyearsalestextlabel.width=Kwidth3;
    self.lastyearsalestextlabel.height=Kheight;
    self.lastyearsalestextlabel.text=item.lastSales;
    
    self.allsalestextlabel.top=self.allsaleslabel.top;
    self.allsalestextlabel.left=self.corporatenametextlabel.left;
    self.allsalestextlabel.width=Kwidth3;
    self.allsalestextlabel.height=Kheight;
    self.allsalestextlabel.text=item.gross;
    
    self.annualtarifftextlabel.top=self.annualtarifflabel.top;
    self.annualtarifftextlabel.left=self.corporatenametextlabel.left;
    self.annualtarifftextlabel.width=Kwidth3;
    self.annualtarifftextlabel.height=Kheight;
    self.annualtarifftextlabel.text=item.lastElectricityBills;
    
    self.subordinateyeartextlabel.top=self.subordinateyearlabel.top;
    self.subordinateyeartextlabel.left=self.corporatenametextlabel.left;
    self.subordinateyeartextlabel.width=Kwidth3;
    self.subordinateyeartextlabel.height=Kheight;
    self.subordinateyeartextlabel.text=item.year;
    
    self.profitmargintextlabel.top=self.profitmarginlabel.top;
    self.profitmargintextlabel.left=self.corporatenametextlabel.left;
    self.profitmargintextlabel.width=Kwidth3;
    self.profitmargintextlabel.height=Kheight;
    self.profitmargintextlabel.text=item.profitMargin;
    
    self.totalinvestmenttextlabel.top=self.totalinvestmentlabel.top;
    self.totalinvestmenttextlabel.left=self.corporatenametextlabel.left;
    self.totalinvestmenttextlabel.width=Kwidth3;
    self.totalinvestmenttextlabel.height=Kheight;
    self.totalinvestmenttextlabel.text=item.totalInvestment;
    
    //第三排
    self.deleteBtn.top=15;
    self.deleteBtn.left=ZJAPPWidth-Kwidth4-15;
    self.deleteBtn.width=Kwidth4;
    self.deleteBtn.height=Kheight;
    self.deleteBtn.layer.cornerRadius=3;
    self.deleteBtn.layer.masksToBounds=YES;
    
    
    self.lIneview.top=269;
    self.lIneview.left=0;
    self.lIneview.height=1;
    self.lIneview.width=ZJAPPWidth;
}
+ (CGFloat)getCellHeight
{
    return 270;
}
- (IBAction)deleteBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DebtOperateDeleteActionWithItem:)]) {
        [self.delegate DebtOperateDeleteActionWithItem:_item];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
