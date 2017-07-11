//
//  ZJAddDebtInformationViewController.m
//  债云端
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAddDebtInformationViewController.h"
#import "ZJProtocolAlterView.h"
#import "ZJAddPhotosViewController.h"
#import "ZJAddDebtInformationViewTwoController.h"
#import "ZJAddDebtPersonController.h"
@interface ZJAddDebtInformationViewController ()<ZJProtocolAlterDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIAlertViewDelegate>

@end

@implementation ZJAddDebtInformationViewController
{
    ZJProtocolAlterView * protolAlterView;
    
    __weak IBOutlet UIScrollView *BackScrollview;//背景滑动视图
    
    __weak IBOutlet UIView *VipZeroview;//债事人类型
    __weak IBOutlet UILabel *DebtShiPersonLabel;
    __weak IBOutlet UIButton *DebtShiPersonQuanBtn;
    __weak IBOutlet UIButton *DebtShiPersonWuBtn;
    
    __weak IBOutlet UIView *VipOneview;//债事人证件号
    __weak IBOutlet UILabel *DebtShiPersonHaomaLabel;
    __weak IBOutlet UITextField *DebtShiPersonHaomaTF;
    __weak IBOutlet UIButton *DebtShiPersonBtn;
    
    __weak IBOutlet UIView *VipTwoview;//债事人名称
    __weak IBOutlet UILabel *DebtShiPersonNameLabel;
    __weak IBOutlet UITextField *DebtShiPersonNameTF;
    
    
    
    __weak IBOutlet UIView *Oneview;//债务人证件号
    __weak IBOutlet UILabel *DebtWuPersonHaomaLabel;
    __weak IBOutlet UITextField *DebtWuPersonHaomaTF;
    __weak IBOutlet UIButton *DebtWuPersonBtn;
    
    __weak IBOutlet UIView *Twoview;//债务人名称
    __weak IBOutlet UILabel *DebtWuPersonNameLabel;
    __weak IBOutlet UITextField *DebtWuPersonNameTF;
    
    __weak IBOutlet UIView *Threeview;//债权人证件号
    __weak IBOutlet UILabel *DebtQuanPersonHaomaLabel;
    __weak IBOutlet UITextField *DebtQuanPersonHaomaTF;
    __weak IBOutlet UIButton *DebtQuanPersonBtn;
    
    __weak IBOutlet UIView *Fourview;//债权人名称
    __weak IBOutlet UILabel *DebtQuanPersonNameLabel;
    __weak IBOutlet UITextField *DebtQuanPersonNameTF;
    
    __weak IBOutlet UIView *Fiveview;//债事类型
    __weak IBOutlet UILabel *DebtTypelabel;
    __weak IBOutlet UIButton *DebtTypeMoneyBtn;
    __weak IBOutlet UIButton *DebtTypeNoMoneyBtn;
    
    
    __weak IBOutlet UIView *Sixview;//债事性质
    __weak IBOutlet UILabel *DebtClassLabel;
    __weak IBOutlet UIButton *DebtPersonBtn;
    __weak IBOutlet UIButton *DebtCompanyBtn;
    
    __weak IBOutlet UIView *AddCategotyClassView;//国企私企
    __weak IBOutlet UIButton *GuoyouCompanyBtn;
    __weak IBOutlet UIButton *SiqiCompanyBtn;
    
    __weak IBOutlet UIView *Sevenview;//诉讼情况
    __weak IBOutlet UILabel *DebtLitigationLabel;
    __weak IBOutlet UIButton *DebtNoLitigationBtn;
    __weak IBOutlet UIButton *DebtLitigationBtn;
    
    __weak IBOutlet UIView *Eightview;//主体金额
    __weak IBOutlet UILabel *MainMoneyLabel;
    __weak IBOutlet UITextField *MainMoneyTF;
    
    __weak IBOutlet UIView *Nineview;//债事发生时间
    __weak IBOutlet UILabel *DebtTimeLabel;
    __weak IBOutlet UITextField *DebtTimeTF;
    __weak IBOutlet UIButton *DebtTimeBtn;
    
    __weak IBOutlet UIView *Tenview;//推荐人
    __weak IBOutlet UILabel *RefereeLabel;
    __weak IBOutlet UITextField *RefereeTF;
    
    __weak IBOutlet UIButton *NextBtn;
    
    //债事发生时间View
    __weak IBOutlet UIView *DebtTimeView;
    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UIButton *OKbtn;
    __weak IBOutlet UIButton *cancelBtn;
    NSString * DebtTimestring;
    
    
    CGFloat scrollViewOffSetY;
    CGFloat remainingDistanceY;
    CGFloat beforeMigrationY;//键盘
    
    
    NSMutableDictionary * debtRelation1VoDic;
    NSString * DebtShiPersonHaomaIDText;
    NSString * DebtQuanPersonHaomaIDText;
    NSString * DebtWuPersonHaomaTFIDText;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DebtTimestring=[NSString string];
    debtRelation1VoDic=[NSMutableDictionary dictionary];
    DebtShiPersonHaomaIDText=[NSString string];
    DebtQuanPersonHaomaIDText=[NSString string];
    DebtWuPersonHaomaTFIDText=[NSString string];
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"债事信息"];
    
    [self performSelector:@selector(seeProtcol) withObject:nil afterDelay:0.2f];
    [self createUI];
}

