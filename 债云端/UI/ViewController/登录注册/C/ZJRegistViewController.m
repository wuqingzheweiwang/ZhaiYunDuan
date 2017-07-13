//
//  ZJRegistViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/4/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJRegistViewController.h"
#import "ZJProtocolAlterView.h"
#import "ZJLoginRegistRequest.h"
#define  KBaseColor @"0xE7554F"

@interface ZJRegistViewController ()<UITextFieldDelegate,ZJProtocolAlterDelegate>
{
    ZJProtocolAlterView * protoAlterview;
}

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UITextField *NameTextField;
@property (weak, nonatomic) IBOutlet UILabel *cardIdLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardIdTextField;
@property (weak, nonatomic) IBOutlet UILabel *telePhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *telePhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UILabel *VerificationCode;
@property (weak, nonatomic) IBOutlet UITextField *VerificationTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendVerification;
@property (weak, nonatomic) IBOutlet UILabel *passWordLabel;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UILabel *confirmPassWordLabel;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassWordTextField;
@property (weak, nonatomic) IBOutlet UILabel *commandLabel;

@property (weak, nonatomic) IBOutlet UITextField *commandTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *yesBut;
@property (weak, nonatomic) IBOutlet UIButton *readAndagreeLabel;
@property (weak, nonatomic) IBOutlet UIButton *protorclBut;
@property (weak, nonatomic) IBOutlet UIButton *registerBut;

@end

@implementation ZJRegistViewController
{
    UIImageView *imageV;
    BOOL isAgree;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRegisterUI];
//    [NSThread detachNewThreadSelector:@selector(request) toTarget:self withObject:nil];
}

-(void)setRegisterUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"注册"];
    CGFloat margin =TRUE_1(18);
    // 用户名
    _NameLabel.top = TRUE_1(20)+64;
    _NameLabel.left = TRUE_1(15);
    _NameLabel.width = TRUE_1(135/2);
    _NameLabel.height = TRUE_1(33);
    _NameLabel.font = ZJ_TRUE_FONT(15);
    // 输入用户名
    _NameTextField.top =_NameLabel.top;
    _NameTextField.left = _NameLabel.right+margin;
    _NameTextField.width = (ZJAPPWidth - TRUE_1(30))-_NameLabel.width-margin;
    _NameTextField.height = _NameLabel.height;
    _NameTextField.layer.borderWidth=1;
    _NameTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _NameTextField.layer.masksToBounds = YES;
    _NameTextField.layer.cornerRadius = 5;
    _NameTextField.delegate = self;

    // 身份证Label
    _cardIdLabel.top = _NameLabel.bottom+TRUE_1(20);
    _cardIdLabel.left = _NameLabel.left;
    _cardIdLabel.width = _NameLabel.width;
    _cardIdLabel.height = _NameLabel.height;
    _cardIdLabel.font = ZJ_TRUE_FONT(15);
    
    // 输入身份证TextField
    _cardIdTextField.top = _cardIdLabel.top;
    _cardIdTextField.left = _NameTextField.left;
    _cardIdTextField.width = _NameTextField.width;
    _cardIdTextField.height = _NameTextField.height;
    _cardIdTextField.layer.borderWidth=1;
    _cardIdTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _cardIdTextField.layer.masksToBounds = YES;
    _cardIdTextField.layer.cornerRadius = 5;
    _cardIdTextField.delegate = self;

    // 手机号
    _telePhoneNumberLabel.top = _cardIdLabel.bottom+TRUE_1(20);
    _telePhoneNumberLabel.left = _cardIdLabel.left;
    _telePhoneNumberLabel.width = _cardIdLabel.width;
    _telePhoneNumberLabel.height = _cardIdLabel.height;
    _telePhoneNumberLabel.font = ZJ_TRUE_FONT(15);

    // 输入手机号
    _telePhoneNumberTextField.top = _telePhoneNumberLabel.top;
    _telePhoneNumberTextField.left = _cardIdTextField.left;
    _telePhoneNumberTextField.width = _cardIdTextField.width;
    _telePhoneNumberTextField.height = _cardIdTextField.height;
    _telePhoneNumberTextField.layer.borderWidth=1;
    _telePhoneNumberTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _telePhoneNumberTextField.layer.masksToBounds = YES;
    _telePhoneNumberTextField.layer.cornerRadius = 5;
    _telePhoneNumberTextField.delegate = self;
    _telePhoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;

    //  验证码
    _VerificationCode.top = _telePhoneNumberLabel.bottom+TRUE_1(20);
    _VerificationCode.left = _telePhoneNumberLabel.left;
    _VerificationCode.width = _telePhoneNumberLabel.width;
    _VerificationCode.height = _telePhoneNumberLabel.height;
    _VerificationCode.font = ZJ_TRUE_FONT(15);

    // 输入验证码
    _VerificationTextField.top = _VerificationCode.top;
    _VerificationTextField.left = _telePhoneNumberTextField.left;
    _VerificationTextField.width = _telePhoneNumberTextField.width;
    _VerificationTextField.height = _telePhoneNumberTextField.height;
    _VerificationTextField.layer.borderWidth=1;
    _VerificationTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _VerificationTextField.layer.masksToBounds = YES;
    _VerificationTextField.layer.cornerRadius = 5;
    _VerificationTextField.delegate = self;
    _VerificationTextField.keyboardType = UIKeyboardTypeNumberPad;

