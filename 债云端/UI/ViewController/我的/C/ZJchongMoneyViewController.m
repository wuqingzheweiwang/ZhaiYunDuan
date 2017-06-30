//  充值
//  ZJchongMoneyViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJchongMoneyViewController.h"
#import "ZJActionSheet.h"
#import "ZJaddBankCardController.h"

@interface ZJchongMoneyViewController ()<ZJActionSheetAlterDelegate,UITextFieldDelegate>
{
    // 添加银行卡
    UIView *addView;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *bankCardNumber;
@property (weak, nonatomic) IBOutlet UIImageView *nextImageView;
@property (weak, nonatomic) IBOutlet UIButton *clickChangeCard;

@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UILabel *secondViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UIButton *chongZhiBut;
@property (nonatomic ,strong) NSMutableArray *confirms;
@end

@implementation ZJchongMoneyViewController
{
    ZJActionSheet *actionSheet;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavcaition];
    if (self.confirms.count == 0) {

    [self setChongZhiNoneBankCardUI];

    }else{

    [self setChongZhiBankCardUI];
    [addView removeFromSuperview];
    }
}


-(void)setNavcaition
{
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"充值"];
}


-(void)setChongZhiNoneBankCardUI
{
    addView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ZJAPPWidth, TRUE_1(200))];
    addView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:addView];
    
    UIButton *addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    addbutton.top = TRUE_1(40/2);
    addbutton.centerX = addView.centerX;
    addbutton.left = TRUE_1(125/2);
    addbutton.width = ZJAPPWidth-TRUE_1(125);
    addbutton.height = TRUE_1(88/2);
    addbutton.layer.borderWidth = 1;
    addbutton.layer.borderColor =[UIColor lightGrayColor].CGColor;
    addbutton.layer.masksToBounds = YES;
    addbutton.layer.cornerRadius = 5;
    [addbutton setTitle:@"  添加银行卡" forState:UIControlStateNormal];
    [addbutton setTitleColor:ZJColor_red forState:UIControlStateNormal];
    [addbutton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addbutton addTarget:self action:@selector(gotoAddCardpage) forControlEvents:UIControlEventTouchUpInside];
    
    [addView addSubview:addbutton];
}

// 添加银行卡
-(void)gotoAddCardpage
{
    ZJaddBankCardController *addBankVC = [[ZJaddBankCardController alloc]initWithNibName:@"ZJaddBankCardController" bundle:nil];
    [self.navigationController pushViewController:addBankVC animated:YES];
    
}


-(void)setChongZhiBankCardUI
{
    CGFloat navgationBarHeight = 64;
    // 图片
    _imageView.top = navgationBarHeight +TRUE_1(45/2);
    _imageView.left = TRUE_1(30/2);
    _imageView.width = TRUE_1(60/2);
    _imageView.height = _imageView.width;
    _imageView.image = [UIImage imageNamed:@"merchantsbank"];
    // 银行名称
    _bankName.top = navgationBarHeight +TRUE_1(30/2);
    _bankName.left = _imageView.right+TRUE_1(30/2);
    _bankName.width = TRUE_1(100);
    _bankName.height = TRUE_1(30/2);
    _bankName.font = ZJ_TRUE_FONT(30/2);
    //  尾号
    _bankCardNumber.top = _bankName.bottom+TRUE_1(40/2);
    _bankCardNumber.left = _bankName.left;
    _bankCardNumber.width = _bankName.width;
    _bankCardNumber.height = _bankName.height;
    _bankCardNumber.font = ZJ_TRUE_FONT(24/2);
    
    //  换卡
    _nextImageView.centerY = _imageView.centerY;
    _nextImageView.top = TRUE_1(66/2)+ navgationBarHeight;
    _nextImageView.width = TRUE_1(6);
    _nextImageView.height = TRUE_1(11);
    _nextImageView.right = ZJAPPWidth - TRUE_1(30/2)-_nextImageView.width;
    
    _clickChangeCard.top = navgationBarHeight;
    _clickChangeCard.centerY = _imageView.centerY;
    _clickChangeCard.width = TRUE_1(100);
    _clickChangeCard.height = TRUE_1(80);
    _clickChangeCard.right = ZJAPPWidth - TRUE_1(30/2)-_clickChangeCard.width;
    [_clickChangeCard addTarget:self action:@selector(nextChangeCard) forControlEvents:UIControlEventTouchUpInside];
    
    _secondView.top = _bankCardNumber.bottom+TRUE_1(35/2);
    _secondView.left = 0;
    _secondView.width = ZJAPPWidth;
    _secondView.height = TRUE_1(60/2);
    
    // 充值
    _secondViewLabel.top = 0;
    _secondViewLabel.left = _imageView.left;
    _secondViewLabel.width = _secondView.width;
    _secondViewLabel.height = _secondView.height;
    _secondViewLabel.font = ZJ_TRUE_FONT(28/2);

    // 金额
    _moneyLabel.top = _secondView.bottom;
    _moneyLabel.left = _secondViewLabel.left;
    _moneyLabel.width = TRUE_1(70/2);
    _moneyLabel.height = TRUE_1(80/2);
    _moneyLabel.font = ZJ_TRUE_FONT(30/2);

    // 输入充值金额
    _moneyTextField.top = _moneyLabel.top;
    _moneyTextField.left = _moneyLabel.right+TRUE_1(20/2);
    _moneyTextField.width = ZJAPPWidth - TRUE_1(30);
    _moneyTextField.height =  _moneyLabel.height;
    _moneyTextField.delegate = self;
    _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    _moneyTextField.font = ZJ_TRUE_FONT(15);

    _fourthView.top = _moneyTextField.bottom;
    _fourthView.left = _secondView.left;
    _fourthView.width = _secondView.width;
    _fourthView.height = TRUE_1(10/2);
    
    //  充值
    _chongZhiBut.top = _fourthView.bottom+TRUE_1(60/2);
    _chongZhiBut.left = TRUE_1(80/2);
    _chongZhiBut.width = ZJAPPWidth - TRUE_1(80);
    _chongZhiBut.height = TRUE_1(66/2);
    _chongZhiBut.layer.masksToBounds = YES;
    _chongZhiBut.layer.cornerRadius = 5;
    [_chongZhiBut addTarget:self action:@selector(clickChongzhi) forControlEvents:UIControlEventTouchUpInside];
    
}


