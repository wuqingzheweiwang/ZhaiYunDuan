//  提现
//  ZJupMoneyViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJupMoneyViewController.h"
#import "ZJActionSheet.h"
#import "ZJaddBankCardController.h"

@interface ZJupMoneyViewController ()<ZJActionSheetAlterDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *bankNumber;
@property (weak, nonatomic) IBOutlet UIImageView *nextImageView;
@property (weak, nonatomic) IBOutlet UIButton *clickChangeCard;

@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;
@property (weak, nonatomic) IBOutlet UITextField *writeMoney;
@property (weak, nonatomic) IBOutlet UILabel *fourthView;
@property (weak, nonatomic) IBOutlet UILabel *balanceMoney;
@property (weak, nonatomic) IBOutlet UIView *fiveView;
@property (weak, nonatomic) IBOutlet UIButton *upMoneyBut;
@property (nonatomic ,strong) NSMutableArray *confirms;

@end

@implementation ZJupMoneyViewController
{
    ZJActionSheet *actionSheet;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavcaition];
    [self setUpMonryUI];
}


-(void)setNavcaition
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"提现"];
}

-(void)setUpMonryUI
{
    _firstView.top = 64;
    _firstView.left = 0;
    _firstView.width = ZJAPPWidth;
    _firstView.height = TRUE_1(150/2);
    
    // 图片
    _imageView.top = TRUE_1(45/2);
    _imageView.left =_firstView.left+TRUE_1(30/2);
    _imageView.width = TRUE_1(60/2);
    _imageView.height = TRUE_1(60/2);
    _imageView.image = [UIImage imageNamed:@"merchantsbank"];
    
    // 银行名称
    _bankName.top = TRUE_1(30/2);
    _bankName.left = _imageView.right+TRUE_1(30/2);
    _bankName.width = TRUE_1(100);
    _bankName.height = TRUE_1(30/2);
    _bankName.font = ZJ_TRUE_FONT(30/2);
    
    //  尾号
    _bankNumber.top = _bankName.bottom+TRUE_1(40/2);
    _bankNumber.left = _bankName.left;
    _bankNumber.width = _bankName.width;
    _bankNumber.height = _bankName.height;
    _bankNumber.font = ZJ_TRUE_FONT(24/2);
    
    //  换卡
    _nextImageView.centerY = _imageView.centerY;
    _nextImageView.top = TRUE_1(66/2);
    _nextImageView.width = TRUE_1(6);
    _nextImageView.height = TRUE_1(10);
    _nextImageView.right = ZJAPPWidth - TRUE_1(30/2)-_nextImageView.width;

    _clickChangeCard.top = 64;
    _clickChangeCard.centerY = _imageView.centerY;
    _clickChangeCard.width = TRUE_1(100);
    _clickChangeCard.height = TRUE_1(80);
    _clickChangeCard.right = ZJAPPWidth - TRUE_1(30/2)-_clickChangeCard.width;
    [_clickChangeCard addTarget:self action:@selector(nextChangeCard) forControlEvents:UIControlEventTouchUpInside];

    _secondView.top = _firstView.bottom;
    _secondView.left = 0;
    _secondView.width = ZJAPPWidth;
    _secondView.height = TRUE_1(10/2);
    
    _thirdView.top = _secondView.bottom;
    _thirdView.left = _secondView.left;
    _thirdView.width = ZJAPPWidth;
    _thirdView.height = TRUE_1(190/2);
    
    // 提现金额
    _moneyLable.top = TRUE_1(20/2);
    _moneyLable.left = _imageView.left;
    _moneyLable.width = TRUE_1(100/2);
    _moneyLable.height = TRUE_1(30/2);
    _moneyLable.font = ZJ_TRUE_FONT(24/2);

    // ¥
    _moneyL.top =_moneyLable.bottom +TRUE_1(20/2);
    _moneyL.left = _moneyLable.left;
    _moneyL.width = TRUE_1(50/2);
    _moneyL.height = TRUE_1(50/2);
    _moneyL.font = ZJ_TRUE_FONT(60/2);

    // 输入提现金额
    _writeMoney.top = _moneyL.top;
    _writeMoney.left = _moneyL.right;
    _writeMoney.width = ZJAPPWidth - TRUE_1(40);
    _writeMoney.height = _moneyL.height;
    _writeMoney.keyboardType = UIKeyboardTypeNumberPad;
    _writeMoney.delegate  =self;
    _writeMoney.font = ZJ_TRUE_FONT(30);
    
    _fourthView.top = _moneyL.bottom+TRUE_1(10/2);
    _fourthView.left = _moneyL.left;
    _fourthView.width = ZJAPPWidth - _fourthView.left;
    _fourthView.height = TRUE_1(1);
    
    // 余额
    _balanceMoney.top = _fourthView.bottom+TRUE_1(13/2);
    _balanceMoney.left = _fourthView.left;
    _balanceMoney.width = ZJAPPWidth- _balanceMoney.left;
    _balanceMoney.height = TRUE_1(30/2);
    _balanceMoney.font = ZJ_TRUE_FONT(26/2);
    _balanceMoney.text = [NSString stringWithFormat:@"可用余额 %d元",1000];
    
    _fiveView.top = _thirdView.bottom;
    _fiveView.left = _secondView.left;
    _fiveView.width = _secondView.width;
    _fiveView.height = TRUE_1(10/2);

    //  提现
    _upMoneyBut.top = _fiveView.bottom+TRUE_1(60/2);
    _upMoneyBut.left = TRUE_1(80/2);
    _upMoneyBut.width = ZJAPPWidth - TRUE_1(80);
    _upMoneyBut.height = TRUE_1(66/2);
    _upMoneyBut.layer.masksToBounds = YES;
    _upMoneyBut.layer.cornerRadius = 5;
    [_upMoneyBut addTarget:self action:@selector(clickUpMoney) forControlEvents:UIControlEventTouchUpInside];
    
}

