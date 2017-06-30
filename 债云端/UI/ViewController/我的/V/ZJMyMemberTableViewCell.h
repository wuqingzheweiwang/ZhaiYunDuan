//
//  ZJMyMemberTableViewCell.h
//  债云端
//
//  Created by 赵凯强 on 2017/5/2.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJMyMemberTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;

@property (weak, nonatomic) IBOutlet UILabel *myMemeber;
    
@property (weak, nonatomic) IBOutlet UILabel *centerXLine;

@property (weak, nonatomic) IBOutlet UILabel *recommandLabel_1;

@property (weak, nonatomic) IBOutlet UILabel *recommandRecoardLabel;

@property (weak, nonatomic) IBOutlet UIButton *recommandRecoardBut;

@property (weak, nonatomic) IBOutlet UIImageView *imageline_1;

@property (weak, nonatomic) IBOutlet UILabel *recommandLabel_2;

@property (weak, nonatomic) IBOutlet UILabel *recommandBankManger;

@property (weak, nonatomic) IBOutlet UIButton *recommandBankBut;

@property (weak, nonatomic) IBOutlet UIImageView *imagelable_2;

@property (weak, nonatomic) IBOutlet UILabel *recommandLabel_3;
    
@property (weak, nonatomic) IBOutlet UILabel *dismissDebtCount;

@property (weak, nonatomic) IBOutlet UIButton *dismissDebtBut;

@property (weak, nonatomic) IBOutlet UIImageView *imagelabel_3;

@property (weak, nonatomic) IBOutlet UILabel *recommandLabel_4;

@property (weak, nonatomic) IBOutlet UILabel *recomMember;

@property (weak, nonatomic) IBOutlet UIButton *recomMemberBut;

@end
