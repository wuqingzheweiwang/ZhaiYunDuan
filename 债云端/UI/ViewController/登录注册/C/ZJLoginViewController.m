//
//  ZJLoginViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/4/24.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJLoginViewController.h"
#import "ZJRegistViewController.h"
#import "ZJFoundPasswordController.h"
#import "ZJLoginRegistRequest.h"
#import "ZJMyPageViewController.h"
@interface ZJLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *telePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *passWordLabel;
@property (weak, nonatomic) IBOutlet UITextField *telePhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordBut;
@property (weak, nonatomic) IBOutlet UIButton *LoginBut;
@property (weak, nonatomic) IBOutlet UIButton *registeBut;
@property (weak, nonatomic) IBOutlet UILabel *leftLine;
@property (weak, nonatomic) IBOutlet UILabel *otherSourceLoginLabrl;
@property (weak, nonatomic) IBOutlet UILabel *rightLine;
@property (weak, nonatomic) IBOutlet UIButton *QQBut;
@property (weak, nonatomic) IBOutlet UIButton *WechatBut;
@property (weak, nonatomic) IBOutlet UIButton *SinaBut;

@end

@implementation ZJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLoginUI];

}


-(void)setLoginUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"登录"];

    // 手机号Label
    _telePhoneLabel.top = TRUE_1(20)+64;
    _telePhoneLabel.left= TRUE_1(40);
    _telePhoneLabel.width= TRUE_1(55);
    _telePhoneLabel.height= TRUE_1(33);
    _telePhoneLabel.font = ZJ_TRUE_FONT(15);

    // 密码Label
    _passWordLabel.top = _telePhoneLabel.bottom+TRUE_1(20);
    _passWordLabel.left= _telePhoneLabel.left;
    _passWordLabel.width= _telePhoneLabel.width;
    _passWordLabel.height= _telePhoneLabel.height;
    _passWordLabel.font = ZJ_TRUE_FONT(15);

    // 手机号
    _telePhoneTextField.top = TRUE_1(20)+64;
    _telePhoneTextField.left= _telePhoneLabel.right+TRUE_1(18);
    _telePhoneTextField.width= ZJAPPWidth-TRUE_1(80)-TRUE_1(55)-TRUE_1(18);
    _telePhoneTextField.height= TRUE_1(33);
    _telePhoneTextField.layer.borderWidth = 1;
    _telePhoneTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _telePhoneTextField.layer.masksToBounds = YES;
    _telePhoneTextField.layer.cornerRadius = 5;
    _telePhoneTextField.delegate = self;
    _telePhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    // 密码
    _passWordTextField.top = _telePhoneTextField.bottom+TRUE_1(20);
    _passWordTextField.left= _telePhoneTextField.left;
    _passWordTextField.width= _telePhoneTextField.width;
    _passWordTextField.height= _telePhoneTextField.height;
    _passWordTextField.layer.borderWidth = 1;
    _passWordTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _passWordTextField.layer.masksToBounds = YES;
    _passWordTextField.layer.cornerRadius = 5;
    _passWordTextField.delegate = self;
    // 密文输入
    _passWordTextField.secureTextEntry = YES;