-(NSMutableArray *)confirms
{
    if (_confirms == nil) {
        _confirms = [NSMutableArray arrayWithObjects:@[
                                                       @[@"merchantsbank",@"招商银行储蓄卡（0506）",@"可用额度50,000.00元",],
                                            ], nil];
    }
    return _confirms;
}

//  更换银行卡
-(void)nextChangeCard
{
    actionSheet =[ZJActionSheet actionSheetWithTitle:@"选择银行卡" confirms:self.confirms cancel:@"" withType:@"tixian" style:ZJActionSheetStyleDefault];
    
    actionSheet.delegate = self;
    [actionSheet showInView:self.view.window];
}


//  提现
-(void)clickUpMoney
{
    
    [_writeMoney resignFirstResponder];
    
    if ([_writeMoney.text isEqualToString:@""]) {
        [ZJUtil showBottomToastWithMsg:@"请输入提现金额"];
        return;
    }else if ([_writeMoney.text integerValue] > [_balanceMoney.text integerValue]){
        [ZJUtil showBottomToastWithMsg:@"账户余额不足"];
    }

    [NSThread detachNewThreadSelector:@selector(getMoneyDataRequest) toTarget:self withObject:nil];

}

// 充值请求
-(void)getMoneyDataRequest
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"amount",nil];
    [self performSelectorOnMainThread:@selector(showProgress) withObject:self waitUntilDone:YES];
    
    // 网络请求
    [ZJMyPageRequest zjGetMoneyPOSTWithParams:dic result:^(BOOL success, id responseData) {
        
        [self performSelectorOnMainThread:@selector(dismissProgress) withObject:self waitUntilDone:YES];
        
        // 成功
        if (success) {
            
            // 后台设定成功
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                [self performSelectorOnMainThread:@selector(reloadUI) withObject:nil waitUntilDone:YES];
                
                
                // 后台设定失败
            }else if ([[responseData objectForKey:@"state"]isEqualToString:@"warn"]) {
                
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
            
        }else{
            
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
        
    }];
    
}


// 刷新UI
-(void)reloadUI
{
    
    
}

#pragma  mark ZJActionSheetAlterDelegate
- (void)ZJActionSheetAlertClikButtonIndex:(NSInteger)index alert:(ZJActionSheet *)alert
{
    // 银行卡
    if (index==0) {
       
    }else if (index==1){
       
    }
}

//footview
- (void)ZJActionSheetFootviewClikButtonIndex:(NSInteger)index alert:(ZJActionSheet *)alert
{
    
    if (index==2000) {
                [self animationHideShadowView];
                [self animationHideActionSheet];
        
                ZJaddBankCardController *addCardVC = [[ZJaddBankCardController alloc]initWithNibName:@"ZJaddBankCardController" bundle:nil];
                [self.navigationController pushViewController:addCardVC animated:YES];

    }else if (index==2001){
        
       
    }
}


- (void)animationHideShadowView
{
    [UIView animateWithDuration:0.3 animations:^{
        actionSheet.shadowView.alpha = 0;
    } completion:^(BOOL finished) {
        [actionSheet.shadowView removeFromSuperview];
    }];
}
- (void)animationHideActionSheet
{
    [UIView animateWithDuration:0.3 animations:^{
        actionSheet.alpha = 0;
        actionSheet.frame = CGRectMake(0, ZJAPPHeight, ZJAPPWidth, actionSheet.height);
    } completion:^(BOOL finished) {
        [actionSheet removeFromSuperview];
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
