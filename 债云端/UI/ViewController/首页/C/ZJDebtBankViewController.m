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
@property (nonatomic , strong) NSString *orderId;
@property (nonatomic , strong)  NSMutableArray *province_nameArrM;
@property (nonatomic , strong)  NSMutableArray *city_nameArrM;
@property (nonatomic , strong)  NSMutableArray *county_nameArrM;
@property (nonatomic , strong)  NSMutableArray *province_idArrM;
@property (nonatomic , strong)  NSMutableArray *city_idArrM;
@property (nonatomic , strong)  NSMutableArray *county_idArrM;


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

-(void)setProtrolAlert
{
    [self.view endEditing:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    protoAlterview=[[ZJProtocolAlterView alloc]initWithProtocoltype:@"用户协议" withTitle:@"文化人口布局的你从未；拉萨VCVB即可成为，第三名女可我觉得，什么协议文化人口布局的你从未；拉萨VCVB即可成为，第三名女可我觉得，什么协议文化人口布局的你从未；拉萨VCVB即可成为，第三名女可我觉得，什么协议文化人口布局的你从未；拉萨VCVB即可成为，第三名女可我觉得，什么协议文化人口布局的你从未；拉萨VCVB即可成为，第三名女可我觉得，什么协议文化人口布局的你从未；拉萨VCVB即可成为，第三名女可我觉得，什么是大V领卡呢"];
    protoAlterview.delegate=self;
    [protoAlterview show];

}

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

    NSLog(@"%@ %@ %@",_provinceId,_cityId,_distristId);
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
            
            NSLog(@"1111111%@",responseData);
            // 后台设定成功
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
               
                self.orderId =[responseData objectForKey:@"data"];
//                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];

                ZJPayMoneyViewController * payViewController = [[ZJPayMoneyViewController alloc]initWithNibName:@"ZJPayMoneyViewController" bundle:nil];
                payViewController.orderid = self.orderId;
                payViewController.type = @"2";
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

// 菊花
- (void)showProgress
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)dismissProgress
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