//   忘记密码
    _forgetPasswordBut.top = _passWordTextField.bottom+TRUE_1(20/2);
    _forgetPasswordBut.width = TRUE_1(100);
    _forgetPasswordBut.height = TRUE_1(25/2);
    _forgetPasswordBut.right = _passWordTextField.right - _forgetPasswordBut.width;
    [_forgetPasswordBut setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_forgetPasswordBut.titleLabel setFont:ZJ_TRUE_FONT(12)];
    [_forgetPasswordBut addTarget:self action:@selector(forgertPassword) forControlEvents:UIControlEventTouchUpInside];
    
    // 登录
    _LoginBut.top = _forgetPasswordBut.bottom+TRUE_1(10);
    _LoginBut.left = TRUE_1(94/2);
    _LoginBut.width = ZJAPPWidth-TRUE_1(94);
    _LoginBut.height = TRUE_1(33);
    _LoginBut.layer.masksToBounds = YES;
    _LoginBut.layer.cornerRadius = 5;
    [_LoginBut.titleLabel setFont:ZJ_TRUE_FONT(15)];
    [_LoginBut addTarget:self action:@selector(lgoinView) forControlEvents:UIControlEventTouchUpInside];
    
    // 注册
    _registeBut.top = _LoginBut.top+_LoginBut.height+TRUE_1(20);
    _registeBut.left = _LoginBut.left;
    _registeBut.width = _LoginBut.width;
    _registeBut.height = _LoginBut.height;
    _registeBut.layer.borderWidth=1;
    _registeBut.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _registeBut.layer.masksToBounds = YES;
    _registeBut.layer.cornerRadius = 5;
    [_registeBut.titleLabel setFont:ZJ_TRUE_FONT(15)];

    // 左线Line
    _leftLine.top =_registeBut.bottom+TRUE_1(70/2);
    _leftLine.left = _LoginBut.left;
    _leftLine.width = (ZJAPPWidth-TRUE_1(92))/3;
    _leftLine.height = 1;
    _leftLine.hidden = YES;
    // 第三方登录Line
    _otherSourceLoginLabrl.top = _registeBut.top+_registeBut.height+TRUE_1(60/2);
    _otherSourceLoginLabrl.left=(ZJAPPWidth-TRUE_1(92))/3+ _LoginBut.left;
    _otherSourceLoginLabrl.textAlignment=NSTextAlignmentCenter;
    _otherSourceLoginLabrl.width = (ZJAPPWidth-TRUE_1(92))/3;
    _otherSourceLoginLabrl.height = TRUE_1(28/2);
    _otherSourceLoginLabrl.font = ZJ_TRUE_FONT(14);
    _otherSourceLoginLabrl.hidden = YES;
    // 右线Line
    _rightLine.top =_registeBut.bottom+TRUE_1(70/2);
    _rightLine.left =(ZJAPPWidth-TRUE_1(92))/3*2+ _LoginBut.left;
    _rightLine.width = _leftLine.width;
    _rightLine.height = 1;
    _rightLine.hidden = YES;
    // QQ
    _QQBut.top = TRUE_1(693/2);
    _QQBut.left = TRUE_1(118/2);
    _QQBut.width = TRUE_1(60);
    _QQBut.height = TRUE_1(60);
    [_QQBut setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    _QQBut.hidden = YES;
    // 微信
    _WechatBut.top = _QQBut.top;
    _WechatBut.left = _QQBut.right+((ZJAPPWidth-TRUE_1(180))-TRUE_1(118))/2;
    _WechatBut.width = _QQBut.width;
    _WechatBut.height = _QQBut.height;
    [_WechatBut setBackgroundImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    _WechatBut.hidden = YES;

    // 新浪微博
    _SinaBut.top = _WechatBut.top;
    _SinaBut.left = _WechatBut.right+((ZJAPPWidth-TRUE_1(180))-TRUE_1(118))/2;
    _SinaBut.width = _WechatBut.width;
    _SinaBut.height = _WechatBut.height;
    [_SinaBut setBackgroundImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
    _SinaBut.hidden = YES;


}

// 忘记密码
-(void)forgertPassword
{
    ZJFoundPasswordController *foundPass = [[ZJFoundPasswordController alloc]initWithNibName:@"ZJFoundPasswordController" bundle:nil];
    [self.navigationController pushViewController:foundPass animated:YES];
}

/*
 * 登录相关
 */

// 登录
-(void)lgoinView{
    
    
    for (UITextField* textFieldsubView in self.view.subviews)
    {
        [textFieldsubView resignFirstResponder];
    }

    if (![ZJUtil isMobileNo:_telePhoneTextField.text]) {
        [ZJUtil showBottomToastWithMsg:@"请输入正确手机号"];
        return;
    }else if([ZJUtil isEmptyStr:_passWordTextField.text]){
        [ZJUtil showBottomToastWithMsg:@"请输入密码"];
        return;
    }
    

    // 登录请求
    [NSThread detachNewThreadSelector:@selector(loginRequestData) toTarget:self withObject:nil];

    
    
}

// 登录请求
-(void)loginRequestData
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:_telePhoneTextField.text,@"username",_passWordTextField.text,@"password",@"888888",@"validCode", nil];
    // 菊花
    [self performSelectorOnMainThread:@selector(showProgress) withObject:nil waitUntilDone:YES];
    // 网络请求
    [ZJLoginRegistRequest zjLoginWithParams:dic result:^(BOOL success, id responseData) {
        [self performSelectorOnMainThread:@selector(dismissProgress) withObject:nil waitUntilDone:YES];
          DLog(@"%@",responseData);
//         请求成功
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                [ZJUserInfo saveUserInfoWithUserToken:[[responseData objectForKey:@"data"] objectForKey:@"token"]];
                NSString * typeismember=[NSString stringWithFormat:@"%@",[[responseData objectForKey:@"data"] objectForKey:@"type"]];
                [ZJUserInfo saveUserInfoWithUserRole:typeismember];
                
                [self performSelectorOnMainThread:@selector(reloadUI) withObject:nil waitUntilDone:YES];
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
            }
        }
         // 请求失败
        else{
            [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"系统异常"]];
        }
    }];

}

// 刷新UI
-(void)reloadUI
{
    // 设置登录状态
    [ZJUserInfo changeUserLoginState:YES];
    
    if (self.isChange) {

        [self.navigationController popToRootViewControllerAnimated:YES];

    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//  跳转注册页面
- (IBAction)registeBut:(id)sender {
    

    for (UITextField* textFieldsubView in self.view.subviews)
    {
        [textFieldsubView resignFirstResponder];
    }
    ZJRegistViewController *zjRegist = [[ZJRegistViewController alloc]initWithNibName:@"ZJRegistViewController" bundle:nil];
    [zjRegist setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:zjRegist animated:YES];

    
    
}

// QQ登录
- (IBAction)QQBut:(id)sender {
    
    
    
}

// 微信登录
- (IBAction)WechatBut:(id)sender {
    
    
    
}

// 微博登录
- (IBAction)SinaBut:(id)sender {
    
    
    
}
/*
 *
 */
#pragma mark 键盘
//  防止再次编辑被清空
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //得到输入框的内容
    NSString * textfieldContent = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == _passWordTextField && textField.isSecureTextEntry ) {
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



@end
