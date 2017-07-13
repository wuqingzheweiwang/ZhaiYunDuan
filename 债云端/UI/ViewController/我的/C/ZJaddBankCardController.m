//
//  ZJaddBankCardController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/7.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJaddBankCardController.h"
#import "ZJBankCardViewController.h"
#import "ZJBankCardTool.h"
#import "ZJMyPageRequest.h"

@interface ZJaddBankCardController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headViiew;
@property (weak, nonatomic) IBOutlet UILabel *headViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardNameTextField;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardNumeberTextField;
@property (weak, nonatomic) IBOutlet UIView *cardNumeberBottomLine;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeTextField;

@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UILabel *telePhoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *telePhoneTextField;
@property (weak, nonatomic) IBOutlet UIView *telePhoneLabelLine;
@property (weak, nonatomic) IBOutlet UILabel *textAndVerfictionLabel;
@property (weak, nonatomic) IBOutlet UITextField *tverficationTexField;
@property (weak, nonatomic) IBOutlet UIButton *getVerficationBut;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIButton *successfulBut;

@end

@implementation ZJaddBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setAddBankCardUI];
}

-(void)setAddBankCardUI
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"添加银行卡"];
    
    _headViiew.top = 64;
    _headViiew.left = 0;
    _headViiew.width = ZJAPPWidth;
    _headViiew.height = TRUE_1(88/2);
    _headViewLabel.top = 0;
    _headViewLabel.left = TRUE_1(40/2);
    _headViewLabel.width = _headViiew.width - _headViiew.left;
    _headViewLabel.height = _headViiew.height;
    [_headViewLabel setFont:ZJ_TRUE_FONT(13)];
    //  持卡人

    _cardNameLabel.top = _headViiew.bottom;
    _cardNameLabel.left = _headViewLabel.left;
    _cardNameLabel.width = TRUE_1(120/2);
    _cardNameLabel.height = TRUE_1(100/2);
    [_cardNameLabel setFont:ZJ_TRUE_FONT(15)];
    //  持卡人姓名
    _cardNameTextField.top = _cardNameLabel.top;
    _cardNameTextField.left = _cardNameLabel.right;
    _cardNameTextField.width = ZJAPPWidth - TRUE_1(40) - _cardNameLabel.width;
    _cardNameTextField.height = _cardNameLabel.height;
//    _cardNameTextField.delegate = self;


    _firstView.top = _cardNameLabel.bottom;
    _firstView.left = 0;
    _firstView.width = _headViewLabel.width;
    _firstView.height = TRUE_1(10/2);
    
    //  卡号
    _cardNumberLabel.top = _firstView.bottom;
    _cardNumberLabel.left = _cardNameLabel.left;
    _cardNumberLabel.width = _cardNameLabel.width;
    _cardNumberLabel.height = _cardNameLabel.height ;
    [_cardNumberLabel setFont:ZJ_TRUE_FONT(15)];
    
    //  输入卡号
    _cardNumeberTextField.top = _cardNumberLabel.top;
    _cardNumeberTextField.left = _cardNameTextField.left;
    _cardNumeberTextField.width = _cardNameTextField.width;
    _cardNumeberTextField.height = _cardNameTextField.height;
    _cardNumeberTextField.keyboardType = UIKeyboardTypeDecimalPad;
    _cardNumeberTextField.delegate = self;
//    [_cardNumeberTextField addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    _cardNumeberBottomLine.top = _cardNumberLabel.bottom;
    _cardNumeberBottomLine.left = 0;
    _cardNumeberBottomLine.width = ZJAPPWidth;
    _cardNumeberBottomLine.height = 1;
    
    // 卡类型
    _cardTypeLabel.top = _cardNumeberBottomLine.bottom;
    _cardTypeLabel.left = _cardNumberLabel.left;
    _cardTypeLabel.width = _cardNumberLabel.width;
    _cardTypeLabel.height = _cardNumberLabel.height;
    [_cardTypeLabel setFont:ZJ_TRUE_FONT(15)];
    
    // 显示卡类型 (其实是Label)
    _cardTypeTextField.top = _cardTypeLabel.top;
    _cardTypeTextField.left = _cardNumeberTextField.left;
    _cardTypeTextField.width = _cardNumeberTextField.width;
    _cardTypeTextField.height = _cardNumeberTextField.height;
    _cardTypeTextField.textColor = ZJColor_333333;
