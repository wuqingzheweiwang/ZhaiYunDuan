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
    [_protorclBut setTitle:@"《XXX用户协议》" forState:UIControlStateNormal];
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

//  展示协议
-(void)showProtrocl
{
    protoAlterview =[[ZJProtocolAlterView alloc]initWithProtocoltype:@"1111" withTitle:@"1111"];
    protoAlterview.delegate=self;
    [protoAlterview show];
    
}

#pragma mark ZJProtocolAlterDelegate
- (void)zjProtocolAlertClikButtonIndex:(NSInteger)index alert:(ZJProtocolAlterView *)alert
{
    if (index == 2001) {
        [protoAlterview dismiss];
        
    }else if (index==2002){
        if (alert.isAgree) {
            [protoAlterview dismiss];
            
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
                //NSLog(@"____%@",strTime);
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
    
    NSLog(@"textFieldDidBeginEditing");
    
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
    
    NSLog(@"touchesBegan");
    
    [self.view endEditing:YES];
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
}
@end
