//
//  ZJChangeTelNumberController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/19.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJChangeTelNumberController.h"
#import "ZJLoginViewController.h"
@interface ZJChangeTelNumberController ()

@property (weak, nonatomic) IBOutlet UIView *firstBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *firstViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *telePhoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *telePhoneNumber;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UILabel *verifyLabel;
@property (weak, nonatomic) IBOutlet UITextField *verifyTextF;
@property (weak, nonatomic) IBOutlet UIButton *verifyBut;
@property (weak, nonatomic) IBOutlet UIView *thirdbackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *saveBut;
@property (nonatomic , assign) BOOL isChange;
@end

@implementation ZJChangeTelNumberController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setNavigation];
    
    [self SetChangeTelNumberControllerUI];

}

-(void)setNavigation
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"更换手机号"];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)SetChangeTelNumberControllerUI
{
    _firstBackgroundView.top = 64;
    _firstBackgroundView.left = 0;
    _firstBackgroundView.width = ZJAPPWidth;
    _firstBackgroundView.height = TRUE_1(80/2);
    
    
    _firstViewLabel.top = 0;
    _firstViewLabel.left = _firstBackgroundView.left+TRUE_1(40/2);
    _firstViewLabel.width = _firstBackgroundView.width - TRUE_1(40/2);
    _firstViewLabel.height = _firstBackgroundView.height;
    _firstViewLabel.font = ZJ_TRUE_FONT(13);
    
    _telePhoneLabel.top = _firstBackgroundView.bottom;
    _telePhoneLabel.left = TRUE_1(40/2);
    _telePhoneLabel.width = TRUE_1(100/2);
    _telePhoneLabel.height = TRUE_1(100/2);
    _telePhoneLabel.font = ZJ_TRUE_FONT(15);

    // 手机号
    _telePhoneNumber.top = _telePhoneLabel.top;
    _telePhoneNumber.left = _telePhoneLabel.right+TRUE_1(10);
    _telePhoneNumber.width = ZJAPPWidth - TRUE_1(40)-_telePhoneLabel.width;
    _telePhoneNumber.height = _telePhoneLabel.height;
    
    _secondView.top = _telePhoneLabel.bottom;
    _secondView.left = 0;
    _secondView.width = ZJAPPWidth;
    _secondView.height = 1;
    
    _verifyLabel.top = _secondView.bottom;
    _verifyLabel.left = _telePhoneLabel.left;
    _verifyLabel.width = _telePhoneLabel.width;
    _verifyLabel.height = _telePhoneLabel.height;
    _verifyLabel.font = ZJ_TRUE_FONT(15);
    // 验证码
    _verifyTextF.top =  _verifyLabel.top;
    _verifyTextF.left = _telePhoneNumber.left;
    _verifyTextF.width = _telePhoneNumber.width;
    _verifyTextF.height = _telePhoneNumber.height;
    // 获取验证码
    _verifyBut.top = _verifyTextF.top+TRUE_1(28/2);
    _verifyBut.width = TRUE_1(150/2);
    _verifyBut.height = TRUE_1(50/2);
    _verifyBut.left = _verifyTextF.right - _verifyBut.width;
    _verifyBut.layer.masksToBounds = YES;
    _verifyBut.layer.cornerRadius = 3;
    [_verifyBut.titleLabel setFont:ZJ_TRUE_FONT(12)];
    [_verifyBut addTarget:self action:@selector(getVerify) forControlEvents:UIControlEventTouchUpInside];
    
    _thirdbackgroundView.top = _verifyLabel.bottom;
    _thirdbackgroundView.left = 0;
    _thirdbackgroundView.width = ZJAPPWidth;
    _thirdbackgroundView.height = TRUE_1(10/2);
    
    _saveBut.top = _thirdbackgroundView.bottom +TRUE_1(40/2);
    _saveBut.left = TRUE_1(85/2);
    _saveBut.width = ZJAPPWidth - TRUE_1(85);
    _saveBut.height = TRUE_1(66/2);
    [_saveBut.titleLabel setFont:ZJ_TRUE_FONT(15)];
    _saveBut.layer.masksToBounds = YES;
    _saveBut.layer.cornerRadius = 5;
    [_saveBut addTarget:self action:@selector(saveTelephoneNumber) forControlEvents:UIControlEventTouchUpInside];
}

// 获取验证码
-(void)getVerify
{
    // 获取验证码
    [NSThread detachNewThreadSelector:@selector(getVerifyRequestData) toTarget:self withObject:nil];

    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_verifyBut setBackgroundColor:ZJColor_red];
                [_verifyBut setTitle:@"重新获取" forState:UIControlStateNormal];
                _verifyBut.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.1];
                [_verifyBut setBackgroundColor:ZJColor_999999];
                [_verifyBut setTitle:[NSString stringWithFormat:@"%@s后重送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _verifyBut.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

//发送验证码
-(void)getVerifyRequestData
{
    
    NSString * action=[NSString stringWithFormat:@"api/regist/smscode?mobile=%@",_telePhoneNumber.text];
    // 网络请求
    [ZJMyPageRequest zjRegistVerifyWithActions:action result:^(BOOL success, id responseData) {
        // 成功
        if (success) {
            NSLog(@"%@",responseData);
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


// 点击保存
-(void)saveTelephoneNumber
{
    // 键盘辞去第一响应者
    for (UITextField* textFieldsubView in self.view.subviews)
    {
        [textFieldsubView resignFirstResponder];
    }
    
    if (![ZJUtil isMobileNo:_telePhoneNumber.text]) {
                [ZJUtil showBottomToastWithMsg:@"请输入正确手机号"];
                return;
            }else
    if([ZJUtil isEmptyStr:_verifyTextF.text]){
            [ZJUtil showBottomToastWithMsg:@"请输入正确的验证码"];
            return;
        }

    // 网络请求
    [self upTelephoneNumberData];
    
    
}



// 保存手机号请求
-(void)upTelephoneNumberData
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:_telePhoneNumber.text,@"mobile",_verifyTextF.text,@"validcode", nil];
    
    [self showProgress];

    // 网络请求
    [ZJMyPageRequest zjChangeTelphoneNumberWithParams:dic result:^(BOOL success, id responseData) {
     
    [self dismissProgress];
        
        // 成功
        if (success) {
            NSLog(@"%@",responseData);
            // 后台设定成功
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                self.isChange = YES;
                [ZJUserInfo removeUserInfoWithUserToken];
                [ZJUserInfo saveUserInfoWithUserToken:[responseData objectForKey:@"data"]];
                
                [self performSelectorOnMainThread:@selector(reloadUI) withObject:nil waitUntilDone:YES];
                // 后台设定失败
            }else if ([[responseData objectForKey:@"state"]isEqualToString:@"warn"]) {
                
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
            
        }else{
            
            self.isChange = NO;

        }
    }];
    
    
}

// 刷新UI
-(void)reloadUI
{
    //跳到登录页面 CCPLoginVC
        ZJLoginViewController *login = [[ZJLoginViewController alloc]initWithNibName:@"ZJLoginViewController" bundle:nil];
       login.isChange = self.isChange;
        //隐藏tabbar
        login.hidesBottomBarWhenPushed =YES;
        [login setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:login animated:YES];
}

#pragma mark 键盘

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