//  获取验证码
    _sendVerification.centerY = _VerificationTextField.centerY;
    _sendVerification.width = TRUE_1(100/2);
    _sendVerification.height = TRUE_1(35/2);
    _sendVerification.right =_VerificationTextField.right - _sendVerification.width - TRUE_1(10);
    _sendVerification.layer.masksToBounds = YES;
    _sendVerification.layer.cornerRadius = 3;
    [_sendVerification.titleLabel setFont:ZJ_TRUE_FONT(9)];
    [_sendVerification setBackgroundColor:ZJColor_red];
    [_sendVerification setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendVerification addTarget:self action:@selector(getVerification) forControlEvents:UIControlEventTouchUpInside];
    

    //  密码
    _passWordLabel.top = _VerificationCode.bottom+TRUE_1(20);
    _passWordLabel.left = _VerificationCode.left;
    _passWordLabel.width = _VerificationCode.width;
    _passWordLabel.height = _VerificationCode.height;
    _passWordLabel.font = ZJ_TRUE_FONT(15);
    
    //  输入密码
    _passWordTextField.top = _passWordLabel.top;
    _passWordTextField.left = _VerificationTextField.left;
    _passWordTextField.width = _telePhoneNumberTextField.width;
    _passWordTextField.height = _VerificationTextField.height;
    _passWordTextField.delegate = self;

    _passWordTextField.layer.borderWidth=1;
    _passWordTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _passWordTextField.layer.masksToBounds = YES;
    _passWordTextField.layer.cornerRadius = 5;
    // 密文输入
    _passWordTextField.secureTextEntry = YES;

    // 确认密码
    _confirmPassWordLabel.top = _passWordLabel.bottom+TRUE_1(20);
    _confirmPassWordLabel.left = _passWordLabel.left;
    _confirmPassWordLabel.width = _passWordLabel.width;
    _confirmPassWordLabel.height = _passWordLabel.height;
    _confirmPassWordLabel.font = ZJ_TRUE_FONT(15);
   
    // 确认密码
    _confirmPassWordTextField.top = _confirmPassWordLabel.top;
    _confirmPassWordTextField.left = _passWordTextField.left;
    _confirmPassWordTextField.width = _passWordTextField.width;
    _confirmPassWordTextField.height = _passWordTextField.height;
    _confirmPassWordTextField.delegate = self;
    _confirmPassWordTextField.layer.borderWidth=1;
    _confirmPassWordTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _confirmPassWordTextField.layer.masksToBounds = YES;
    _confirmPassWordTextField.layer.cornerRadius = 5;
    // 密文输入
    _confirmPassWordTextField.secureTextEntry = YES;

    // 推荐码Label
    _commandLabel.top = _confirmPassWordLabel.bottom+TRUE_1(20);
    _commandLabel.left = _confirmPassWordLabel.left;
    _commandLabel.width = _confirmPassWordLabel.width;
    _commandLabel.height = _confirmPassWordLabel.height;
    _commandLabel.font = ZJ_TRUE_FONT(15);

    // 推荐码
    _commandTextLabel.top = _commandLabel.top;
    _commandTextLabel.left = _confirmPassWordTextField.left;
    _commandTextLabel.width = _confirmPassWordTextField.width;
    _commandTextLabel.height = _confirmPassWordTextField.height;
    _commandTextLabel.delegate = self;
    _commandTextLabel.layer.borderWidth=1;
    _commandTextLabel.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _commandTextLabel.layer.masksToBounds = YES;
    _commandTextLabel.layer.cornerRadius = 5;
    
    // 同意协议
    _yesBut.top = _commandTextLabel.bottom+TRUE_1(52/2);
    _yesBut.left = _confirmPassWordLabel.left;
    _yesBut.width = TRUE_1(25/2);
    _yesBut.height = _yesBut.width;
    isAgree=NO;
    _yesBut.layer.borderWidth=1;
    _yesBut.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [_yesBut addTarget:self action:@selector(clickAgree:) forControlEvents:UIControlEventTouchUpInside];
    
    // 阅读协议
    _readAndagreeLabel.top = _yesBut.top;
    _readAndagreeLabel.left = _yesBut.right;
    _readAndagreeLabel.width = TRUE_1(135/2);
    _readAndagreeLabel.height = _yesBut.height;
    [_readAndagreeLabel addTarget:self action:@selector(clickAgree:) forControlEvents:UIControlEventTouchUpInside];
    
    // 弹出协议
    _protorclBut.top = _readAndagreeLabel.top;
    _protorclBut.left = _readAndagreeLabel.right;
    _protorclBut.width = TRUE_1(200);
    _protorclBut.height = _readAndagreeLabel.height;
    [_protorclBut setTitle:@"《债云端（注册）服务协议》" forState:UIControlStateNormal];
    [_protorclBut.titleLabel setFont:ZJ_TRUE_FONT(12)];
    [_protorclBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_protorclBut addTarget:self action:@selector(showProtrocl) forControlEvents:UIControlEventTouchUpInside];
    
    //注册
    _registerBut.top = _readAndagreeLabel.bottom+TRUE_1(20);
    _registerBut.left = TRUE_1(95/2);
    _registerBut.width = ZJAPPWidth - TRUE_1(95);
    _registerBut.height = _confirmPassWordTextField.height;
    _registerBut.layer.masksToBounds = YES;
    _registerBut.layer.cornerRadius = 5;
    [_registerBut.titleLabel setFont:ZJ_TRUE_FONT(15)];
    [_registerBut addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
}


//  注册
-(void)registerAccount
{
        
    for (UITextField* textFieldsubView in self.view.subviews)
    {
        [textFieldsubView resignFirstResponder];
    }
    if ([ZJUtil isEmptyStr:_NameTextField.text]) {
        [ZJUtil showBottomToastWithMsg:@"请输入真实姓名"];
        return;
    }
    if (![ZJUtil isIDCard:_cardIdTextField.text]) {
        [ZJUtil showBottomToastWithMsg:@"请输入身份证号"];
        return;
    }
    if (![ZJUtil isMobileNo:_telePhoneNumberTextField.text]) {
        [ZJUtil showBottomToastWithMsg:@"请输入正确手机号"];
        return;
    }
    if([ZJUtil isEmptyStr:_VerificationTextField.text]){
        [ZJUtil showBottomToastWithMsg:@"请输入验证码"];
        return;
    }
    if([ZJUtil isEmptyStr:_passWordTextField.text]){
        [ZJUtil showBottomToastWithMsg:@"请输入密码"];
        return;
    }
    if(![_passWordTextField.text isEqualToString:_confirmPassWordTextField.text]){
        [ZJUtil showBottomToastWithMsg:@"密码不一致，请确认密码"];
        return;
    }
    if (isAgree == NO) {
        
        [ZJUtil showBottomToastWithMsg:@"请同意协议"];
        return;
    }
    // 注册请求
    [NSThread detachNewThreadSelector:@selector(registRequestData) toTarget:self withObject:nil];

}

//注册请求
-(void)registRequestData{
    
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:_NameTextField.text,@"realname",_cardIdTextField.text,@"idNumber",_telePhoneNumberTextField.text,@"mobile",_VerificationTextField.text,@"validcode",_passWordTextField.text,@"password",_confirmPassWordTextField.text,@"repassword",_commandTextLabel.text,@"recommendCode", nil];
    [self performSelectorOnMainThread:@selector(showProgress) withObject:nil waitUntilDone:YES];
    // 网络请求
    [ZJLoginRegistRequest zjRegistWithParams:dic result:^(BOOL success, id responseData) {
        
    [self performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];

        // 成功
        if (success) {
            // 后台设定成功
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                [self performSelectorOnMainThread:@selector(reloadUI) withObject:nil waitUntilDone:YES];
            // 后台设定失败
            }else  {
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
            
        }else{
            
            [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            
        }
    }];
    
}

