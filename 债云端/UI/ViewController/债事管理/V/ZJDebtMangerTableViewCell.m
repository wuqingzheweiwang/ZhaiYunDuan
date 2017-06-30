//
//  ZJDebtMangerTableViewCell.m
//  债云端
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtMangerTableViewCell.h"
#define  Kheight  15
#define  Kwidth1  80
#define  Kwidth2  120
#define  Kwidth3  70
@implementation ZJDebtMangerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setitem:(ZJDebtMangerHomeItem *)item
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
    self.Lurushijian1.top=15;
    self.Lurushijian1.left=self.ImageFlag.right+10;
    self.Lurushijian1.width=Kwidth1;
    self.Lurushijian1.height=Kheight;
    
    self.Zhaiquanren1.top=40;
    self.Zhaiquanren1.left=self.Lurushijian1.left;
    self.Zhaiquanren1.width=Kwidth1;
    self.Zhaiquanren1.height=Kheight;
    
    self.Zhaiwuren1.top=65;
    self.Zhaiwuren1.left=self.Lurushijian1.left;
    self.Zhaiwuren1.width=Kwidth1;
    self.Zhaiwuren1.height=Kheight;
    
    self.Zhutijine1.top=90;
    self.Zhutijine1.left=self.Lurushijian1.left;
    self.Zhutijine1.width=Kwidth1;
    self.Zhutijine1.height=Kheight;
    
    
    //第二排
    self.LuruTextLabel.top=self.Lurushijian1.top;
    self.LuruTextLabel.left=self.Lurushijian1.right;
    self.LuruTextLabel.width=Kwidth2;
    self.LuruTextLabel.height=Kheight;
    self.LuruTextLabel.text=item.debtcreateTime;
    
    self.ZhaiquanrenTextLabel.top=self.Zhaiquanren1.top;
    self.ZhaiquanrenTextLabel.left=self.LuruTextLabel.left;
    self.ZhaiquanrenTextLabel.width=Kwidth2;
    self.ZhaiquanrenTextLabel.height=Kheight;
    self.ZhaiquanrenTextLabel.text=item.debttoPeson;
    
    self.ZhaiwurenTextLabel.top=self.Zhaiwuren1.top;
    self.ZhaiwurenTextLabel.left=self.LuruTextLabel.left;
    self.ZhaiwurenTextLabel.width=Kwidth2;
    self.ZhaiwurenTextLabel.height=Kheight;
    self.ZhaiwurenTextLabel.text=item.debtfromPerson;
    
    self.MoneyTextLabel.top=self.Zhutijine1.top;
    self.MoneyTextLabel.left=self.LuruTextLabel.left;
    self.MoneyTextLabel.width=Kwidth2;
    self.MoneyTextLabel.height=Kheight;
    self.MoneyTextLabel.text=item.debtamout;
    
    //第三排
    self.alreadPostLabel.top=self.Lurushijian1.top;
    self.alreadPostLabel.left=ZJAPPWidth-Kwidth3-15;
    self.alreadPostLabel.width=Kwidth3;
    self.alreadPostLabel.height=Kheight;
    
    self.alreadSolvedLabel.top=self.Zhaiquanren1.top;
    self.alreadSolvedLabel.left=ZJAPPWidth-Kwidth3-15;
    self.alreadSolvedLabel.width=Kwidth3;
    self.alreadSolvedLabel.height=Kheight;
    if ([item.debtisSolution isEqualToString:@"0"]) {
        self.alreadSolvedLabel.text=@"未解决";
    }else{
        self.alreadSolvedLabel.text=@"已解决";
    }
    
    self.SeeDetailBtn.top=self.Zhaiwuren1.top;
    self.SeeDetailBtn.left=ZJAPPWidth-Kwidth3-15;
    self.SeeDetailBtn.width=Kwidth3;
    self.SeeDetailBtn.height=Kheight;
    self.SeeDetailBtn.layer.cornerRadius=3;
    self.SeeDetailBtn.layer.masksToBounds=YES;
    
    self.PayBtn.top=self.Zhutijine1.top;
    self.PayBtn.left=ZJAPPWidth-Kwidth3-15;
    self.PayBtn.width=Kwidth3;
    self.PayBtn.height=Kheight;
    self.PayBtn.layer.cornerRadius=3;
    self.PayBtn.layer.masksToBounds=YES;
    
    self.alreadPayLabel.top=self.Zhutijine1.top;
    self.alreadPayLabel.left=ZJAPPWidth-Kwidth3-15;
    self.alreadPayLabel.width=Kwidth3;
    self.alreadPayLabel.height=Kheight;
    
    if (item.otherPerson&&[item.otherPerson isEqualToString:@"1"]) {
        if ([item.debtisPay isEqualToString:@"0"]) {
            self.alreadPayLabel.hidden=NO;
            self.alreadPayLabel.text=@"未付费";
            self.PayBtn.hidden=YES;
        }else{
            self.alreadPayLabel.hidden=NO;
            self.alreadPayLabel.text=@"已付费";
            self.PayBtn.hidden=YES;
        }
    }else{
        if ([item.debtisPay isEqualToString:@"0"]) {
            self.alreadPayLabel.hidden=YES;
            self.PayBtn.hidden=NO;
        }else{
            self.alreadPayLabel.hidden=NO;
            self.PayBtn.hidden=YES;
        }
    }
    
    self.lIneview.top=119;
    self.lIneview.left=0;
    self.lIneview.height=1;
    self.lIneview.width=ZJAPPWidth;
}
+ (CGFloat)getCellHeight
{
    return 120;
}
- (IBAction)SeeDetailBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DebtMangerHomeSeeDetailActionWithItem:)]) {
        [self.delegate DebtMangerHomeSeeDetailActionWithItem:_item];
    }
}
- (IBAction)payBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DebtMangerHomePayActionWithItem:)]) {
        [self.delegate DebtMangerHomePayActionWithItem:_item];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
