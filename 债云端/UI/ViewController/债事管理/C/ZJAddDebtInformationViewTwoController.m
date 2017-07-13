//
//  ZJAddDebtInformationViewTwoController.m
//  债云端
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAddDebtInformationViewTwoController.h"
#import "ZJAddPhotosViewController.h"

#define kBUTTON_H 20
@interface ZJAddDebtInformationViewTwoController ()
@end

@implementation ZJAddDebtInformationViewTwoController
{
    __weak IBOutlet UIScrollView *BackScrollview;

    __weak IBOutlet UIView *FirstView;
    __weak IBOutlet UILabel *firstLabel;
    __weak IBOutlet UIButton *firstYesBtn;
    __weak IBOutlet UIButton *firstNoBtn;
    
    __weak IBOutlet UIView *SecondView;
    __weak IBOutlet UILabel *secondLabel;
    __weak IBOutlet UIButton *SecondYesBtn;
    __weak IBOutlet UIButton *SecondNoBtn;
    
    __weak IBOutlet UIView *ThreeView;
    __weak IBOutlet UILabel *ThreeLabel;
    __weak IBOutlet UIButton *ThreeYesBtn;
    __weak IBOutlet UIButton *ThreeNoBtn;
    
    __weak IBOutlet UIView *FourView;
    __weak IBOutlet UILabel *FourLabel;
    __weak IBOutlet UIButton *FourYesBtn;
    __weak IBOutlet UIButton *FourNoBtn;

    __weak IBOutlet UIView *FiveView;
    NSMutableArray *buttonArray1;
    
    __weak IBOutlet UIView *SixView;
    NSMutableArray *buttonArray2;
    
    __weak IBOutlet UIView *SevenView;
    NSMutableArray *buttonArray3;
    
    __weak IBOutlet UIButton *NextBtn;
    
    NSMutableDictionary * debtRelation2VoDic;
    NSMutableArray *buttonKeyArray1;
    NSMutableArray *buttonKeyArray2;
    NSMutableArray *buttonKeyArray3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"债事信息"];
    [ZJNavigationPublic setRightButtonOnTargetNav:self action:@selector(backHomePage) image:[UIImage imageNamed:@"return-home"] HighImage:[UIImage imageNamed:@"return-home"]];
    buttonArray1 = [NSMutableArray array];
    buttonArray2 = [NSMutableArray array];
    buttonArray3 = [NSMutableArray array];
    buttonKeyArray1 = [NSMutableArray array];
    buttonKeyArray2 = [NSMutableArray array];
    buttonKeyArray3 = [NSMutableArray array];
    debtRelation2VoDic=[NSMutableDictionary dictionary];
    NSMutableArray * fiveArray=[NSMutableArray arrayWithObjects:@"营业执照副本复印件",@"组织机构代码证复印件",@"法人身份证复印件", nil];
    NSMutableArray * sixArray=[NSMutableArray arrayWithObjects:@"合同",@"收据",@"借据",@"欠据",@"协议",@"信件",@"电报",@"提货单",@"仓单发票",@"其他", nil];
    NSMutableArray * sevenArray=[NSMutableArray arrayWithObjects:@"微信",@"QQ",@"MSN",@"微博",@"其他", nil];
    BackScrollview.top=0;
    BackScrollview.left=0;
    BackScrollview.width=ZJAPPWidth;
    BackScrollview.height=ZJAPPHeight;
    BackScrollview.showsVerticalScrollIndicator=NO;
    
    [self createButtonWithDataSourc:fiveArray withTag:1 withSuperView:FiveView];
    SixView.top=FiveView.bottom;
    [self createButtonWithDataSourc:sixArray withTag:2 withSuperView:SixView];
    SevenView.top=SixView.bottom;
    [self createButtonWithDataSourc:sevenArray withTag:3 withSuperView:SevenView];
    
    
    
    NextBtn.top=SevenView.bottom+65;
    NextBtn.left=45;
    NextBtn.width=ZJAPPWidth-90;
    NextBtn.height=35;
    NextBtn.layer.masksToBounds=YES;
    NextBtn.layer.cornerRadius=5;
    [BackScrollview setContentSize:CGSizeMake(0, NextBtn.bottom+40)];
    [debtRelation2VoDic setObject:@"1" forKey:@"proof"];    //是否有债务人偿还欠款及利息的证据
    [debtRelation2VoDic setObject:@"1" forKey:@"mortgagee"];  //是否有担保或者抵押的证明材料
    [debtRelation2VoDic setObject:@"1" forKey:@"attorn"];   //是否有债务转让证明材料
    [debtRelation2VoDic setObject:@"1" forKey:@"lawsuit"];   //是否曾涉及诉讼、公证及支付令等法律文书
}
//自定义封住了一个添加到superview的方法
- (void)createButtonWithDataSourc:(NSArray *)dataSoure withTag:(NSInteger)tagnum  withSuperView:(UIView *)superview{
    
    CGFloat left=15;
    CGFloat top=20+15+10;
    for (int i=0; i<dataSoure.count; i++) {
        CGSize localSize = [ZJUtil calculateSingleStringSizeWithString:[dataSoure objectAtIndex:i] andFont:ZJ_FONT(13.0f)];
        if (left+localSize.width+35>ZJAPPWidth) {
            left=15;
            top=top+kBUTTON_H+10;
        }
        UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(left,top, localSize.width+20,kBUTTON_H)];
        [button setTitle:[dataSoure objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = 100*tagnum + i;
        [button setTitleColor:ZJColor_666666 forState:UIControlStateNormal];
        button.backgroundColor=[UIColor whiteColor];
        button.titleLabel.font = ZJ_FONT(13.0f);
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius=3;
        button.layer.borderWidth=1;
        button.layer.borderColor=ZJColor_dddddd.CGColor;
        [superview addSubview:button];
        if (tagnum==1) {
            [buttonArray1 addObject:button];
        }else if (tagnum==2){
            [buttonArray2 addObject:button];
        }else if (tagnum==3){
            [buttonArray3 addObject:button];
        }
        left=button.right+10;
        superview.height=button.bottom;
    }
}
- (void)buttonAction:(UIButton *)button {
    if (button.tag/100==1) {
        for (UIButton *selectButton in buttonArray1) {
            if (button.tag == selectButton.tag) {
                if (selectButton.isSelected) {
                    selectButton.selected = NO;
                    [button setTitleColor:ZJColor_666666 forState:UIControlStateNormal];
                    button.backgroundColor=[UIColor whiteColor];
                    button.layer.borderColor=ZJColor_dddddd.CGColor;
                } else {
                    selectButton.selected = YES;
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    button.backgroundColor=ZJColor_red;
                    button.layer.borderColor=ZJColor_red.CGColor;
                }
            }
        }
    }else if (button.tag/100==2){
        for (UIButton *selectButton in buttonArray2) {
            if (button.tag == selectButton.tag) {
                if (selectButton.isSelected) {
                    selectButton.selected = NO;
                    [button setTitleColor:ZJColor_666666 forState:UIControlStateNormal];
                    button.backgroundColor=[UIColor whiteColor];
                    button.layer.borderColor=ZJColor_dddddd.CGColor;
                } else {
                    selectButton.selected = YES;
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    button.backgroundColor=ZJColor_red;
                    button.layer.borderColor=ZJColor_red.CGColor;
                }
            }
        }
    }else if (button.tag/100==3){
        for (UIButton *selectButton in buttonArray3) {
            if (button.tag == selectButton.tag) {
                if (selectButton.isSelected) {
                    selectButton.selected = NO;
                    [button setTitleColor:ZJColor_666666 forState:UIControlStateNormal];
                    button.backgroundColor=[UIColor whiteColor];
                    button.layer.borderColor=ZJColor_dddddd.CGColor;
                } else {
                    selectButton.selected = YES;
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    button.backgroundColor=ZJColor_red;
                    button.layer.borderColor=ZJColor_red.CGColor;
                }
            }
        }
    }
    
}

//是否由债务人偿还欠款及利息的证据
- (IBAction)firstYesBtnAction:(id)sender {
    [firstYesBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [firstNoBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation2VoDic setObject:@"1" forKey:@"proof"];    //是否有债务人偿还欠款及利息的证据
}
- (IBAction)firstNoBtnAction:(id)sender {
    [firstNoBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [firstYesBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation2VoDic setObject:@"0" forKey:@"proof"];    //是否有债务人偿还欠款及利息的证据
}
//是否有担保或者抵押的证明材料
- (IBAction)secondYesBtnAction:(id)sender {
    [SecondYesBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [SecondNoBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation2VoDic setObject:@"1" forKey:@"mortgagee"];  //是否有担保或者抵押的证明材料
}
- (IBAction)secondNoBtnAction:(id)sender {
    [SecondNoBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [SecondYesBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
     [debtRelation2VoDic setObject:@"0" forKey:@"mortgagee"];  //是否有担保或者抵押的证明材料
}
//是否有债务转让证明材料
- (IBAction)threeYesBtnAction:(id)sender {
    [ThreeYesBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [ThreeNoBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation2VoDic setObject:@"1" forKey:@"attorn"];   //是否有债务转让证明材料
}
- (IBAction)threeNoBtnAction:(id)sender {
    [ThreeNoBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [ThreeYesBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation2VoDic setObject:@"0" forKey:@"attorn"];   //是否有债务转让证明材料
}
//是否曾涉及诉讼、公证等法律文书
- (IBAction)fourYesBtnAction:(id)sender {
    [FourYesBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [FourNoBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation2VoDic setObject:@"1" forKey:@"lawsuit"];   //是否曾涉及诉讼、公证及支付令等法律文书
}
- (IBAction)fourNoBtnAction:(id)sender {
    [FourNoBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [FourYesBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation2VoDic setObject:@"0" forKey:@"lawsuit"];   //是否曾涉及诉讼、公证及支付令等法律文书
}
//下一步
- (IBAction)NextBtnAction:(id)sender {
    //身份证明
    for (int i=0; i<buttonArray1.count; i++) {
        UIButton * selectButton=[buttonArray1 objectAtIndex:i];
        if (selectButton.isSelected) {
            [buttonKeyArray1 addObject:[NSString stringWithFormat:@"%d",i+1]];
        }
    }
    [debtRelation2VoDic setObject:buttonKeyArray1 forKey:@"identification"];
    //票据证明
    for (int i=0; i<buttonArray2.count; i++) {
        UIButton * selectButton=[buttonArray2 objectAtIndex:i];
        if (selectButton.isSelected) {
            [buttonKeyArray2 addObject:[NSString stringWithFormat:@"%d",i+1]];
        }
    }
    [debtRelation2VoDic setObject:buttonKeyArray2 forKey:@"evidence"];
    //电子数据
    for (int i=0; i<buttonArray3.count; i++) {
        UIButton * selectButton=[buttonArray3 objectAtIndex:i];
        if (selectButton.isSelected) {
            [buttonKeyArray3 addObject:[NSString stringWithFormat:@"%d",i+1]];
        }
    }
    [debtRelation2VoDic setObject:buttonKeyArray3 forKey:@"electron"];

    
    
    ZJAddPhotosViewController * addphotosVC=[[ZJAddPhotosViewController alloc]initWithNibName:@"ZJAddPhotosViewController" bundle:nil];
    addphotosVC.Phototype=ZJAddPhotosDebtRecord;
    addphotosVC.debtRelation1Vo=self.debtRelation1Vo;
    addphotosVC.debtRelation2Vo=debtRelation2VoDic;
    [self.navigationController pushViewController:addphotosVC animated:YES];
}
// 返回首页
-(void)backHomePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