-(void)createUI
{
    BackScrollview.top=0;
    BackScrollview.left=0;
    BackScrollview.width=ZJAPPWidth;
    BackScrollview.height=ZJAPPHeight;
    BackScrollview.showsVerticalScrollIndicator=NO;
    BackScrollview.delegate=self;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [BackScrollview addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    if (self.Btntype==2) {   //普通用户
        VipZeroview.hidden=NO;
        VipZeroview.top=5;
        VipZeroview.left=0;
        VipZeroview.width=ZJAPPWidth;
        VipZeroview.height=53;
        DebtShiPersonLabel.left=15;
        DebtShiPersonLabel.width=110;
        DebtShiPersonQuanBtn.left=DebtShiPersonLabel.right;
        DebtShiPersonQuanBtn.width=65;
        DebtShiPersonWuBtn.left=DebtShiPersonQuanBtn.right;
        DebtShiPersonWuBtn.width=65;
        
        VipOneview.hidden=NO;
        VipOneview.top=VipZeroview.bottom;
        VipOneview.left=0;
        VipOneview.width=ZJAPPWidth;
        VipOneview.height=53;
        DebtShiPersonHaomaLabel.left=15;
        DebtShiPersonHaomaLabel.width=110;
        DebtShiPersonHaomaTF.left=DebtShiPersonHaomaLabel.right;
        DebtShiPersonHaomaTF.width=ZJAPPWidth-30-110;
        DebtShiPersonHaomaTF.layer.borderWidth=1;
        DebtShiPersonHaomaTF.layer.borderColor=ZJColor_cccccc.CGColor;
        DebtShiPersonHaomaTF.layer.masksToBounds=YES;
        DebtShiPersonHaomaTF.layer.cornerRadius=5;
        DebtShiPersonHaomaTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, DebtShiPersonHaomaTF.frame.size.height)];
        DebtShiPersonHaomaTF.leftViewMode = UITextFieldViewModeAlways;
        DebtShiPersonBtn.width=40;
        DebtShiPersonBtn.height=19;
        DebtShiPersonBtn.top=27;
        DebtShiPersonBtn.left=ZJAPPWidth-25-40;
        DebtShiPersonBtn.layer.masksToBounds=YES;
        DebtShiPersonBtn.layer.cornerRadius=3;
        
        VipTwoview.hidden=NO;
        VipTwoview.top=VipOneview.bottom;
        VipTwoview.left=0;
        VipTwoview.width=ZJAPPWidth;
        VipTwoview.height=53;
        DebtShiPersonNameLabel.left=15;
        DebtShiPersonNameLabel.width=110;
        DebtShiPersonNameTF.left=DebtShiPersonNameLabel.right;
        DebtShiPersonNameTF.width=ZJAPPWidth-30-110;
        DebtShiPersonNameTF.layer.borderWidth=1;
        DebtShiPersonNameTF.layer.borderColor=ZJColor_cccccc.CGColor;
        DebtShiPersonNameTF.layer.masksToBounds=YES;
        DebtShiPersonNameTF.layer.cornerRadius=5;
        DebtShiPersonNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, DebtShiPersonNameTF.frame.size.height)];
        DebtShiPersonNameTF.leftViewMode = UITextFieldViewModeAlways;
        DebtShiPersonNameTF.userInteractionEnabled=NO;
        Fiveview.top=VipTwoview.bottom;
    }else if (self.Btntype==1){   //行长
        Oneview.hidden=NO;
        Oneview.top=5;
        Oneview.left=0;
        Oneview.width=ZJAPPWidth;
        Oneview.height=53;
        DebtWuPersonHaomaLabel.left=15;
        DebtWuPersonHaomaLabel.width=110;
        DebtWuPersonHaomaTF.left=DebtWuPersonHaomaLabel.right;
        DebtWuPersonHaomaTF.width=ZJAPPWidth-30-110;
        DebtWuPersonHaomaTF.layer.borderWidth=1;
        DebtWuPersonHaomaTF.layer.borderColor=ZJColor_cccccc.CGColor;
        DebtWuPersonHaomaTF.layer.masksToBounds=YES;
        DebtWuPersonHaomaTF.layer.cornerRadius=5;
        DebtWuPersonHaomaTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, DebtWuPersonHaomaTF.frame.size.height)];
        DebtWuPersonHaomaTF.leftViewMode = UITextFieldViewModeAlways;
        DebtWuPersonBtn.width=40;
        DebtWuPersonBtn.height=19;
        DebtWuPersonBtn.top=27;
        DebtWuPersonBtn.left=ZJAPPWidth-25-40;
        DebtWuPersonBtn.layer.masksToBounds=YES;
        DebtWuPersonBtn.layer.cornerRadius=3;
        
        Twoview.hidden=NO;
        Twoview.top=Oneview.bottom;
        Twoview.left=0;
        Twoview.width=ZJAPPWidth;
        Twoview.height=53;
        DebtWuPersonNameLabel.left=15;
        DebtWuPersonNameLabel.width=110;
        DebtWuPersonNameTF.left=DebtWuPersonNameLabel.right;
        DebtWuPersonNameTF.width=ZJAPPWidth-30-110;
        DebtWuPersonNameTF.layer.borderWidth=1;
        DebtWuPersonNameTF.layer.borderColor=ZJColor_cccccc.CGColor;
        DebtWuPersonNameTF.layer.masksToBounds=YES;
        DebtWuPersonNameTF.layer.cornerRadius=5;
        DebtWuPersonNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, DebtWuPersonNameTF.frame.size.height)];
        DebtWuPersonNameTF.leftViewMode = UITextFieldViewModeAlways;
        DebtWuPersonNameTF.userInteractionEnabled=NO;  //不让点击
        
        Threeview.hidden=NO;
        Threeview.top=Twoview.bottom;
        Threeview.left=0;
        Threeview.width=ZJAPPWidth;
        Threeview.height=53;
        DebtQuanPersonHaomaLabel.left=15;
        DebtQuanPersonHaomaLabel.width=110;
        DebtQuanPersonHaomaTF.left=DebtQuanPersonHaomaLabel.right;
        DebtQuanPersonHaomaTF.width=ZJAPPWidth-30-110;
        DebtQuanPersonHaomaTF.layer.borderWidth=1;
        DebtQuanPersonHaomaTF.layer.borderColor=ZJColor_cccccc.CGColor;
        DebtQuanPersonHaomaTF.layer.masksToBounds=YES;
        DebtQuanPersonHaomaTF.layer.cornerRadius=5;
        DebtQuanPersonHaomaTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, DebtQuanPersonHaomaTF.frame.size.height)];
        DebtQuanPersonHaomaTF.leftViewMode = UITextFieldViewModeAlways;
        DebtQuanPersonBtn.width=40;
        DebtQuanPersonBtn.height=19;
        DebtQuanPersonBtn.top=27;
        DebtQuanPersonBtn.left=ZJAPPWidth-25-40;
        DebtQuanPersonBtn.layer.masksToBounds=YES;
        DebtQuanPersonBtn.layer.cornerRadius=3;
        
        Fourview.hidden=NO;
        Fourview.top=Threeview.bottom;
        Fourview.left=0;
        Fourview.width=ZJAPPWidth;
        Fourview.height=53;
        DebtQuanPersonNameLabel.left=15;
        DebtQuanPersonNameLabel.width=110;
        DebtQuanPersonNameTF.left=DebtQuanPersonNameLabel.right;
        DebtQuanPersonNameTF.width=ZJAPPWidth-30-110;
        DebtQuanPersonNameTF.layer.borderWidth=1;
        DebtQuanPersonNameTF.layer.borderColor=ZJColor_cccccc.CGColor;
        DebtQuanPersonNameTF.layer.masksToBounds=YES;
        DebtQuanPersonNameTF.layer.cornerRadius=5;
        DebtQuanPersonNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, DebtQuanPersonNameTF.frame.size.height)];
        DebtQuanPersonNameTF.leftViewMode = UITextFieldViewModeAlways;
        DebtQuanPersonNameTF.userInteractionEnabled=NO; //不让点击
        Fiveview.top=Fourview.bottom;
    }
    
    Fiveview.left=0;
    Fiveview.width=ZJAPPWidth;
    Fiveview.height=53;
    DebtTypelabel.left=15;
    DebtTypelabel.width=110;
    DebtTypeMoneyBtn.left=DebtTypelabel.right;
    DebtTypeMoneyBtn.width=50;
    DebtTypeNoMoneyBtn.left=DebtTypeMoneyBtn.right+ZJAPPWidth*100/375;
    DebtTypeNoMoneyBtn.width=65;
    
    Sixview.top=Fiveview.bottom;
    Sixview.left=0;
    Sixview.width=ZJAPPWidth;
    Sixview.height=53;
    DebtClassLabel.left=15;
    DebtClassLabel.width=110;
    DebtPersonBtn.left=DebtClassLabel.right;
    DebtPersonBtn.width=50;
    DebtCompanyBtn.left=DebtTypeNoMoneyBtn.left;
    DebtCompanyBtn.width=50;
    
    AddCategotyClassView.top=Sixview.bottom;
    AddCategotyClassView.left=0;
    AddCategotyClassView.width=ZJAPPWidth;
    AddCategotyClassView.height=43;
    AddCategotyClassView.hidden=YES;
    GuoyouCompanyBtn.left=125;
    GuoyouCompanyBtn.width=50;
    SiqiCompanyBtn.left=GuoyouCompanyBtn.right+ZJAPPWidth*100/375;
    SiqiCompanyBtn.width=50;
    
    Sevenview.top=Sixview.bottom;
    Sevenview.left=0;
    Sevenview.width=ZJAPPWidth;
    Sevenview.height=53;
    DebtLitigationLabel.left=15;
    DebtLitigationLabel.width=110;
    DebtNoLitigationBtn.left=DebtLitigationLabel.right;
    DebtNoLitigationBtn.width=65;
    DebtLitigationBtn.left=DebtTypeNoMoneyBtn.left;
    DebtLitigationBtn.width=65;
    
    DebtShiPersonWuBtn.left=DebtTypeNoMoneyBtn.left;//债务人对齐
    
    
    Eightview.top=Sevenview.bottom;
    Eightview.left=0;
    Eightview.width=ZJAPPWidth;
    Eightview.height=53;
    MainMoneyLabel.left=15;
    MainMoneyLabel.width=110;
    MainMoneyTF.left=MainMoneyLabel.right;
    MainMoneyTF.width=ZJAPPWidth-30-110;
    MainMoneyTF.layer.borderWidth=1;
    MainMoneyTF.layer.borderColor=ZJColor_cccccc.CGColor;
    MainMoneyTF.layer.masksToBounds=YES;
    MainMoneyTF.layer.cornerRadius=5;
    MainMoneyTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, MainMoneyTF.frame.size.height)];
    MainMoneyTF.leftViewMode = UITextFieldViewModeAlways;
    
    Nineview.top=Eightview.bottom;
    Nineview.left=0;
    Nineview.width=ZJAPPWidth;
    Nineview.height=53;
    DebtTimeLabel.left=15;
    DebtTimeLabel.width=110;
    DebtTimeTF.left=DebtTimeLabel.right;
    DebtTimeTF.width=ZJAPPWidth-30-110;
    DebtTimeTF.layer.borderWidth=1;
    DebtTimeTF.layer.borderColor=ZJColor_cccccc.CGColor;
    DebtTimeTF.layer.masksToBounds=YES;
    DebtTimeTF.layer.cornerRadius=5;
    DebtTimeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, DebtTimeTF.frame.size.height)];
    DebtTimeTF.leftViewMode = UITextFieldViewModeAlways;
    DebtTimeBtn.left=DebtTimeLabel.right;
    DebtTimeBtn.width=ZJAPPWidth-30-110;
    [DebtTimeBtn addTarget:self action:@selector(DebtTimeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    Tenview.top=Nineview.bottom;
    Tenview.left=0;
    Tenview.width=ZJAPPWidth;
    Tenview.height=53;
    RefereeLabel.left=15;
    RefereeLabel.width=110;
    RefereeTF.left=RefereeLabel.right;
    RefereeTF.width=ZJAPPWidth-30-110;
    RefereeTF.layer.borderWidth=1;
    RefereeTF.layer.borderColor=ZJColor_cccccc.CGColor;
    RefereeTF.layer.masksToBounds=YES;
    RefereeTF.layer.cornerRadius=5;
    RefereeTF.placeholder=@"如未填写编码，默认隶属于总行";
    RefereeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, RefereeTF.frame.size.height)];
    RefereeTF.leftViewMode = UITextFieldViewModeAlways;
    
    NextBtn.top=Tenview.bottom+65;
    NextBtn.left=45;
    NextBtn.width=ZJAPPWidth-90;
    NextBtn.height=35;
    NextBtn.layer.masksToBounds=YES;
    NextBtn.layer.cornerRadius=5;
    
    [BackScrollview setContentSize:CGSizeMake(0, NextBtn.bottom+40)];
    
    if (self.Btntype==1){//行长
        [debtRelation1VoDic setObject:@"1" forKey:@"isPresident"];
        [debtRelation1VoDic setObject:@"" forKey:@"isDebt"];
        [debtRelation1VoDic setObject:DebtWuPersonHaomaTFIDText forKey:@"startId"];    //债务人
        [debtRelation1VoDic setObject:DebtQuanPersonHaomaIDText forKey:@"endId"];   //债权人
    }else if (self.Btntype==2){
        [debtRelation1VoDic setObject:@"0" forKey:@"isPresident"];
        [debtRelation1VoDic setObject:@"0" forKey:@"isDebt"]; //债权人
        [debtRelation1VoDic setObject:DebtShiPersonHaomaIDText forKey:@"endId"];  //债权人身份证号
    }
    [debtRelation1VoDic setObject:@"1" forKey:@"genre"];   //债事类型
    [debtRelation1VoDic setObject:@"1" forKey:@"natureOf"];  //债事性质
    [debtRelation1VoDic setObject:@"0" forKey:@"isLawsuit"];   //诉讼情况
    [debtRelation1VoDic setObject:MainMoneyTF.text forKey:@"amout"];   //金额
    [debtRelation1VoDic setObject:DebtTimeTF.text forKey:@"recordTime"];   //债事发生时间
    [debtRelation1VoDic setObject:RefereeTF.text forKey:@"recordTime"];   //推荐人
    
}
//点个人
-(void)reJianview{
    AddCategotyClassView.hidden=YES;
    Sevenview.top=Sixview.bottom;
    Eightview.top=Sevenview.bottom;
    Nineview.top=Eightview.bottom;
    Tenview.top=Nineview.bottom;
    NextBtn.top=Tenview.bottom+65;
    [BackScrollview setContentSize:CGSizeMake(0, NextBtn.bottom+40)];
}
//点国企
-(void)reAddview
{
    AddCategotyClassView.hidden=NO;
    AddCategotyClassView.top=Sixview.bottom;
    Sevenview.top=AddCategotyClassView.bottom;
    Eightview.top=Sevenview.bottom;
    Nineview.top=Eightview.bottom;
    Tenview.top=Nineview.bottom;
    NextBtn.top=Tenview.bottom+65;
    [BackScrollview setContentSize:CGSizeMake(0, NextBtn.bottom+40)];
}