// 充值
-(void)clickChongzhi
{
    for (UITextField* textFieldsubView in self.view.subviews)
    {
        [textFieldsubView resignFirstResponder];
    }
    if ([_moneyTextField.text isEqualToString:@""]) {
        [ZJUtil showBottomToastWithMsg:@"请输入充值金额"];
        return;
    }
    
    [NSThread detachNewThreadSelector:@selector(payMoneyDataRequest) toTarget:self withObject:nil];

}

// 充值请求
-(void)payMoneyDataRequest
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:self.moneyTextField.text,@"amount",nil];
    [self performSelectorOnMainThread:@selector(showProgress) withObject:self waitUntilDone:YES];
    
    // 网络请求
    [ZJMyPageRequest zjPayMoneyPOSTWithParams:dic result:^(BOOL success, id responseData) {
        
        [self performSelectorOnMainThread:@selector(dismissProgress) withObject:self waitUntilDone:YES];
        
        // 成功
        if (success) {
            
            NSLog(@"1111111%@",responseData);
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



-(NSMutableArray *)confirms
{
    if (_confirms == nil) {
        _confirms = [NSMutableArray arrayWithObjects:@[
                                                       @[@"merchantsbank",@"招商银行储蓄卡（0506）",@"可用额度50,000.00元",],], nil];
    }
    return _confirms;
}
// 更换付款方式
-(void)nextChangeCard
{
    actionSheet =[ZJActionSheet actionSheetWithTitle:@"选择付款方式" confirms:self.confirms cancel:@"" withType:@"chongzhi" style:ZJActionSheetStyleDefault];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view.window];

}

#pragma  mark ZJActionSheetAlterDelegate
- (void)ZJActionSheetAlertClikButtonIndex:(NSInteger)index alert:(ZJActionSheet *)alert
{
    // 银行卡
    if (index==0) {
        NSLog(@"0000");

    }else if (index==1){
        
        NSLog(@"1111");

    }else{
        
    }
    
}

//footview的代理
- (void)ZJActionSheetFootviewClikButtonIndex:(NSInteger)index alert:(ZJActionSheet *)alert{
    
    if (index==2000) {
        NSLog(@"000");
        [self animationHideShadowView];
        [self animationHideActionSheet];
        
        ZJaddBankCardController *addCardVC = [[ZJaddBankCardController alloc]initWithNibName:@"ZJaddBankCardController" bundle:nil];
        [self.navigationController pushViewController:addCardVC animated:YES];
        
    }else if (index==2001){
        
        NSLog(@"111");
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
