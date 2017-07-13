//
//  ZJFoundPasswordController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/5.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJFoundPasswordController.h"
#import "ZJLoginRegistRequest.h"
@interface ZJFoundPasswordController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *telePhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *telePhoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *testAndverifyLabel;
@property (weak, nonatomic) IBOutlet UITextField *testAndVerTextField;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyBut;
@property (weak, nonatomic) IBOutlet UILabel *newpassLabel;
@property (weak, nonatomic) IBOutlet UITextField *newpassTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextBut;

@end

@implementation ZJFoundPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavcation];
    [self setFoundPassWordUI];


}

-(void)setNavcation
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"找回密码"];
}


-(void)setFoundPassWordUI
{
    self.navigationItem.hidesBackButton = YES;
    
    _telePhoneNumber.top = TRUE_1(60/2)+64;
    _telePhoneNumber.left =TRUE_1(80/2);
    _telePhoneNumber.width = TRUE_1(140/2);
    _telePhoneNumber.height = TRUE_1(66/2);
    _telePhoneNumber.font = ZJ_TRUE_FONT(15);
    // 手机号
    _telePhoneTextField.top = _telePhoneNumber.top;
    _telePhoneTextField.left = _telePhoneNumber.right;
    _telePhoneTextField.width = ZJAPPWidth - TRUE_1(80)-_telePhoneNumber.width;
    _telePhoneTextField.height = _telePhoneNumber.height;
    _telePhoneTextField.layer.borderWidth = 1;
    _telePhoneTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _telePhoneTextField.layer.masksToBounds = YES;
    _telePhoneTextField.layer.cornerRadius = 5;
    _telePhoneTextField.delegate = self;
    _telePhoneTextField.keyboardType = UIKeyboardTypeNumberPad;

    // 获取验证码Label
    _testAndverifyLabel.top = _telePhoneTextField.bottom + TRUE_1(40/2);
    _testAndverifyLabel.left = _telePhoneNumber.left;
    _testAndverifyLabel.width = _telePhoneNumber.width;
    _testAndverifyLabel.height = _telePhoneNumber.height;
    _testAndverifyLabel.font = ZJ_TRUE_FONT(15);

    // 输入验证码
    _testAndVerTextField.top = _testAndverifyLabel.top;
    _testAndVerTextField.left = _telePhoneTextField.left;
    _testAndVerTextField.width = _telePhoneTextField.width;
    _testAndVerTextField.height = _telePhoneTextField.height;
    _testAndVerTextField.layer.borderWidth = 1;
    _testAndVerTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _testAndVerTextField.layer.masksToBounds = YES;
    _testAndVerTextField.layer.cornerRadius = 5;
    _testAndVerTextField.delegate = self;
    _testAndVerTextField.keyboardType = UIKeyboardTypeNumberPad;

    _newpassLabel.top = _testAndverifyLabel.bottom+TRUE_1(40/2);;
    _newpassLabel.left = _telePhoneNumber.left;
    _newpassLabel.width = _telePhoneNumber.width;
    _newpassLabel.height = _telePhoneNumber.height;
    _newpassLabel.font = ZJ_TRUE_FONT(15);

    _newpassTextField.top = _newpassLabel.top;
    _newpassTextField.left = _telePhoneTextField.left;
    _newpassTextField.width = _telePhoneTextField.width;
    _newpassTextField.height = _telePhoneTextField.height;
    _newpassTextField.layer.borderWidth = 1;
    _newpassTextField.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _newpassTextField.layer.masksToBounds = YES;
    _newpassTextField.layer.cornerRadius = 5;
    _newpassTextField.delegate = self;
    _newpassTextField.secureTextEntry = YES;

    
    // 获取验证码
    _getVerifyBut.top =_testAndverifyLabel.top+TRUE_1(8);
    _getVerifyBut.width = TRUE_1(100/2);
    _getVerifyBut.height = TRUE_1(35/2);
    _getVerifyBut.right = _testAndVerTextField.right - _getVerifyBut.width - TRUE_1(10);
    _getVerifyBut.layer.masksToBounds = YES;
    _getVerifyBut.layer.cornerRadius = 3;
    [_getVerifyBut.titleLabel setFont:ZJ_TRUE_FONT(9)];
    [_getVerifyBut setBackgroundColor:ZJColor_red];
    [_getVerifyBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getVerifyBut addTarget:self action:@selector(getVerification) forControlEvents:UIControlEventTouchUpInside];
    
    //  完成
    _nextBut.top = _newpassTextField.bottom + TRUE_1(40/2);
    _nextBut.left = TRUE_1(90/2);
    _nextBut.width = ZJAPPWidth - TRUE_1(90);
    _nextBut.height = _testAndVerTextField.height;
    _nextBut.layer.masksToBounds = YES;
    _nextBut.layer.cornerRadius = 5;
    [_nextBut.titleLabel setFont:ZJ_TRUE_FONT(15)];
    [_nextBut addTarget:self action:@selector(isSuccessful) forControlEvents:UIControlEventTouchUpInside];
}

//完成
-(void)isSuccessful
{
    for (UITextField* textFieldsubView in self.view.subviews)
    {
        [textFieldsubView resignFirstResponder];
    }
    if (![ZJUtil isMobileNo:_telePhoneTextField.text]) {
        [ZJUtil showBottomToastWithMsg:@"请输入正确手机号"];
        return;
    }
    if([ZJUtil isEmptyStr:_testAndVerTextField.text]){
        [ZJUtil showBottomToastWithMsg:@"请输入验证码"];
        return;
    }
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:_telePhoneTextField.text,@"mobile",_testAndVerTextField.text,@"code",_newpassTextField.text,@"newPwd", nil];
    [self performSelectorOnMainThread:@selector(showProgress) withObject:nil waitUntilDone:YES];
    // 网络请求
    [ZJLoginRegistRequest zjFoundPasswordVerifyWithParams:dic result:^(BOOL success, id responseData) {
        
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
            
            [ZJUtil showBottomToastWithMsg:responseData];
        }
    }];

}

//刷新uI
-(void)reloadUI
{
    
    [ZJUtil showBottomToastWithMsg:@"修改密码成功"];
    [self.navigationController popViewControllerAnimated:YES];
    
}


//  获取验证码(短信验证倒计时读秒)
-(void)getVerification
{
    // 找回密码
    [NSThread detachNewThreadSelector:@selector(foundPasswordData) toTarget:self withObject:nil];
    
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getVerifyBut setBackgroundColor:ZJColor_red];
                [_getVerifyBut setTitle:@"重新获取" forState:UIControlStateNormal];
                _getVerifyBut.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.1];
                [_getVerifyBut setBackgroundColor:ZJColor_999999];
                [_getVerifyBut setTitle:[NSString stringWithFormat:@"%@s后重送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _getVerifyBut.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

//发送验证码
-(void)foundPasswordData{
    
    NSString * action=[NSString stringWithFormat:@"api/regist/smscode?mobile=%@",_telePhoneTextField.text];
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


#pragma mark 键盘
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