//下一步
- (IBAction)NextBtnAction:(id)sender {
    if (self.Btntype==2) {
        if (DebtShiPersonHaomaTF.text.length<=0) {
            [ZJUtil showBottomToastWithMsg:@"请输入债事人证件号"];
            return;
        }
        if (DebtShiPersonNameTF.text.length<=0) {
            [ZJUtil showBottomToastWithMsg:@"请输入债事人名称"];
            return;
        }
    }else if (self.Btntype==1){
        if (DebtWuPersonHaomaTF.text.length<=0) {
            [ZJUtil showBottomToastWithMsg:@"请输入债务人证件号"];
            return;
        }
        if (DebtWuPersonNameTF.text.length<=0) {
            [ZJUtil showBottomToastWithMsg:@"请输入债务人名称"];
            return;
        }
        if (DebtQuanPersonHaomaTF.text.length<=0) {
            [ZJUtil showBottomToastWithMsg:@"请输入债权人证件号"];
            return;
        }
        if (DebtQuanPersonNameTF.text.length<=0) {
            [ZJUtil showBottomToastWithMsg:@"请输入债权人名称"];
            return;
        }
        
    }
    
    if (MainMoneyTF.text.length<=0) {
        [ZJUtil showBottomToastWithMsg:@"请输入主体金额"];
        return;
    }
    if (DebtTimeTF.text.length<=0) {
        [ZJUtil showBottomToastWithMsg:@"请输入债事发生时间"];
        return;
    }
    NSLog(@"%@",debtRelation1VoDic);
    ZJAddDebtInformationViewTwoController * addinfo=[[ZJAddDebtInformationViewTwoController alloc]initWithNibName:@"ZJAddDebtInformationViewTwoController" bundle:nil];
    addinfo.debtRelation1Vo=debtRelation1VoDic;
    [self.navigationController pushViewController:addinfo animated:YES];
    
}
//债务人查询
- (IBAction)DebtWuPersonBtnAction:(id)sender {
    [self.view endEditing:YES];
    NSString * action=[NSString stringWithFormat:@"api/search?wd=%@",DebtWuPersonHaomaTF.text];
    [self showProgress];
    [ZJDeBtManageRequest GetsearchDebtPersonWithActions:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        // 请求成功
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                DebtWuPersonNameTF.text=[NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"name"]];
                DebtWuPersonHaomaTFIDText=[NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"id"]];
                if (self.Btntype==1){//行长
                    [debtRelation1VoDic setObject:DebtWuPersonHaomaTFIDText forKey:@"startId"];    //债务人
                }
            }else{
                UIAlertView * alteview=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"系统内未找到证件号为%@的债务人信息",DebtWuPersonHaomaTF.text] delegate:self cancelButtonTitle:@"现在创建" otherButtonTitles:@"再确认一下", nil];
                alteview.tag=501;
                [alteview show];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
    }];
    
}
//债权人查询
- (IBAction)DebtQuanPersonBtnAction:(id)sender {
    [self.view endEditing:YES];
    NSString * action=[NSString stringWithFormat:@"api/search?wd=%@",DebtQuanPersonHaomaTF.text];
    [self showProgress];
    [ZJDeBtManageRequest GetsearchDebtPersonWithActions:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        // 请求成功
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                DebtQuanPersonNameTF.text=[NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"name"]];
                DebtQuanPersonHaomaIDText=[NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"id"]];
                if (self.Btntype==1){//行长
                    [debtRelation1VoDic setObject:DebtQuanPersonHaomaIDText forKey:@"endId"];   //债权人
                }
            }else{
                UIAlertView * alteview=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"系统内未找到证件号为%@的债权人信息",DebtQuanPersonHaomaTF.text] delegate:self cancelButtonTitle:@"现在创建" otherButtonTitles:@"再确认一下", nil];
                alteview.tag=502;
                [alteview show];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
    }];
    
}
//债事人查询
- (IBAction)DebtShiPersonBtnAction:(id)sender {
    [self.view endEditing:YES];
    NSString * action=[NSString stringWithFormat:@"api/search?wd=%@",DebtShiPersonHaomaTF.text];
    [self showProgress];
    [ZJDeBtManageRequest GetsearchDebtPersonWithActions:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        // 请求成功
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                DebtShiPersonNameTF.text=[NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"name"]];
                DebtShiPersonHaomaIDText=[NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"id"]];
                if (self.Btntype==2){
                    if ([[debtRelation1VoDic objectForKey:@"isDebt"]isEqualToString:@"0"]) {
                        [debtRelation1VoDic setObject:DebtShiPersonHaomaIDText forKey:@"endId"];  //债权人身份证号
                    }
                    if ([[debtRelation1VoDic objectForKey:@"isDebt"]isEqualToString:@"1"]) {
                        [debtRelation1VoDic setObject:DebtShiPersonHaomaIDText forKey:@"startId"];  //债权人身份证号
                    }
                }
            }else{
                UIAlertView * alteview=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"系统内未找到证件号为%@的债事人信息",DebtShiPersonHaomaTF.text] delegate:self cancelButtonTitle:@"现在创建" otherButtonTitles:@"再确认一下", nil];
                alteview.tag=503;
                [alteview show];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
    }];
    
}
#pragma mark-- 调到新增债事人
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        ZJAddDebtPersonController * addDebtVC=[[ZJAddDebtPersonController alloc]initWithNibName:@"ZJAddDebtPersonController" bundle:nil];
        if (alertView.tag==501) {
            addDebtVC.DebtPersonNumString=DebtWuPersonHaomaTF.text;
        }else if (alertView.tag==502){
            addDebtVC.DebtPersonNumString=DebtQuanPersonHaomaTF.text;
        }else if (alertView.tag==503){
            addDebtVC.DebtPersonNumString=DebtShiPersonHaomaTF.text;
        }
        addDebtVC.formwhere=@"addDebtInfo";
        [addDebtVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:addDebtVC animated:YES];
    }
    
}
//债权人
- (IBAction)DebtShiPersonQuanBtnAction:(id)sender {
    [self.view endEditing:YES];
    [DebtShiPersonQuanBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [DebtShiPersonWuBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation1VoDic setObject:@"0" forKey:@"isDebt"]; //债权人
    [debtRelation1VoDic setObject:DebtShiPersonHaomaIDText forKey:@"endId"];  //债权人身份证号
}

//债务人
- (IBAction)DebtShiPersonWuBtnAction:(id)sender {
    [self.view endEditing:YES];
    [DebtShiPersonQuanBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [DebtShiPersonWuBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [debtRelation1VoDic setObject:@"1" forKey:@"isDebt"]; //债务人
    [debtRelation1VoDic setObject:DebtShiPersonHaomaIDText forKey:@"startId"];  //债务人身份证号
}
//货币
- (IBAction)DebtTypeMoneyBtnAction:(id)sender {
    [self.view endEditing:YES];
    [DebtTypeMoneyBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [DebtTypeNoMoneyBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation1VoDic setObject:@"1" forKey:@"genre"];   //债事类型
}

//非货币
- (IBAction)DebtTypeNoMoneyBtnAction:(id)sender {
    [self.view endEditing:YES];
    [DebtTypeMoneyBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [DebtTypeNoMoneyBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [debtRelation1VoDic setObject:@"2" forKey:@"genre"];   //债事类型
}
//个人
- (IBAction)DebtPersonBtnAction:(id)sender {
    [self.view endEditing:YES];
    [DebtPersonBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [DebtCompanyBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [self reJianview];
    [debtRelation1VoDic setObject:@"1" forKey:@"natureOf"];  //债事性质
}
//企业
- (IBAction)DebtCommpanyBtnAction:(id)sender {
    [self.view endEditing:YES];
    [DebtPersonBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [DebtCompanyBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [self reAddview];
    [debtRelation1VoDic setObject:@"2" forKey:@"natureOf"];  //债事性质
    [debtRelation1VoDic setObject:@"1" forKey:@"nature"];  //债事性质
}
//国有
- (IBAction)GuoyouCompanyBtnAction:(id)sender {
    [self.view endEditing:YES];
    [GuoyouCompanyBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [SiqiCompanyBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation1VoDic setObject:@"1" forKey:@"nature"];  //债事性质
}
//私企
- (IBAction)SiqiCompanyBtnAction:(id)sender {
    [self.view endEditing:YES];
    [GuoyouCompanyBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [SiqiCompanyBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [debtRelation1VoDic setObject:@"2" forKey:@"nature"];  //债事性质
}
//非诉讼
- (IBAction)DebtNolitigationBtnAction:(id)sender {
    [self.view endEditing:YES];
    [DebtNoLitigationBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [DebtLitigationBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [debtRelation1VoDic setObject:@"0" forKey:@"isLawsuit"];   //诉讼情况
}
//已诉讼
- (IBAction)DebtLitigationBtnAction:(id)sender {
    [self.view endEditing:YES];
    [DebtNoLitigationBtn setImage:[UIImage imageNamed:@"button-gray"] forState:UIControlStateNormal];
    [DebtLitigationBtn setImage:[UIImage imageNamed:@"button-red"] forState:UIControlStateNormal];
    [debtRelation1VoDic setObject:@"1" forKey:@"isLawsuit"];   //诉讼情况
}
#pragma mark--选择时间
-(void)DebtTimeBtnAction
{
    DebtTimeView.hidden=NO;
    [cancelBtn addTarget:self action:@selector(cancelPicker:) forControlEvents:UIControlEventTouchUpInside];
    [OKbtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.maximumDate= [NSDate date];//今天
    NSString *minStr = @"1949-10-01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *minDate = [dateFormatter dateFromString:minStr];
    datePicker.minimumDate=minDate;
    [datePicker addTarget:self action:@selector(datePickerClick:) forControlEvents:UIControlEventValueChanged];
    
}
- (void)cancelPicker:(UIButton *)cancel
{
    DebtTimeView.hidden=YES;
}

-(void)datePickerClick:(id)sender
{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* birthday = control.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    DebtTimestring= [dateFormatter stringFromDate:birthday];
    
}
-(void)buttonClick
{
    DebtTimeView.hidden=YES;
    DebtTimeTF.text=DebtTimestring;
    [debtRelation1VoDic setObject:DebtTimeTF.text forKey:@"recordTime"];   //债事发生时间
}


#pragma mark--键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [BackScrollview setContentOffset:CGPointMake(0, scrollViewOffSetY-beforeMigrationY) animated:YES];
    beforeMigrationY = 0.0;
    if (textField==MainMoneyTF) {
        [debtRelation1VoDic setObject:MainMoneyTF.text forKey:@"amout"];   //金额
    }
    if (textField==RefereeTF) {
        [debtRelation1VoDic setObject:RefereeTF.text forKey:@"recordTime"];   //推荐人
    }
    if (self.Btntype==1){//行长
        if (textField==DebtWuPersonHaomaTF) {
            [debtRelation1VoDic setObject:DebtWuPersonHaomaTFIDText forKey:@"startId"];    //债务人
        }
        if (textField==DebtQuanPersonHaomaTF) {
            [debtRelation1VoDic setObject:DebtQuanPersonHaomaIDText forKey:@"endId"];   //债权人
        }
    }else if (self.Btntype==2){
        if (textField==DebtShiPersonHaomaTF) {
            if ([[debtRelation1VoDic objectForKey:@"isDebt"]isEqualToString:@"0"]) {
                [debtRelation1VoDic setObject:DebtShiPersonHaomaIDText forKey:@"endId"];  //债权人身份证号
            }
            if ([[debtRelation1VoDic objectForKey:@"isDebt"]isEqualToString:@"1"]) {
                [debtRelation1VoDic setObject:DebtShiPersonHaomaIDText forKey:@"startId"];  //债权人身份证号
            }
        }
        
    }
}

-(void)hideKeyboard{
    [self.view endEditing:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    /* scrollView 的偏移量*/
    CGFloat offSetY = scrollView.contentOffset.y;
    scrollViewOffSetY = offSetY;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    /* 获取当前cell的位置*/
    CGFloat Hieght = textField.superview.frame.origin.y;
    /* 获取当前点击Cell的位置*/
    CGFloat CurrentCellY = Hieght - scrollViewOffSetY;
    /* 获取剩余高度*/
    CGFloat lastHeight = ZJAPPHeight-64 - CurrentCellY;
    
    remainingDistanceY = lastHeight;
    
    /* 获取键盘的开始高度*/
    CGFloat keyBoardStart = 271;
    if (remainingDistanceY<keyBoardStart) {
        /* 获取差值*/
        CGFloat differenceValue = keyBoardStart -remainingDistanceY;
        beforeMigrationY = differenceValue;
        [BackScrollview setContentOffset:CGPointMake(0, differenceValue + scrollViewOffSetY) animated:YES];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    /* 防止错乱停止编辑*/
    [self.view endEditing:YES];
}

- (void)seeProtcol
{
    //协议
    protolAlterView=[[ZJProtocolAlterView alloc]initWithProtocoltype:@"中金债事快捷支付服务协议" withTitle:@"一、概述\n1、本快捷支付服务协议（以下简称“本协议”）由中金债事（北京）网络科技有限公司（以下简称“中金债事”）与您就快捷支付服务所订立的有效合约。您通过网络页面点击确认本协议或以其他方式选择接受本协议，即表示您与中金债事已达成协议并同意接受本协议的全部约定内容。\n2、在接受本协议之前，请您仔细阅读本协议的全部内容（特别是以粗体下划线标注的内容 ）。如您不同意接受本协议的任意内容，或者无法准确理解相关条款含义的，请不要进行后续操作。如果您对本协议的条款有疑问的，请通过中金债事客服渠道进行询问（客服电话为4000689588），中金债事将向您解释条款内容。\n3、您同意，中金债事有权随时对本协议内容进行单方面的变更，并以在www.zhongjinzhaishi.com网站公告的方式提前予以公布，无需另行单独通知您；若您在本协议内容公告变更生效后继续使用本服务的，表示您已充分阅读、理解并接受变更修改后的协议内容，也将遵循变更修改后的协议内容使用本服务；若您不同意变更修改后的协议内容，您应在变更生效前停止使用本服务。\n\n二、双方权利义务\n1、您应确保您是使用本服务的银行卡持有人，可合法、有效使用该银行卡且未侵犯任何第三方合法权益，否则因此造成中金债事、持卡人损失的，您应负责赔偿并承担全部法律责任，包括但不限于对您的债云端账户中的余额进行止付、终止或中止为您提供支付服务，从您的前述支付宝账户中扣除相应的款项等。\n2、您应确保开通本服务所提供的手机号码为本人所有，并授权中金债事可以通过第三方渠道对您所提供手机号码的真实性、有效性进行核实。\n3、您同意中金债事有权依据其自身判断对涉嫌欺诈或被他人控制并用于欺诈目的的债云端账户采取相应的措施，上述措施包括但不限于对您的债云端账户中的余额进行止付、终止或中止为您提供支付服务、处置涉嫌欺诈的资金等。\n4、您应妥善保管银行卡、卡号、密码、发卡行预留的手机号码以及债云端账号、密码、数字证书、支付盾、宝令、手机动态口令、债云端账户绑定的手机号码、来自于发卡行和/或债云端向您发送的校验码等与银行卡或与债云端账户有关的一切信息和设备如您遗失或泄露前述信息和/或设备的，您应及时通知发卡行及/或中金债事，以减少可能发生的损失。无论是否已通知发卡行及/或中金债事，因您的原因所致损失需由您自行承担。\n5、您在使用本服务时，应当认真确认交易信息，包括且不限于商品名称、数量、金额等，并按中金债事业务流程发出符合《中金债事快捷支付服务协议》约定的指令。您认可和同意：您发出的指令不可撤回或撤销，中金债事一旦根据您的指令委托银行或第三方从银行卡中划扣资金给收款人，您不应以非本人意愿交易或其他任何原因要求中金债事退款或承担其他责任。\n6、您在对使用本服务过程中发出指令的真实性及有效性承担全部责任；您承诺，中金债事依照您的指令进行操作的一切风险由您承担。\n7、您认可债云端账户的使用记录数据、交易金额数据等均以债云端系统平台记录的数据为准。\n8、您同意债云端有权留存您在债云端网站填写的相应信息，并授权中金债事查询该银行卡信息，包括且不限于借记卡余额、信用卡账单等内容，以供后续向您持续性地提供相应服务（包括但不限于将本信息用于向您推广、提供其他更加优质的产品或服务）。\n9、出现下列情况之一的，中金债事有权立即终止您使用债云端相关服务而无需承担任何责任：（1）将本服务用于非法目的；（2）违反本协议的约定；（3）违反中金债事及/或中金债事关联公司及/或中金债事旗下其他公司网站的条款、协议、规则、通告等相关规定及您与前述主体签署的任一协议，而被上述任一主体终止提供服务的；（4）中金债事认为向您提供本服务存在风险的；（5）您的银行卡无效、有效期届满或注销（如有）。\n10、若您未违反本协议约定且因不能归责于您的原因，造成银行卡内资金通过本服务出现损失，且您未从中获益的，您可向中金债事申请补偿。您应在知悉资金发生损失后及时通知中金债事并按要求提交相关的申请材料和证明文件，中金债事将通过自行补偿或保险公司赔偿的方式处理您的申请。具体处理方式由中金债事自行选择决定，中金债事承诺不会因此损害您的合法权益。如中金债事选择保险赔偿的方式，您同意委托中金债事为您向保险公司索赔，并且您承诺：资金损失事实真实存在，保险赔偿申请材料真实、有效。您已充分知晓并认识到，基于虚假信息申请保险赔偿将涉及刑事犯罪，保险公司与中金债事有权向国家有关机构申请刑事立案侦查。\n11、不论中金债事选择何种方式保障您使用本服务的资金安全，您同意并认可中金债事最终的补偿行为或保险赔偿行为并不代表前述资金损失应归责于中金债事，亦不代表中金债事须为此承担其他任何责任。您同意，中金债事在向您支付补偿的同时，即刻取得您可能或确实存在的就前述资金损失而产生的对第三方的所有债权及其他权利，包括但不限于就上述债权向第三方追偿的权利，且您不再就上述已经让渡给中金债事的债权向该第三方主张任何权利，亦不再就资金损失向中金债事主张任何权利。\n12、若您又从其它渠道挽回了资金损失的，或有新证据证明您涉嫌欺诈的，或者发生您应当自行承担责任的其他情形，您应在第一时间通知中金债事并将返还中金债事已补偿或保险公司已赔偿的款项，否则中金债事有权自行或根据保险公司委托采取包括但不限于从您全部或部分债云端账户（含该账户之关联账户）划扣等方式向您进行追偿。\n\n三、承诺与保证\n1、您保证使用本服务过程中提供的信息真实、准确、完整、有效，您为了使用本服务向中金债事提供的所有信息，如姓名、身份证号、银行卡卡号及预留手机号，将全部成为您债云端账户信息的一部分。中金债事按照您设置的相关信息为您提供相应服务，对于因您提供信息不真实或不完整所造成的损失由您自行承担。\n2、您授权中金债事在您使用本服务期间或本服务终止后，有权保留您在使用本服务期间所形成的相关信息数据，同时该授权不可撤销。\n\n四、其他条款\n1、因本协议产生之争议，均应依照中华人民共和国法律予以处理，并由被告住所地人民法院管辖。\n2、您同意，本协议之效力、解释、变更、执行与争议解决均适用中华人民共和国法律，没有相关法律规定的，参照通用国际商业惯例和（或）行业惯例。\n3、本协议部分内容被有管辖权的法院认定为违法或无效的，不因此影响其他内容的效力。\n4、本协议未约定事宜，均以中金债事不时公布的《中金债事快捷支付服务协议》及相关附属规则为补充。"];
    protolAlterView.delegate=self;
    [protolAlterView show];
    
}
//协议的代理方法
- (void)zjProtocolAlertClikButtonIndex:(NSInteger)index alert:(ZJProtocolAlterView *)alert;{
    
    if (index == 2001) {
        [protolAlterView dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (index==2002){
        if (alert.isAgree) {
            [protolAlterView dismiss];
        }else{
            [ANAlert showAlertWithString:@"请阅读并同意用户协议" andTarget:self];
        }
        
    }
    
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