//    _cardTypeTextField.text = @"中国银联";
    
    _secondView.top = _cardTypeLabel.bottom;
    _secondView.left = _firstView.left;
    _secondView.width = _firstView.width;
    _secondView.height = _firstView.height;
    //  手机号
    _telePhoneLabel.top = _secondView.bottom;
    _telePhoneLabel.left = _cardTypeLabel.left;
    _telePhoneLabel.width = _cardTypeLabel.width;
    _telePhoneLabel.height = _cardTypeLabel.height;
    [_telePhoneLabel setFont:ZJ_TRUE_FONT(15)];
    //  输入手机号
    _telePhoneTextField.top = _telePhoneLabel.top;
    _telePhoneTextField.left = _cardTypeTextField.left;
    _telePhoneTextField.width = _cardTypeTextField.width;
    _telePhoneTextField.height = _cardTypeTextField.height;
    _telePhoneTextField.keyboardType = UIKeyboardTypeNumberPad;

    _telePhoneLabelLine.top = _telePhoneLabel.bottom;
    _telePhoneLabelLine.left = _cardNumeberBottomLine.left;
    _telePhoneLabelLine.width = _cardNumeberBottomLine.width;
    _telePhoneLabelLine.height = _cardNumeberBottomLine.height;
    // 验证码
    _textAndVerfictionLabel.top = _telePhoneLabelLine.bottom;
    _textAndVerfictionLabel.left = _telePhoneLabel.left;
    _textAndVerfictionLabel.width = _telePhoneLabel.width;
    _textAndVerfictionLabel.height = _telePhoneLabel.height;
    [_textAndVerfictionLabel setFont:ZJ_TRUE_FONT(15)];
    //  输入验证码
    _tverficationTexField.top = _textAndVerfictionLabel.top;
    _tverficationTexField.left = _telePhoneTextField.left;
    _tverficationTexField.width = _telePhoneTextField.width;
    _tverficationTexField.height = _telePhoneTextField.height;
    _tverficationTexField.keyboardType = UIKeyboardTypeNumberPad;
    _tverficationTexField.delegate = self;
    
    //  获取验证码
    _getVerficationBut.centerY = _tverficationTexField.centerY;
    _getVerficationBut.width = TRUE_1(150/2);
    _getVerficationBut.height = TRUE_1(50/2);
    _getVerficationBut.right = _tverficationTexField.right - _getVerficationBut.width;
    _getVerficationBut.layer.masksToBounds = YES;
    _getVerficationBut.layer.cornerRadius = 3;
    [_getVerficationBut.titleLabel setFont:ZJ_TRUE_FONT(12)];
    [_getVerficationBut setBackgroundColor:ZJColor_red];
    [_getVerficationBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getVerficationBut addTarget:self action:@selector(getVerification) forControlEvents:UIControlEventTouchUpInside];

    
    _thirdView.top = _textAndVerfictionLabel.bottom;
    _thirdView.left = _secondView.left;
    _thirdView.width = _secondView.width;
    _thirdView.height = _secondView.height;
    //  完成
    _successfulBut.top = _thirdView.bottom + TRUE_1(40/2);
    _successfulBut.left = TRUE_1(85/2);
    _successfulBut.width = ZJAPPWidth - TRUE_1(85);
    _successfulBut.height = TRUE_1(66/2);
    [_successfulBut.titleLabel setFont:ZJ_TRUE_FONT(12)];
    _successfulBut.layer.masksToBounds = YES;
    _successfulBut.layer.cornerRadius = 5;
    [_successfulBut addTarget:self action:@selector(gotoBankCardPage) forControlEvents:UIControlEventTouchUpInside];
}


