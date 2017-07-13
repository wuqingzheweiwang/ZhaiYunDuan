//
//  ZJDebtBankViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/4/23.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

#define hScale ([UIScreen mainScreen].bounds.size.height) / 667
//字体大小
#define kfont 15

#import "ZJDebtBankViewController.h"
#import "ZJProtocolAlterView.h"
#import "ZJHomeViewController.h"
#import "ZJPayMoneyViewController.h"
#import "ZJHomeRequest.h"
#import "JHPickView.h"
#import "CityModelData.h"

@interface ZJDebtBankViewController ()<ZJProtocolAlterDelegate,UITextFieldDelegate,JHPickerDelegate>
{
    NSString *_provinceId;
    NSString *_cityId;
    NSString *_distristId;
}
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *idCardNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *idCardNumeberTextField;
@property (weak, nonatomic) IBOutlet UILabel *telePhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *telePhoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *workDressLabel;
@property (weak, nonatomic) IBOutlet UIButton *shengprovinceBut;
@property (weak, nonatomic) IBOutlet UILabel *recommendPersonLabel;
@property (weak, nonatomic) IBOutlet UITextField *recommendPersonTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitSendBut;
@property (nonatomic , strong)  NSMutableArray *province_nameArrM;
@property (nonatomic , strong)  NSMutableArray *city_nameArrM;
@property (nonatomic , strong)  NSMutableArray *county_nameArrM;
@property (nonatomic , strong)  NSMutableArray *province_idArrM;
@property (nonatomic , strong)  NSMutableArray *city_idArrM;
@property (nonatomic , strong)  NSMutableArray *county_idArrM;
@property (nonatomic , strong)  NSString *orderId;
@property (nonatomic , strong)  NSString *payAmount;

@end

@implementation ZJDebtBankViewController
{
    ZJProtocolAlterView * protoAlterview;
    NSString *_type;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"开通债行"];
    [self performSelector:@selector(setProtrolAlert) withObject:nil afterDelay:0.2f];
    
    [self setDebtUI];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//   [NSThread detachNewThreadSelector:@selector(loadaddressData) toTarget:self withObject:nil];
//}