//刷新uI
-(void)reloadUI
{
    [ZJUtil showBottomToastWithMsg:@"注册成功"];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ZJProtocolAlterDelegate
- (void)zjProtocolAlertClikButtonIndex:(NSInteger)index alert:(ZJProtocolAlterView *)alert
{
    if (index == 2001) {
        [protoAlterview dismiss];
        
    }else if (index==2002){
        if (alert.isAgree) {
            [protoAlterview dismiss];
            isAgree=YES;
            [_yesBut setImage:[UIImage imageNamed:@"agreeyes"] forState:UIControlStateNormal];

        }else{
            [ANAlert showAlertWithString:@"请阅读并同意用户协议" andTarget:self];
        }
        
    }
    
    
}


//  获取验证码(短信验证倒计时读秒)
-(void)getVerification
{
    // 获取验证码
    [self zjRequestVerifyData];
    
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_sendVerification setBackgroundColor:ZJColor_red];
                [_sendVerification setTitle:@"重新获取" forState:UIControlStateNormal];
                _sendVerification.userInteractionEnabled = YES;
            });
        }else{
            
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.1];
                [_sendVerification setBackgroundColor:ZJColor_999999];
                [_sendVerification setTitle:[NSString stringWithFormat:@"%@s后重送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _sendVerification.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

// 获取验证码请求
-(void)zjRequestVerifyData
{
    NSString * action=[NSString stringWithFormat:@"api/regist/smscode?mobile=%@",_telePhoneNumberTextField.text];
    // 网络请求
    [ZJLoginRegistRequest zjRegistVerifyWithActions:action result:^(BOOL success, id responseData) {
        // 成功
        if (success) {
           //  后台设定成功
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
                
            // 后台设定失败
            }else {
                
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
            
        }else{
            
        }
    }];

    


}

//  同意协议
-(void)clickAgree:(UIButton *)sender
{
    isAgree=!isAgree;
    if (isAgree) {
        [_yesBut setImage:[UIImage imageNamed:@"agreeyes"] forState:UIControlStateNormal];
    }else{
        [_yesBut setImage:[UIImage imageNamed:@"agreeno"] forState:UIControlStateNormal];
    }
    
}

#pragma mark 键盘

//  防止再次编辑被清空
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //得到输入框的内容
    NSString * textfieldContent = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == _passWordTextField && textField.isSecureTextEntry ) {
        textField.text = textfieldContent;
        return NO;
    }else if (textField == _confirmPassWordTextField &&textField.isSecureTextEntry ) {
        textField.text = textfieldContent;
        return NO;
    }
    return YES;
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

//  展示协议
-(void)showProtrocl
{
    protoAlterview =[[ZJProtocolAlterView alloc]initWithProtocoltype:@"债云端（注册）服务协议" withTitle:@"债云端服务协议（以下简称本协议）由中金债事（北京）网络科技有限公司（以下简称本公司）和您签订。\n\n一、声明与承诺\n（一）在接受本协议或您以本公司允许的其他方式实际使用债云端服务之前，请您仔细阅读本协议的全部内容。如果您不同意本协议的任意内容，或者无法准确理解本公司对条款的解释，请不要进行后续操作，包括但不限于不要接受本协议，不使用本服务。如果您对本协议的条款有疑问，请通过本公司客服渠道（客服电话：4000689588）进行询问，本公司将向您解释条款内容。\n（二）您同意，如本公司需要对本协议进行变更或修改的，须通过www.zhongjinzhaishi.com网站公告的方式提前予以公布，公告期限届满后即时生效；若您在本协议内容公告变更生效后继续使用债云端服务的，表示您已充分阅读、理解并接受变更后的协议内容，也将遵循变更后的协议内容使用债云端服务；若您不同意变更后的协议内容，您应在变更生效前停止使用债云端服务。\n（三）如您为无民事行为能力人或为限制民事行为能力人，例如您未满18周岁，则您应在监护人监护、指导下阅读本协议和使用本服务。若您非自然人，则您确认，在您取得债云端账户时，或您以其他本公司允许的方式实际使用债云端服务时，您为在中国大陆地区合法设立并开展经营活动或其他业务的法人或其他组织，且您订立并履行本协议不受您所属、所居住或开展经营活动或其他业务的国家或地区法律法规的排斥。不具备前述条件的，您应立即终止注册或停止使用债云端服务。\n（四）您在使用债云端服务时，应自行判断交易对方是否具有完全民事行为能力并自行决定是否使用债云端服务与对方进行交易，且您应自行承担与此相关的所有风险。\n (五)您确认，您在债云端上发生的所有交易，您已经不可撤销地授权债云端按照其制定的《云债行服务协议》等规则进行处理；同时， 您不可撤销地授权本公司按照云债行的指令将争议款项的全部或部分支付给交易一方或双方，同时本公司有权从债云端获取您的相关信息（包括但不限于交易商品描述、物流信息、行为信息、账户相关信息等）。本公司按照债云端的指令进行资金的止付、扣划完全来自于您的授权，本公司对因此给您造成的任何损失均不承担责任。但您确认，您使用债云端服务时，您仍应完全遵守本协议及本公司制定的各项规则及页面提示等。\n（六）您同意，您在中金债事智慧云官网发生的所有交易，您已经不可撤销地授权中金债事智慧云按照其与您之间的协议及其制定并发布的《云债行协议》等规则进行处理；同时，您不可撤销地授权本公司按照中金债事智慧云官网的指令将争议款项的全部或部分支付给交易一方或双方，同时本公司有权从中金债事智慧云官网获取您的相关信息（包括但不限于交易商品描述、物流信息、行为信息、账户相关信息等）。本公司按照债云端的指令进行资金的止付、扣划完全来自于您的授权，本公司对因此给您造成的任何损失均不承担责任。但您确认，您使用支付宝服务时，您仍应完全遵守本本协议及本公司制定的各项规则及页面提示等。\n\n二、定义及解释\n（一）债云端账户（或“该账户”）：指您按照本公司允许的方式取得的供您使用债云端服务的账户。\n（二）本网站：除本协议另有规定外，指www.zhongjinzhaishi.com及/或客户端。\n（三）止付：指债云端账户余额为不可用状态，例如被止付的债云端账户余额不能用于充值、支付、提现或转账等服务。\n（七）冻结：指有权机关要求的冻结或依据其他协议进行的保证金冻结等。被冻结余额为不可用状态，被冻结账户不可登录、使用。\n（八）债云端服务（或“本服务”）：指本协议第三条所描述的服务。\n（九）支付宝账户：                        。\n\n三.债云端服务\n债云端服务（或称“本服务”）是本公司向您提供的非金融机构支付服务，是受您委托代您收款和付款的资金转移服务，具体服务项目及内容请见本网站网页，包括（但不限于）以下服务：\n1、代收代付款项服务:代收代付款项服务是指本公司为您提供的代为收取或支付相关款项的服务， 其中：\nA.代收，即本公司代为收取任何人向您支付的各类款项。为免疑义，代收具体是指在符合本公司规定或产品规则的情况下，自您委托本公司将您银行卡内的资金充值到您的支付宝账户或委托本公司代为收取第三方向您支付的款项之时起至根据您的指令将该等款项的全部或部分实际入账到您的银行账户或支付宝账户之时止（含本条之1项3）规定的提现）的整个过程（但不包括本条之1项B（a）所述情形）。\nB.代付, 即本公司将您的款项代为支付给您指定的第三方。为免疑义, 代付具体是指在符合本公司规定或产品规则的情况下: (a)自款项从您的账户(包括但不限于银行账户或其他账户, 但不 包括支付宝账户)转出之时起至委托本公司根据您或有权方给出的指令将上述款项的全部或部分支付给第三方且第三方收到该款项(无论是否要求立即支付或根据届时情况不时支付)之时止的整个过程; 或 (b) 自您根据本协议委托本公司将您银行卡的资金充值到您的支付宝账户或自您因委托本公司代收相关款项到您的支付宝账户之时起至委托本公司根据您或有权方给出的指令将上述款项的全部或部分支付给第三方(无论是否要求立即支付或根据届时情况不时支付)之时止的整个过程。并且您同意, 本公司代付后, 非经法律程序或者非依本协议之约定, 该支付是不可撤销的。\n本公司提供的上述的代收代付款项服务可以分为以下各类具体服务:\n1)充值: 作为代收款项服务的一部分， 在符合本公司规定或产品规则的情况下，您委托本公司将您银行卡内的资金充值到您的支付宝账户。\n2)提现: 作为代收款项服务的一部分, 在符合本公司规定或产品规则的情况下， 您可以请求本公司将您支付宝账户中的资金提取到您名下的有效中国大陆银行账户内, 该银行账户开户名需与您的姓名或名称一致。除被止付或限制款项外, 本公司将于收到提现指令后的一至五个工作日内, 将相应款项汇入该银行账户。您理解, 根据您提供的账户所属银行不同, 会有到账时间差异。此外, 我们可能会对提现进行风险审查, 因此可能导致提现延迟。您理解并同意您最终收到款项的服务是由您提供的银行账户对应的银行提供的, 您需向该银行请求查证。\n3)债云端中介服务, 亦称“债云端担保交易”, 即本公司接受您的委托向您提供的有关买卖交易的代收或代付款项的中介服务。\n除本协议另有规定外, 交易双方使用债云端中介服务, 即认可：买方点击确认收货后, 本公司即有权将买家已支付的款项代为支付给卖家。除本协议另有规定外, 您与交易对方发生交易纠纷时, 您不可撤销地授权本公司自行判断并决定将争议款项的全部或部分支付给交易一方或双方。4)货到付款服务, 又称COD服务, 是指买卖双方约定买卖合同项下的交易货款, 由卖家委托的物流公司在向买方运送交易货物时以现金、POS刷卡、快捷支付等方式直接或间接地代收, 再由本公司代付至卖方支付宝账户的一种支付方式。在您使用本项服务时, 除适用支付宝中介服务的相关约定外, 还将优先适用以下条款:\na) 作为买方, 本公司为您代付的交易货款系由您收到交易货物时以现金、POS刷卡、快捷支付等方式通过物流公司直接或间接代付至卖方支付宝账户内。您向卖方支付的交易货款将直接或者 间接通过物流公司, 物流公司为此可能向您单独收取费用。您理解并同意, 该费用是物流公司基于其向您提供的服务所收取的, 与本公司向您提供的COD服务无关。\n您确认, 本服务能否完成取决于您提供的收货地址是卖方所选用的物流公司可以送达的地址。在物流公司确认不可送达时, 本公司有权要求您重新选择本公司提供的其他支付方式。\nb) 作为卖方, 本公司为您代收的交易货款系由买方直接或间接地通过您委托的物流公司并最终由本公司代收到您的支付宝账户内。您理解并同意, 完成上述流程是需要一定时间的, 而本公司承诺在与物流公司将交易货款全部清算给本公司的次日将上述交易货款代收至您的支付宝账户内。因此产生的交易款项流转时间是您明知且认可的。 您确认, 该服务能否完成, 取决于您选用的物流公司是否可将交易货物送达买方提供的收货地址, 或买方提供的收货地址准确无误, 或货物完全符合您与买方的约定, 及物流公司是否将相应交易货款清算至本公司等。您理解并接受, 您选用的物流公司不揽货、不清算、错误送达、货物被买方拒收等情形与本公司无关, 且为本公司不可预见、不可预防和不可控制的, 因此产生的损失需全部由您自行承担。\n5)即时到账服务: 是指买卖双方约定买卖合同项下的货款通过买方支付宝账户即时向卖方支付宝账户支付的一种支付方式。本公司提示您注意: 该项服务一般适用于您与交易对方彼此都有充分信任的小额交易。 在您与交易对方使用即时到账服务支付款项时, 该款项无需等您确认收货即立刻进入交易对方的支付宝账户。在使用即时到账服务时, 您理解并接受:\na) 为控制可能存在的风险, 本公司对所有用户使用即时到账服务支付交易货款时的单日交易总额以及单笔交易最高额进行了限制, 并保留对限制种类和限制限额进行无需预告地调整的权利。\nb) 使用即时到账服务支付货款是基于您对交易对方的充分信任, 一旦您选用该方式, 您应自行承担所有交易风险并自行处理所有相关的交易及货款纠纷, 本公司不负责处理相关纠纷。\n6)后付服务: 指买卖双方在交易时通过本服务支付，选择特定服务（以下简称“特定服务”）作为资金渠道的，本公司将根据特定服务的约定提供款项的代收代付服务；该特定服务包括但不限于花呗（或不时调整的其他名称）、余额宝冻结转支付（或不时调整的其他名称或实质上提供了余额宝冻结转支付功能的产品）服务。在使用后付服务时，您理解并接受：\na) 该笔交易项下的款项将由买家在确认收货后由本公司代收代付至卖家的支付宝账户。若买家采用特定服务中约定其他款项支付方式的，本公司将依照该等约定提供款项代收代付服务。\nb) 如该笔交易发生在淘宝或阿里巴巴中国站，为保证交易的正常进行，就该笔交易产生的纠纷将按照本协议第一条第（五）、（六）款的约定处理。非因该笔交易产生的纠纷或非因淘宝、阿里巴巴中国站上发生的交易产生的纠纷，您需要联系特定服务的提供方或自行处理。\n7)转账服务: 是指收付款双方使用本服务, 在付款方向本公司指示收款方支付宝账户或银行账户和转账金额后, 将付款方支付宝账户内指定金额的款项划转至收款方支付宝账户或银行账户的一种资金转移服务。本公司提示您注意: 该项服务适用于您与收(付)款方彼此都有充分了解的转账行为。 在您使用转账服务指示转出资金时, 您所转出的款项将进入您向本公司指示的收款方的支付宝账户或银行账户。在您获得支付宝账户后, 您的支付宝账户即具备接受(收)来自转账服务的转账款项的功能, 但未经实名的支付宝账户可能会受到收款和(或)提现的限制。基于此项服务可能存在的风险, 在使用转账服务时, 您理解并接受:\na)为控制可能存在的风险, 本公司对所有用户使用转账服务时的转账款项的单日转账总额以及单笔转账最高额进行了限制, 并保留对限制种类和限制限额进行无需预告进行调整的权利。\nb)您可能收到由于使用转账服务的付款方指示错误(失误)而转账到您支付宝账户或银行账户的款项, 在此情况下您应该根据国家的相关法律的规定和实际情况处理收到的该笔款项。\nc)使用转账服务是基于您对转账对方的充分了解(包括但不限于对方的真实身份及确切的支付宝账户名等), 一旦您选用转账服务进行转账, 您应当自行承担因您指示错误(失误)而导致的风险。本公司依照您指示的收款方并根据本协议的约定完成转账后, 即完成了当次服务的所有义务, 对于收付款双方之间产生的关于当次转账的任何纠纷不承担任何责任, 也不提供任何形式的纠纷解决途径, 您应当自行处理相关的纠纷。\n2、查询: 本公司将对您使用本公司服务的操作的全部或部分进行记录, 不论该操作之目的最终是否实现。您可以登录支付宝账户查询您支付宝账户内的交易记录。\n3、购结汇服务: 本公司根据适用的相关法律法规向您提供的人民币和外币的购结汇服务。\n4、其他: 您实际使用的本公司接受您的委托为您不时提供的其他服务及本公司提供的其他产品或服务。\n\n四、支付宝账户\n（一） 注册相关\n除本协议另有规定或相关产品另有规则外，您须在本网站注册并取得本公司提供给您的支付宝账户，或在您于其他阿里网站完成支付宝登录名注册，取得支付宝账户，并且按照本公司要求提供相关信息完成激活后方可使用本服务。您需使用作为支付宝登录名的本人电子邮箱或手机号码，或者本公司允许的其它方式（例如通过扫描二维码、识别生物特征的方式）登录支付宝账户，并且您应当自行为支付宝账户设置密码。您同意：\n1、按照支付宝要求准确提供并在取得该账户后及时更新您正确、最新及完整的身份信息及相关资料。若本公司有合理理由怀疑您提供的身份信息及相关资料错误、不实、过时或不完整的，本公司有权暂停或终止向您提供部分或全部支付宝服务。本公司对此不承担任何责任，您将承担因此产生的任何直接或间接支出。若因国家法律法规、部门规章或监管机构的要求，本公司需要您补充提供任何相关资料时，如您不能及时配合提供，本公司有权暂停或终止向您提供部分或全部支付宝服务。\n2、您应当准确提供并及时更新您提供的电子邮件地址、联系电话、联系地址、邮政编码等联系方式，以便本公司与您进行及时、有效联系。您应完全独自承担因通过这些联系方式无法与您取得联系而导致的您在使用本服务过程中遭受的任何损失或增加任何费用等不利后果。您理解并同意，您有义务保持您提供的联系方式的有效性，如有变更需要更新的，您应按本公司 的要求进行操作。\n3、您应及时更新资料（包括但不限于身份证、户口本、护照等证件或其他身份证明文件、联系方式、作为支付宝账户登录名的邮箱或手机号码、与支付宝账户绑定的邮箱、手机号码等），否则支付宝有权将支付宝登录名、支付宝账户绑定的邮箱、手机号码开放给其他用户注册或使用。因您未及时更新资料导致的一切后果，均应由您自行承担，该后果包括但不限于导致 本服务无法提供或提供时发生任何错误、账户及账户内资金被别人盗用，您不得将此作为取消交易、拒绝付款的理由。\n4、若您为个人用户, 您确认, 本公司有权在出现下列情形时要求核对您的有效身份证件或其他必要文件, 并留存有效身份证件的彩色扫描件, 您应积极配合, 否则本公司有权限制或停止向您提供部分或全部支付宝服务:\nA. 您办理单笔收付金额人民币1万元以上或者外币等值1000美元以上支付业务的;\nB. 您全部账户30天内资金双边收付金额累计人民币5 万元以上或外币等值1万美元以上的;\nC. 您全部账户资金余额连续10天超过人民币5000元或外币等值1000美元的;\nD. 您使用支付宝服务买卖金融产品或服务的；\nE.您购买我公司记名预付卡或办理记名预付卡充值的;\nF.您购买不记名预付卡或通过不记名预付卡充值超过人民币1万元的;\nG.您要求变更身份信息或您身份信息已过有效期的;\nH.本公司认为您的交易行为或交易情况出现异常的;\nI.本公司认为您的身份资料存在疑点或本公司在向您提供服务的过程中认为您已经提供的身份资料存在疑点的;\nJ.本公司认为应核对或留存您身份证件或其他必要文件的其他情形的。\n本条款所称“以上”,包括本数。\n5、您在债云端账户中设置的昵称、头像等必须遵守法律法规、公序良俗、社会公德，且不会侵害其他第三方的合法权益，否则债云端有权对您的债云端账户采取限制措施，包括但不限于屏蔽、撤销您支付宝账户的昵称、头像，停止提供部分或全部债云端服务。\n（二）中金债事智慧云官网相关\n您理解并同意，您在本网站完成债云端账户注册程序后，您即取得以您手机号或电子邮箱为内容的债云端登录名。您可以通过您的债云端登录名直接登录中金债事智慧云官网，无需重新注册。但如您此次注册使用的手机号或电子邮箱于2017年6月30日前已在中金债事智慧云官网完成过注册的，则您此次注册的债云端登录名在官网登录的功能不会自动开通。为了使您更便捷地使用官网的服务，您在此明确且不可撤销地授权，您的账户信息在您注册成功时，已授权本公司披露给中金债事智慧云官网并授权官网使用。\n（三） 账户安全\n您将对使用该账户及密码、校验码进行的一切操作及言论负完全的责任，您同意：\n1、本公司通过您的债云端登录名和密码识别您的指示，您应当妥善保管您的债云端登录名和密码及身份信息，对于因密码泄露、身份信息泄露所致的损失，由您自行承担。您保证不向其他任 何人泄露您的债云端登录名及密码以及身份信息，亦不使用其他任何人的债云端登录名及密码。本公司亦可能通过本服务应用您使用的其他产品或设备识别您的指示，您应当妥善保 管处于您或应当处于您掌控下的这些产品或设备，对于这些产品或设备遗失所致的任何损失，由您自行承担。\n2、基于计算机端、手机端以及使用其他电子设备的用户使用习惯，我们可能在您使用具体产品时设置不同的账户登录模式及采取不同的措施识别您的身份。\n3、您同意，（a）如您发现有他人冒用或盗用您的债云端登录名及密码或任何其他未经合法授权之情形，或发生与债云端账户关联的手机或其他设备遗失或其他可能危及到债云端账户资金安全情形时，应立即以有效方式通知本公司，向本公司申请暂停相关服务。您不可撤销地授权本公司将前述情况同步给中金债事智慧云官网，以保障您的合法权益；及（b）确保您在持续登录官网时段结束时，以正确步骤离开网站。本公司不能也不会对因您未能遵守本款约定而发生的任何损失、损毁及其他不利后果负责。您理解本公司对您的请求采取行动需要合理期限，在此之前，本公司对已执行的指令及(或)所导致的您的损失不承担任何责任。\n4、您确认，您应自行对您的债云端账户负责，只有您本人方可使用该账户。该账户不可转让、不可赠与、不可继承，但账户内的相关财产权益可被依法继承。\n5、您同意，基于运行和交易安全的需要，本公司可以暂时停止提供或者限制本服务部分功能，或提供新的功能，在任何功能减少、增加或者变化时，只要您仍然使用本服务，表示您仍然同意本协议或者变更后的协议。\n6、本公司有权了解您使用本公司产品或服务的真实交易背景及目的，您应如实提供本公司所需的真实、全面、准确的信息；如果本公司有合理理由怀疑您提供虚假交易信息的，本公司有权暂时或永久限制您所使用的产品或服务的部分或全部功能。\n7、您同意，本公司有权国家法律或和行政法规所赋予权力的有权机关的要求对您的个人信息以及在扎运动的资金、交易及账户等进行查询、冻结或扣划。\n (四) 注销相关\n在需要终止使用本服务时,您可以申请注销您的债云端账户,您同意:\n1、您所申请注销的债云端账户应当是您依照本协议的约定注册并由本公司提供给您本人的账户。您应当依照本公司规定的程序进行债云端账户注销。\n2、债云端账户注销将导致本公司终止为您提供本服务，本协议约定的双方的权利义务终止（依本协议其他条款另行约定不得终止的或依其性质不能终止的除外），同时还可能对于该账户产生如下结果：\nA、任何兑换代码（购物券、礼品券、债币券等）都将作废；如您不愿将该部分兑换代码或卡券消耗掉或将其作废，则您不能申请注销债云端账户。\nB、任何银行卡将不能适用该账户内的支付或提现服务。\n3、您可以通过自助或者人工的方式申请注销债云端账户，但如果您使用了本公司提供的安全产品，应当在该安全产品环境下申请注销。\n4、您申请注销的债云端账户应当处于正常状态，即您的债云端账户的账户信息和用户信息是最新、完整、正确的，且该账户可以使用所有债云端服务功能的状态。账户信息或用户信息过时、 缺失、不正确的账户或被暂停或终止提供服务的账户不能被申请注销。如您申请注销的账户有关联账户或子账户的，在该关联账户或子账户被注销前，该账户不得被注销。\n5、您申请注销的债云端账户应当不存在任何由于该账户被注销而导致的未了结的合同关系与其他基于该账户的存在而产生或维持的权利义务，及本公司认为注销该账户会由此产生未了结的权利义务而产生纠纷的情况。您申请注销的债云端账户应当没有任何关联的理财产品，不存在任何待处理交易，没有任何余额、红包等资产，且符合债云端页面或网站提示的其他条件和流程。如不符合前述任何情况的，您不能申请注销该账户。\n6、如果您申请注销的债云端账户一旦注销成功，将不再予以恢复。\n\n五、债云端服务使用规则\n为有效保障您使用本服务时的合法权益，您理解并同意接受以下规则：\n（一）一旦您使用本服务，您即授权本公司代理您在您及（或）您指定人符合指定条件或状态时，支付款项给您指定人，或收取您指定人支付给您的款项。\n（二）本公司通过以下三种方式接受来自您的指令：其一，您在本网站或其他可使用本服务的网站或软件上通过以您的债云端账户名及密码或数字证书等安全产品登录债云端账户并依照本服务预设流程所修改或确认的交易状态或指令；其二，您通过您注册时作为该账户名称或者与该账户绑定的手机或其他专属于您的通讯工具（以下合称该手机）号码向本系统发送的信息（短信 或电话等）回复；其三，您通过您注册时作为该账户名称或者与该账户名称绑定的其他硬件、终端、软件、代号、编码、代码、其他账户名等有形体或无形体向本系统发送的信息（如本方式所指有形体或无形体具备与该手机接受信息相同或类似的功能，以下第五条第（三）、（四）、（五）项和第六条第（三）项涉及该手机的条款同样适用于本方式）。无论您通过以上三种方式中的任一种向本公司发出指令，都不可撤回或撤销，且成为本公司代理您支付或收取款项或进行其他账户操作的唯一指令，视为您本人的指令，您应当自己对本公司忠实执行上述指令产生的任何结果承担责任。本协议所称绑定，指您的支付宝账户与本条上述所称有形体或无形体存在对应的关联关系，这种关联关系使得支付宝服务的某些服务功能得以实现，且这种关联关系有时使得这些有形体或无形体能够作为本系统对您的支付宝账户的识别和认定依据。除本协议另有规定外，您与第三方发生交易纠纷时，您授权本公司自行判断并决定将争议款项的全部或部分支付给交易一方或双方。\n（三）您确认，您使用拍码方式向商家付款或通过“当面付”功能进行支付时，在一定额度内（该额度可能因您使用该支付服务时所处的国家/地区、支付场景、风险控制需要及其他本公司认为适宜的事由而有不同，具体额度请见相关提示或公告）或根据您与本公司的另行约定，您无需输入密码即可完成支付，您授权本公司按照商家确定的金额从您的资产里扣款给商家。\n（四）您在使用本服务过程中，本协议内容、网页上出现的关于操作的提示或本公司发送到该手机的信息（短信或电话等）内容是您使用本服务的相关规则，您使用本服务即表示您同意接受本服务的相关规则。您了解并同意本公司有权单方修改本服务的相关规则，而无须征得您的同意，本服务的相关规则应以您使用服务时的页面提示（或发送到该手机的短信或电话或客户端通知等）为准，您同意并遵照本服务的相关规则是您使用本服务的前提。\n（五）本公司会以网站公告、电子邮件、发送到该手机的短信、电话、站内信或客户端通知等方式向您发送通知，例如通知您交易进展情况，或者提示您进行相关操作，您应及时予以关注。但本公司不保证您能够收到或者及时收到该等通知，且对此不承担任何后果。因您没有及时对交易状态进行修改或确认或未能提交相关申请而导致的任何纠纷或损失，本公司不负任何责任。\n（六）您如果需要向交易对方交付货物，应根据交易状态页面（或您手机接收到的信息）显示的买方地址，委托有合法经营资格的承运人将货物直接运送至对方或其指定收货人，并要求对方或其委托的第三方（该第三方应当提供对方的授权文件并出示相应的身份证件）在收货凭证上签字确认，因货物延迟送达或在送达过程中的丢失、损坏，本公司不承担任何责任，应由您与交易对方自行处理。\n（七） 本公司对您所交易的标的物不提供任何形式的鉴定、证明的服务。除本协议另有规定外，如您与交易对方发生交易纠纷，您授权由本公司根据本协议及本网站上载说明的各项规则进行处理。您为解决纠纷而支出的通讯费、文件复印费、鉴定费等均由您自行承担。因市场因素致使商品涨价跌价而使任何一方得益或者受到损失而产生的纠纷（《争议处理规 则》另有约定的除外），本公司不予处理。\n（八）您应按照支付宝的要求完善您的身份信息以最终达到实名，否则您可能会受到收款、提现和（或）支付（包括但不限于余额、余额宝）的限制，且本公司有权对您的资金进行 止付，直至您达到实名。\n（九） 本公司会将您委托本公司代收或代付的款项，严格按照法律法规或有权机关的监管要求进行管理；除本协议另有规定外，不作任何其他非您指示的用途。\n（十） 本公司并非银行或其它金融机构，本服务也非金融业务，本协议项下的资金移转均通过银行来实现，你理解并同意您的资金于流转途中的合理时间。\n（十一） 您理解，基于相关法律法规，对本协议项下的任何服务，本公司均不提供任何担保、垫资。\n（十二）您确认并同意，您应自行承担您使用本服务期间由本公司代收或代付的款项在代收代付服务过程中的任何货币贬值、汇率波动及收益损失等风险，您仅在该代收代付款项（不含被冻结、止付或受限制的款项）的金额范围内享有对该等代收代付款项指令支付、提现的权利，您对所有代收代付款项（含被冻结、止付或受限制的款项）产生的任何收益（包括但不限于利息和其他孳息）不享有任何权利。本公司就所有该代收代付款项产生的任何收益（包括但不限利息和其他于孳息）享有所有权。\n（十三）您不得将本服务用于非本公司许可的其他用途。\n（十四）交易风险\n1、在使用本服务时，若您或您的交易对方未遵从本协议或网站说明、交易、支付页面中之操作提示、规则），则本公司有权拒绝为您与交易对方提供相关服务，且本公司不承担损害赔偿责任。 若发生上述状况，而款项已先行划付至您或他人的支付宝账户名下，您同意本公司有权直接自相关账户中扣回相应款项及（或）禁止您要求支付此笔款项之权利。此款项若已汇入您 的银行账户，您同意本公司有向您事后索回之权利，因您的原因导致本公司事后追索的，您应当承担本公司合理的追索费用。\n2、因您的过错导致的任何损失由您自行承担，该过错包括但不限于：不按照交易、支付提示操作，未及时进行交易操作，遗忘或泄漏密码，密码被他人破解，您使用的计算机被他人侵入。\n（十五）服务费用\n1、在您使用本服务时，本公司有权依照《债云端服务收费规则》向您收取服务费用。本公司拥有制订及调整服务费之权利，具体服务费用以您使用本服务时本网站产品页面上所列之收费方式公告或您与本公司达成的其他书面协议为准。\n2、除非另有说明或约定，您同意本公司有权自您委托本公司代管、代收或代付的款项或您任一支付宝账户余额或者其他资产中直接扣除上述服务费用。\n（十六）积分\n1、就您使用本服务，本公司将通过多种方式向您授予积分。无论您通过何种方式获得积分，您都不得使用积分换取任何现金或金钱。\n2、积分并非您拥有所有权的财产，本公司有权单方面调整积分数值或调整本公司的积分规则，而无须征得您的同意。\n3、您仅有权按本公司的积分规则，将所获积分交换本公司提供的指定的服务或产品。\n4、如本公司怀疑您的积分的获得及(或)使用存有欺诈、滥用或其它本公司认为不当的行为，本公司可随时取消、限制或终止您的积分或积分使用。\n（十七）您认可债云端账户的使用记录、交易金额数据等均以债云端系统记录的数据为准。如您对该等数据存有异议的，应自您账户数据发生变动之日起三日内向本公司提出异议，并提供相关证据供本公司核实，否则视为您认可该数据。\n（十八）如您使用债云端代扣服务的，下面任一情况下均会导致扣款不成功，您需要自行承担该风险：\n1、 您的指定账户余额不足；\n2、 您的指定账户被有权机关采取强制措施，或者已依据其他协议被冻结、止付。\n\n六、债云端服务使用限制\n（一） 您在使用本服务时应遵守中华人民共和国相关法律法规、您所在国家或地区之法令及相关国际惯例，不将本服务用于任何非法目的（包括用于禁止或限制交易物品的交易），也不以任 何非法方式使用本服务。\n（二） 您不得利用本服务从事侵害他人合法权益之行为，否则本公司有权拒绝提供本服务，且您应承担所有相关法律责任，因此导致本公司或本公司雇员受损的，您应承担赔偿责任。上述行 为包括但不限于：\n 1、侵害他人名誉权、隐私权、商业秘密、商标权、著作权、专利权等合法权益。\n2、违反依法定或约定之保密义务。\n3、冒用他人名义使用本服务。\n4、从事不法交易行为，如洗钱、恐怖融资、贩卖枪支、毒品、禁药、盗版软件、黄色淫秽物品、其他本公司认为不得使用本服务进行交易的物品等。\n5、提供赌博资讯或以任何方式引诱他人参与赌博。\n6、非法使用他人银行账户（包括信用卡账户）或无效银行账号（包括信用卡账户）交易。\n7、违反《银行卡业务管理办法》使用银行卡，或利用信用卡套取现金（以下简称套现）。\n8、进行与您或交易对方宣称的交易内容不符的交易，或不真实的交易。\n9、从事任何可能含有电脑病毒或是可能侵害本服务系统、资料之行为。\n10、其他本公司有正当理由认为不适当之行为。\n（三） 您理解并同意，本公司不对因下述任一情况导致的任何损害赔偿承担责任，包括但不限于利润、商誉、使用、数据等方面的损失或其他无形损失的损害赔偿 (无论本公司是否已被告知该等损害赔偿的可能性)：\n1、本公司有权基于单方判断，包含但不限于本公司认为您已经违反本协议的明文规定及精神，对您的名下的全部或部分支付宝账户暂停、中断或终止向您提供本服务或其任何部分， 并移除您的资料。\n2、在发现异常交易或合理怀疑交易有疑义或有违反法律规定或本协议约定之时，为维护用户资金安全和合法权益，本公司有权不经通知先行暂停或终止您名下全部或部分债云端账户的使用（包括但不限于对这些账户名下的款项和在途交易采取取消交易、调账等措施），同时可能需要您配合提供包括但不限于物流凭证、身份证、银行卡，交易过程中交易双方的聊天记录截图等资料。如您未及时、完整、准确提供上述资料，本公司有权采取包括但不限于如下限制措施：关闭余额支付功能、限制收款功能、止付账户内余额或停止提供全部或部分债云端服务。如涉嫌犯罪，本公司有权移交公安机关处理。\n3、您理解并同意， 存在如下情形时，本公司有权对您名下债云端账户暂停或终止提供全部或部分债云端服务，或对资金的全部或部分进行止付，且有权限制您所使用的产品或服务的部分或全部功能（包括但不限于对这些账户名下的款项和在途交易采取取消交易、调账等限制措施），并通过邮件或站内信或者客户端通知等方式通知您， 您应及时予以关注：\n1）根据本协议的约定；\n2）根据法律法规及法律文书的规定；\n3）根据有权机关的要求；\n4）您使用债云端服务的行为涉嫌违反国家法律法规及行政规定的；\n5）本公司基于单方面合理判断认为账户操作、资金进出等存在异常时；\n6）本公司依据自行合理判断认为可能产生风险的；\n7）您在参加市场活动时有批量注册账户、刷信用及其他舞弊等违反活动规则、违反诚实信用原则的；\n8）他人向您账户错误汇入资金等导致您可能存在不当得利的；\n9）您遭到他人投诉，且对方已经提供了一定证据的；\n10）您可能错误地将他人账户进行了实名制或实名认证的。\n如您申请恢复服务、解除上述止付或限制，您应按本公司要求如实提供相关资料及您的身份证明以及本公司要求的其他信息或文件，以便本公司进行核实，且本公司有权依照自行判 断来决定是否同意您的申请。您应充分理解您的申请并不必然被允许。您拒绝如实提供相关资料及身份证明的，或未通过本公司审核的，则您确认本公司有权长期对该等账户停止提供服务且长期限制该等产品或者服务的部分或全部功能。\n在本公司认为该等异常已经得到合理解释或有效证据支持或未违反国家相关法律法规及部门规章的情况下，最晚将于止付款项或暂停执行指令之日起的30个日历天内解除止付或限制。但本公司有进一步理由相信该等异常仍可能对您或其他用户或本公司造成损失的情形除外，包括但不限于：\n1）收到针对该等异常的投诉；\n2）您已经实质性违反了本协议或另行签署的协议，且我们基于保护各方利益的需要必须继续止付款项或暂停执行指令；\n3）您虽未违反国家相关法律法规及部门规章规定，但该等使用涉及支付宝限制合作的行业类目或商品，包括但不限于通过本公司的产品或服务从事类似金字塔或矩阵型的高额返利业务模式。\n4、在本公司合理认为有必要时，本公司无需事先通知即可终止提供本服务，并暂停、关闭或删除您名下全部或部分支付宝账户及这些账户中所有相关资料及档案，并将您滞留在这些账户的全部合法资金退回到您的银行账户。\n（四）您理解并同意，如因您进行与您宣称的交易内容不符的交易，或违反您所在平台对商品类目管理的规定，导致本公司、您所在平台或用户遭受损失的，本公司有权向您追偿并有权随时从您名下的支付宝账户扣除相应资金以弥补该等损失。且本公司有权对您名下支付宝账户暂停或终止向您提供部分或全部支付宝服务，或对您名下资产的部分或全部进行止付。\n\n七、隐私权保护\n本公司重视对用户隐私的保护。关于您的身份资料和其他特定资料依本协议第十条所载明的《隐私权规则》受到保护与规范，详情请参阅《隐私权规则》。\n\n八、系统中断或故障\n本公司系统因下列状况无法正常运作，使您无法使用各项服务时，本公司不承担损害赔偿责任，该状况包括但不限于：\n（一）本公司在本网站公告之系统停机维护期间。\n（二）电信设备出现故障不能进行数据传输的。\n（三）因台风、地震、海啸、洪水、停电、战争、恐怖袭击等不可抗力之因素，造成本公司系统障碍不能执行业务的。\n（四）由于黑客攻击、电信部门技术调整或故障、网站升级、银行方面的问题等原因而造成的服务中断或者延迟。\n\n九、责任范围及责任限制\n（一）本公司仅对本协议中列明的责任承担范围负责。\n（二）您明确因交易所产生的任何风险应由您与交易对方承担。\n（三）债云端用户信息是由用户本人自行提供的，本公司无法保证该信息之准确、及时和完整，您应对您的判断承担全部责任。\n（四）本公司不对交易标的及本服务提供任何形式的保证，包括但不限于以下事项：\n1、本服务符合您的需求。\n2、本服务不受干扰、及时提供或免于出错。\n3、您经由本服务购买或取得之任何产品、服务、资讯或其他资料符合您的期望。\n（五）本服务之合作单位，所提供之服务品质及内容由该合作单位自行负责。\n（六）您经由本服务之使用下载或取得任何资料，应由您自行考量且自负风险，因资料之下载而导致您电脑系统之任何损坏或资料流失，您应负完全责任。\n（七）您自本公司及本公司工作人员或经由本服务取得之建议和资讯，无论其为书面或口头形式，均不构成本公司对本服务之保证。\n（八）在法律允许的情况下，本公司对于与本协议有关或由本协议引起的任何间接的、惩罚性的、特殊的、派生的损失（包括业务损失、收益损失、利润损失、商誉损失、使用数据 其他经济利益的损失），不论是如何产生的，也不论是由对本协议的违约（包括违反保证）还是由侵权造成的，均不负有任何责任，即使事先已被告知此等损失的可能性。另外即使本协议规定的排他性救济没有达到其基本目的，也应排除本公司对上述损失的责任。\n（九）除本协议另有规定外，在任何情况下，本公司对本协议所承担的违约赔偿责任总额不超过向您收取的当次服务费用总额。\n十）您充分知晓并同意本公司可能同时为您及您的（交易）对手方提供本服务，您同意对本公司可能存在的该等行为予以明确豁免，并不得以此来主张本公司在提供本服务时存在法律上的瑕疵。\n（十一）除本协议另有规定或本公司另行同意外，您对本公司的委托及向本公司发出的指令均不可撤销。\n\n十、完整协议\n本协议由《云债行服务协议》条款等本网站不时公示的各项规则组成，各项规则有约定，而本协议条款没有约定的，以各项规则约定为准。您对本协议理解和认同，您即对本协议所有组成部分的内容理解并认同，一旦您取得债云端账户，或您以其他本公司允许的方式实际使用本服务，您和本公司即受本协议所有组成部分的约束。本协议部分内容被有管辖权的法院认定为违法或无效的，不因此影响其他内容的效力。\n\n十一、商标、知识产权的保护\n（一） 本网站上所有内容，包括但不限于著作、图片、档案、资讯、资料、网站架构、网站画面的安排、网页设计，均由本公司或本公司关联企业依法拥有其知识产权，包括但不限于商标权、专利权、著作权、商业秘密等。\n（二） 非经本公司或本公司关联企业书面同意，任何人不得擅自使用、修改、复制、公开传播、改变、散布、发行或公开发表本网站程序或内容。\n（三） 尊重知识产权是您应尽的义务，如有违反，您应承担损害赔偿责任。\n\n十二、法律适用与管辖\n本协议之效力、解释、变更、执行与争议解决均适用中华人民共和国法律。因本协议产生之争议，均应依照中华人民共和国法律予以处理，并由被告住所地人民法院管辖。"];
    protoAlterview.delegate=self;
    [protoAlterview show];
    
}
@end