//  获取验证码(短信验证倒计时读秒)
-(void)getVerification
{
    // 验证码请求
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
                [_getVerficationBut setBackgroundColor:ZJColor_red];
                [_getVerficationBut setTitle:@"重新获取" forState:UIControlStateNormal];
                _getVerficationBut.userInteractionEnabled = YES;
            });
        }else{
            
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.1];
                [_getVerficationBut setBackgroundColor:ZJColor_999999];
                [_getVerficationBut setTitle:[NSString stringWithFormat:@"%@s后重送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _getVerficationBut.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

//发送验证码
-(void)getVerifyRequestData
{
    
    NSString * action=[NSString stringWithFormat:@"api/regist/smscode?mobile=%@",_telePhoneTextField.text];
    // 网络请求
    [ZJMyPageRequest zjRegistVerifyWithActions:action result:^(BOOL success, id responseData) {
        // 成功
        if (success) {
            DLog(@"%@",responseData);
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

// 添加银行卡网络请求
-(void)addBANKcardDataRequest
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:self.cardNameTextField.text,@"bankCode",self.cardNumeberTextField.text,@"bankname",self.cardTypeTextField.text,@"",self.telePhoneTextField.text,@"",self.tverficationTexField.text,@"",nil];
    // 网络请求
    [ZJMyPageRequest zjaddBandCardWithParams:dic result:^(BOOL success, id responseData) {
        
        // 请求成功
        if (success) {
            DLog(@"%@",responseData);
            // 后台定义的
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                // 主线程刷新UI
                [self performSelectorOnMainThread:@selector(reloadUI) withObject:nil waitUntilDone:YES];
                
            }else if ([[responseData objectForKey:@"state"]isEqualToString:@"error"])
            {
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"error"]];
            }
            
        }
        // 请求失败
        else{
            
        }
        
    }];

}
//刷新UI
-(void)reloadUI
{
    
    
    
    
}

// 回到银行卡页面
-(void)gotoBankCardPage
{
    for (UITextField* textFieldsubView in self.view.subviews)
    {
        [textFieldsubView resignFirstResponder];
    }

    if ([ZJUtil isEmptyStr:_cardNameTextField.text]) {
        [ZJUtil showBottomToastWithMsg:@"请输入真实姓名"];
        return;
    }
    
    if (![ZJUtil IsBankCard:_cardNumeberTextField.text]) {
        
        [ZJUtil showBottomToastWithMsg:@"正输入正确的银行卡号"];
        return;
        
    }

    if (![ZJUtil isMobileNo:_telePhoneTextField.text]) {
        [ZJUtil showBottomToastWithMsg:@"请输入正确手机号"];
        return;
    }
    if([ZJUtil isEmptyStr:_tverficationTexField.text]){
        [ZJUtil showBottomToastWithMsg:@"请输入验证码"];
        return;
    }

    // 点击完成添加银行卡
    [NSThread detachNewThreadSelector:@selector(addBANKcardDataRequest) toTarget:self withObject:nil];

    
     ZJBankCardViewController *zjBankVC = [[ZJBankCardViewController alloc]initWithNibName:@"ZJBankCardViewController" bundle:nil];
    
    [self.navigationController pushViewController:zjBankVC animated:YES];
}

#pragma mark - UITextFieldDelegate UITextField键入字符后调用 
//  使用UITextFieldDelegate自动格式化银行卡号
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    _cardTypeTextField.text = [[ZJBankCardTool sharedBankCardTool]getBankName:_cardNumeberTextField.text];

    //拿到为改变前的字符串
    NSString *text = textField.text;
    //键入字符集，\b标示删除键
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    //对当前键入字符进行空格过滤
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    //invertedSet会对当前结果集取反，检查当前键入字符是否在字符集合中，如果不在则直接返回NO 不改变textField值
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
        }
    //增加当前键入字符在改变前的字符串尾部
    text = [text stringByReplacingCharactersInRange:range withString:string];
    //再次确认去掉字符串中空格
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //初始化字符用来保存格式化后的字符串
    NSString *newString = @"";
    //while中对text进行格式化
    while (text.length > 0) {
    //按4位字符进行截取，如果当前字符不足4位则按照当前字符串的最大长度截取
    NSString *subString = [text substringToIndex:MIN(text.length, 4)];
    //将截取后的字符放入需要格式化的字符串中
    newString = [newString stringByAppendingString:subString];
    if (subString.length == 4) {
    //截取的字符串长度满4位则在后面增加一个空格符
    newString = [newString stringByAppendingString:@" "];
        
    }
    //将text中截取掉字符串去掉
    text = [text substringFromIndex:MIN(text.length, 4)];
    }
    //再次确认过滤掉除指定字符以外的字符
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    //国内银行卡一般为16~19位 格式化后增加4个空格 也就是最多23个字符
    if (newString.length > 23) {
      return NO;
    }
    //手动对textField赋值
    [textField setText:newString];
    
    //返回NO 则不通过委托自动往当前字符后面增加字符，达到格式化效果
    return NO;
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