-(void)setDebtUI
{
    // 用户名
    _userNameLabel.top = (45/2+64);
    _userNameLabel.left = (30/2);
    _userNameLabel.width = (140/2);
    _userNameLabel.height = (33);
    
    // 输入用户名
    _userNameTextField.top = _userNameLabel.top;
    _userNameTextField.left = _userNameLabel.right;
    _userNameTextField.width = ZJAPPWidth-30-_userNameLabel.width;
    _userNameTextField.height = _userNameLabel.height;
    _userNameTextField.layer.borderWidth=1;
    _userNameTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _userNameTextField.layer.masksToBounds = YES;
    _userNameTextField.layer.cornerRadius = 5;
    _userNameTextField.delegate = self;
    
    // 身份证号
    _idCardNumberLabel.top = _userNameLabel.bottom+(40/2);
    _idCardNumberLabel.left =_userNameLabel.left;
    _idCardNumberLabel.width =_userNameLabel.width;
    _idCardNumberLabel.height = _userNameLabel.height;

    // 输入身份证号
    _idCardNumeberTextField.top = _idCardNumberLabel.top;
    _idCardNumeberTextField.left = _userNameTextField.left;
    _idCardNumeberTextField.width = _userNameTextField.width;
    _idCardNumeberTextField.height = _userNameTextField.height;
    _idCardNumeberTextField.layer.borderWidth=1;
    _idCardNumeberTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _idCardNumeberTextField.layer.masksToBounds = YES;
    _idCardNumeberTextField.layer.cornerRadius = 5;
    _idCardNumeberTextField.delegate = self;

    // 手机号
    _telePhoneNumberLabel.top =_idCardNumberLabel.bottom+(40/2);;
    _telePhoneNumberLabel.left =_idCardNumberLabel.left;
    _telePhoneNumberLabel.width =_idCardNumberLabel.width;
    _telePhoneNumberLabel.height = _idCardNumberLabel.height;
    
    // 输入手机号
    _telePhoneTextField.top = _idCardNumeberTextField.bottom+(40/2);
    _telePhoneTextField.left = _idCardNumeberTextField.left;
    _telePhoneTextField.width = _idCardNumeberTextField.width;
    _telePhoneTextField.height = _idCardNumeberTextField.height;
    _telePhoneTextField.layer.borderWidth=1;
    _telePhoneTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _telePhoneTextField.layer.masksToBounds = YES;
    _telePhoneTextField.layer.cornerRadius = 5;
    _telePhoneTextField.delegate = self;
    _telePhoneTextField.keyboardType = UIKeyboardTypeNumberPad;

    // 从业地址
    _workDressLabel.top = _telePhoneNumberLabel.bottom+(40/2);
    _workDressLabel.left = _telePhoneNumberLabel.left;
    _workDressLabel.width = _telePhoneNumberLabel.width;
    _workDressLabel.height = _telePhoneNumberLabel.height;
    
    // 输入省
    _shengprovinceBut.top = _workDressLabel.top;
    _shengprovinceBut.left = _telePhoneTextField.left;
    _shengprovinceBut.width = _telePhoneTextField.width;
    _shengprovinceBut.height = _telePhoneTextField.height;
    [_shengprovinceBut setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
    _shengprovinceBut.layer.borderWidth=1;
    _shengprovinceBut.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _shengprovinceBut.layer.masksToBounds = YES;
    _shengprovinceBut.layer.cornerRadius = 5;
    _shengprovinceBut.titleLabel.textAlignment = NSTextAlignmentLeft;
    _shengprovinceBut.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    [_shengprovinceBut addTarget:self action:@selector(enterAddress) forControlEvents:UIControlEventTouchUpInside];
    
    // 推荐人Label
    _recommendPersonLabel.top = _workDressLabel.bottom+(40/2);
    _recommendPersonLabel.left = _workDressLabel.left;
    _recommendPersonLabel.width = _workDressLabel.width;
    _recommendPersonLabel.height = _workDressLabel.height;

    // 输入推荐人
    _recommendPersonTextField.top = _shengprovinceBut.bottom+(40/2);
    _recommendPersonTextField.left = _telePhoneTextField.left;
    _recommendPersonTextField.width = _telePhoneTextField.width;
    _recommendPersonTextField.height = _telePhoneTextField.height;
    _recommendPersonTextField.delegate = self;
    _recommendPersonTextField.layer.borderWidth=1;
    _recommendPersonTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _recommendPersonTextField.layer.masksToBounds = YES;
    _recommendPersonTextField.layer.cornerRadius = 5;
    _recommendPersonTextField.delegate = self;

    // 提交
    _submitSendBut.bottom = ZJAPPHeight-(60);
    _submitSendBut.left = (90/2);
    _submitSendBut.width = (ZJAPPWidth-(90)) ;
    _submitSendBut.height = 35;
    _submitSendBut.layer.masksToBounds = YES;
    _submitSendBut.layer.cornerRadius = 5;
    
    
}

// 选择地址
- (void)enterAddress {
    
    for (UITextField* textFieldsubView in self.view.subviews)
    {
        [textFieldsubView resignFirstResponder];
    }

    // 弹出视图
    JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
    picker.delegate = self;
    picker.arrayType = AreaArray;
    [self.view addSubview:picker];
}

#pragma mark - JHPickerDelegate

-(void)PickerSelectorInAllAreaDic:(NSDictionary *)allArea provinceID:(NSString *)prvoinceId cityID:(NSString *)cityId areaID:(NSString *)areaId{
    
    _provinceId = prvoinceId;
    _cityId = cityId;
    _distristId = areaId;
 
    DLog(@"%@ %@ %@",_provinceId,_cityId,_distristId);
    NSString *cityArea = [NSString stringWithFormat:@"%@%@%@",[allArea objectForKey:prvoinceId],[allArea objectForKey:cityId],[allArea objectForKey:areaId]];
    [self.shengprovinceBut setTitle:cityArea forState:UIControlStateNormal];

}



#pragma mark ZJProtocolAlterDelegate
- (void)zjProtocolAlertClikButtonIndex:(NSInteger)index alert:(ZJProtocolAlterView *)alert
{
    if (index == 2001) {
        [protoAlterview dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (index==2002){
        if (alert.isAgree) {
            [protoAlterview dismiss];
        }else{
            [ANAlert showAlertWithString:@"请阅读并同意用户协议" andTarget:self];
        }
        
    }
    

}


// 提交
- (IBAction)allSender:(id)sender {
    
    
    for (UITextField* textFieldsubView in self.view.subviews)
    {
        [textFieldsubView resignFirstResponder];
    }
    if( [ZJUtil isEmptyStr:_userNameTextField.text])
    {
        [ZJUtil showBottomToastWithMsg:@"请输入姓名/企业"];
        return;
    }
    if (![ZJUtil isIDCard:_idCardNumeberTextField.text]) {
        [ZJUtil showBottomToastWithMsg:@"请输入正确的身份证号"];
        return;
    }
    if(![ZJUtil isMobileNo:_telePhoneTextField.text])
    {
        [ZJUtil showBottomToastWithMsg:@"请输入正确的手机号"];
        return;
    }
//    if ([ZJUtil isEmptyStr:_shengprovinceTextField.text]) {
//        [ZJUtil showBottomToastWithMsg:@"请输入您所在的省份"];
//        return;
//    }
//    if ([ZJUtil isEmptyStr:_cityTextField.text]) {
//        [ZJUtil showBottomToastWithMsg:@"请输入您所在的市"];
//        return;
//    }
//    if ([ZJUtil isEmptyStr:_xiancountyTextField.text]) {
//        [ZJUtil showBottomToastWithMsg:@"请输入您所在的县(区)"];
//        return;
//    }
    
    [self getDebtDataRequest];
    
    
    
}


// 开通债行请求
-(void)getDebtDataRequest
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:_userNameTextField.text,@"realname",_idCardNumeberTextField.text,@"idNumber",_telePhoneTextField.text,@"mobile",_recommendPersonTextField.text,@"recommendCode",_provinceId,@"provinceId",_cityId,@"cityId",_distristId,@"countyId",nil];
        [self performSelectorOnMainThread:@selector(showProgress) withObject:self waitUntilDone:YES];

    // 网络请求
    [ZJHomeRequest zjPOSTDebtRequestWithParams:dic result:^(BOOL success, id responseData) {
        
        [self performSelectorOnMainThread:@selector(dismissProgress) withObject:self waitUntilDone:YES];

        // 成功
        if (success) {
            
            // 后台设定成功
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
               
                self.orderId =[[responseData objectForKey:@"data"]objectForKey:@"openOrderId"];
                self.payAmount =[[responseData objectForKey:@"data"]objectForKey:@"payAmount"];

                ZJPayMoneyViewController * payViewController = [[ZJPayMoneyViewController alloc]initWithNibName:@"ZJPayMoneyViewController" bundle:nil];
                payViewController.orderid = self.orderId;
                payViewController.type = @"2";
                payViewController.payAmount = self.payAmount;
                [self.navigationController pushViewController:payViewController animated:YES];
                

            }else{
                
               [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            
            [ZJUtil showBottomToastWithMsg:@"系统异常"];
        }
        
    }];
    

}


- (void)textFieldDidBeginEditing:(UITextField *)textField

{

    
    CGRect frame = textField.frame;
    
    CGFloat heights = self.view.frame.size.height;
    
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    
    int offset = frame.origin.y + 42- ( heights - 216.0-35.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.view.frame.size.width;
    
    float height = self.view.frame.size.height;
    
    if(offset > 0)
        
    {
        
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        
        self.view.frame = rect;
        
    }
    
    [UIView commitAnimations];
    
}


/**
 
 *  textField 取消选中状态
 
 *
 
 */

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{

    
    [self.view endEditing:YES];
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];

}

// 菊花
- (void)showProgress
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)dismissProgress
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)setProtrolAlert
{
    [self.view endEditing:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    protoAlterview=[[ZJProtocolAlterView alloc]initWithProtocoltype:@"中金债事快捷支付服务协议" withTitle:@"一、概述\n1、本快捷支付服务协议（以下简称“本协议”）由中金债事（北京）网络科技有限公司（以下简称“中金债事”）与您就快捷支付服务所订立的有效合约。您通过网络页面点击确认本协议或以其他方式选择接受本协议，即表示您与中金债事已达成协议并同意接受本协议的全部约定内容。\n2、在接受本协议之前，请您仔细阅读本协议的全部内容（特别是以粗体下划线标注的内容 ）。如您不同意接受本协议的任意内容，或者无法准确理解相关条款含义的，请不要进行后续操作。如果您对本协议的条款有疑问的，请通过中金债事客服渠道进行询问（客服电话为4000689588），中金债事将向您解释条款内容。\n3、您同意，中金债事有权随时对本协议内容进行单方面的变更，并以在www.zhongjinzhaishi.com网站公告的方式提前予以公布，无需另行单独通知您；若您在本协议内容公告变更生效后继续使用本服务的，表示您已充分阅读、理解并接受变更修改后的协议内容，也将遵循变更修改后的协议内容使用本服务；若您不同意变更修改后的协议内容，您应在变更生效前停止使用本服务。\n\n二、双方权利义务\n1、您应确保您是使用本服务的银行卡持有人，可合法、有效使用该银行卡且未侵犯任何第三方合法权益，否则因此造成中金债事、持卡人损失的，您应负责赔偿并承担全部法律责任，包括但不限于对您的债云端账户中的余额进行止付、终止或中止为您提供支付服务，从您的前述支付宝账户中扣除相应的款项等。\n2、您应确保开通本服务所提供的手机号码为本人所有，并授权中金债事可以通过第三方渠道对您所提供手机号码的真实性、有效性进行核实。\n3、您同意中金债事有权依据其自身判断对涉嫌欺诈或被他人控制并用于欺诈目的的债云端账户采取相应的措施，上述措施包括但不限于对您的债云端账户中的余额进行止付、终止或中止为您提供支付服务、处置涉嫌欺诈的资金等。\n4、您应妥善保管银行卡、卡号、密码、发卡行预留的手机号码以及债云端账号、密码、数字证书、支付盾、宝令、手机动态口令、债云端账户绑定的手机号码、来自于发卡行和/或债云端向您发送的校验码等与银行卡或与债云端账户有关的一切信息和设备如您遗失或泄露前述信息和/或设备的，您应及时通知发卡行及/或中金债事，以减少可能发生的损失。无论是否已通知发卡行及/或中金债事，因您的原因所致损失需由您自行承担。\n5、您在使用本服务时，应当认真确认交易信息，包括且不限于商品名称、数量、金额等，并按中金债事业务流程发出符合《中金债事快捷支付服务协议》约定的指令。您认可和同意：您发出的指令不可撤回或撤销，中金债事一旦根据您的指令委托银行或第三方从银行卡中划扣资金给收款人，您不应以非本人意愿交易或其他任何原因要求中金债事退款或承担其他责任。\n6、您在对使用本服务过程中发出指令的真实性及有效性承担全部责任；您承诺，中金债事依照您的指令进行操作的一切风险由您承担。\n7、您认可债云端账户的使用记录数据、交易金额数据等均以债云端系统平台记录的数据为准。\n8、您同意债云端有权留存您在债云端网站填写的相应信息，并授权中金债事查询该银行卡信息，包括且不限于借记卡余额、信用卡账单等内容，以供后续向您持续性地提供相应服务（包括但不限于将本信息用于向您推广、提供其他更加优质的产品或服务）。\n9、出现下列情况之一的，中金债事有权立即终止您使用债云端相关服务而无需承担任何责任：（1）将本服务用于非法目的；（2）违反本协议的约定；（3）违反中金债事及/或中金债事关联公司及/或中金债事旗下其他公司网站的条款、协议、规则、通告等相关规定及您与前述主体签署的任一协议，而被上述任一主体终止提供服务的；（4）中金债事认为向您提供本服务存在风险的；（5）您的银行卡无效、有效期届满或注销（如有）。\n10、若您未违反本协议约定且因不能归责于您的原因，造成银行卡内资金通过本服务出现损失，且您未从中获益的，您可向中金债事申请补偿。您应在知悉资金发生损失后及时通知中金债事并按要求提交相关的申请材料和证明文件，中金债事将通过自行补偿或保险公司赔偿的方式处理您的申请。具体处理方式由中金债事自行选择决定，中金债事承诺不会因此损害您的合法权益。如中金债事选择保险赔偿的方式，您同意委托中金债事为您向保险公司索赔，并且您承诺：资金损失事实真实存在，保险赔偿申请材料真实、有效。您已充分知晓并认识到，基于虚假信息申请保险赔偿将涉及刑事犯罪，保险公司与中金债事有权向国家有关机构申请刑事立案侦查。\n11、不论中金债事选择何种方式保障您使用本服务的资金安全，您同意并认可中金债事最终的补偿行为或保险赔偿行为并不代表前述资金损失应归责于中金债事，亦不代表中金债事须为此承担其他任何责任。您同意，中金债事在向您支付补偿的同时，即刻取得您可能或确实存在的就前述资金损失而产生的对第三方的所有债权及其他权利，包括但不限于就上述债权向第三方追偿的权利，且您不再就上述已经让渡给中金债事的债权向该第三方主张任何权利，亦不再就资金损失向中金债事主张任何权利。\n12、若您又从其它渠道挽回了资金损失的，或有新证据证明您涉嫌欺诈的，或者发生您应当自行承担责任的其他情形，您应在第一时间通知中金债事并将返还中金债事已补偿或保险公司已赔偿的款项，否则中金债事有权自行或根据保险公司委托采取包括但不限于从您全部或部分债云端账户（含该账户之关联账户）划扣等方式向您进行追偿。\n\n三、承诺与保证\n1、您保证使用本服务过程中提供的信息真实、准确、完整、有效，您为了使用本服务向中金债事提供的所有信息，如姓名、身份证号、银行卡卡号及预留手机号，将全部成为您债云端账户信息的一部分。中金债事按照您设置的相关信息为您提供相应服务，对于因您提供信息不真实或不完整所造成的损失由您自行承担。\n2、您授权中金债事在您使用本服务期间或本服务终止后，有权保留您在使用本服务期间所形成的相关信息数据，同时该授权不可撤销。\n\n四、其他条款\n1、因本协议产生之争议，均应依照中华人民共和国法律予以处理，并由被告住所地人民法院管辖。\n2、您同意，本协议之效力、解释、变更、执行与争议解决均适用中华人民共和国法律，没有相关法律规定的，参照通用国际商业惯例和（或）行业惯例。\n3、本协议部分内容被有管辖权的法院认定为违法或无效的，不因此影响其他内容的效力。\n4、本协议未约定事宜，均以中金债事不时公布的《中金债事快捷支付服务协议》及相关附属规则为补充。"];
    protoAlterview.delegate=self;
    [protoAlterview show];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
