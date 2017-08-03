//
//  ZJPayMoneyViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/5.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJPayMoneyViewController.h"
#import "ZJHomeViewController.h"
#import "ZJPayWayTableViewCell.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "RSADataSigner.h"
#import "WechatAuthSDK.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "ZJHomeRequest.h"
#import "ZJPaySuccessViewController.h"
@interface ZJPayMoneyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableViewdataSource;
@property (weak, nonatomic) IBOutlet UILabel *allPayLabel;
@property (weak, nonatomic) IBOutlet UIButton *gogoPayBut;


@end

@implementation ZJPayMoneyViewController
{
    //支付宝
    NSString * _orderId;
    UIAlertController *alertcon;
    NSString *payType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    payType=@"payTypeZhifubao";
    NSNotificationCenter* notif = [NSNotificationCenter defaultCenter];
    [notif addObserver:self selector:@selector(apliyPayNotifAction:) name:@"apliyPay" object:nil];
    
    NSNotificationCenter* notif1 = [NSNotificationCenter defaultCenter];
    [notif1 addObserver:self selector:@selector(wXinPayNotifAction:) name:@"wXinPay" object:nil];
    
    [self setPayUI];
  
    
}
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"apliyPay" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"wXinPay" object:nil];
}

-(void)setPayUI
{
    if (self.isManager == ZJisBankManegerYes) {
        
        alertcon = [UIAlertController alertControllerWithTitle:@"备案" message:[NSString stringWithFormat:@"   支付%@元完成备案!",self.payAmount] preferredStyle:UIAlertControllerStyleAlert];
        // 添加按钮
        __weak typeof(alertcon) weakAlert = alertcon;
        [alertcon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            DLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
            
        }]];

        
    }else{
        
    alertcon = [UIAlertController alertControllerWithTitle:@"行长" message:[NSString stringWithFormat:@"   支付%@元成为云债行行长,享受行长福利待遇!",self.payAmount] preferredStyle:UIAlertControllerStyleAlert];
        
    // 添加按钮
    __weak typeof(alertcon) weakAlert = alertcon;
    [alertcon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        DLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
        
    }]];
        
}
    
    [self presentViewController:alertcon animated:YES completion:nil];

    [ZJNavigationPublic setTitleOnTargetNav:self title:@"支付备案费"];
    [ZJNavigationPublic setRightButtonOnTargetNav:self action:@selector(backHomePage) image:[UIImage imageNamed:@"return-home"] HighImage:[UIImage imageNamed:@"return-home"]];
    self.navigationItem.hidesBackButton = YES;
    
    [self.view addSubview:self.tableView];
    
    // 共计多少钱
    _allPayLabel.bottom = ZJAPPHeight;
    _allPayLabel.left = 0;
    _allPayLabel.width = ZJAPPWidth-ZJAPPWidth/3;
    _allPayLabel.height = TRUE_1(110/2);
    [_allPayLabel setFont:ZJ_TRUE_FONT(15)];
    _allPayLabel.text = [NSString stringWithFormat:@"   共计%@元",self.payAmount];
    
    //  支付
    _gogoPayBut.bottom = ZJAPPHeight;
    _gogoPayBut.left = _allPayLabel.right;
    _gogoPayBut.width = ZJAPPWidth - _allPayLabel.width;
    _gogoPayBut.height = _allPayLabel.height;
    [_gogoPayBut.titleLabel setFont:ZJ_TRUE_FONT(15)];
    [_gogoPayBut addTarget:self action:@selector(gotoPayMoney) forControlEvents:UIControlEventTouchUpInside];
}

-(NSMutableArray *)tableViewdataSource
{
    if (_tableViewdataSource == nil) {
        _tableViewdataSource =[NSMutableArray arrayWithObjects:@[
        @[@"ALI-Pay",@"支付宝支付",@"flagimagred",],
        @[@"WinxinPay",@"微信支付",@"flagimaggray",]]
                               ,nil];
        
    }
    return _tableViewdataSource;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ZJAPPWidth, ZJAPPHeight-_allPayLabel.height - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tableViewdataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  =@"vsd";
    ZJPayWayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJPayWayTableViewCell" owner:self options:nil]firstObject];
    }
    
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.imageV.image = [UIImage imageNamed:self.tableViewdataSource[indexPath.section][indexPath.row][0]];
    cell.textLab.text = self.tableViewdataSource[indexPath.section][indexPath.row][1];
    
    
    if (indexPath.row == 0) {
        cell.selectBut.tag =1001;
    }else if (indexPath.row == 1){
        cell.selectBut.tag =1002;
    }
    [cell.selectBut setImage:[UIImage imageNamed:self.tableViewdataSource[indexPath.section][indexPath.row][2]] forState:UIControlStateNormal];
    
    [cell.selectBut addTarget:self action:@selector(changPayWay:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, TRUE_1(40))];
    label.text = @"   选择支付方式:";
    label.font = ZJ_TRUE_FONT(15);
    label.textColor = ZJColor_333333;
    return label;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"   选择支付方式:";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        _tableViewdataSource =[NSMutableArray arrayWithObjects:@[
                                                                 @[@"ALI-Pay",@"支付宝支付",@"flagimagred",],
                                                                 @[@"WinxinPay",@"微信支付",@"flagimaggray",]]
                               ,nil];
        payType=@"payTypeZhifubao";
        [_tableView reloadData];
        
    }else if (indexPath.row == 1){
        
        _tableViewdataSource =[NSMutableArray arrayWithObjects:@[
                                                                 @[@"ALI-Pay",@"支付宝支付",@"flagimaggray",],
                                                                 @[@"WinxinPay",@"微信支付",@"flagimagred",]]
                               ,nil];
        payType=@"payTypeWeixin";
        [_tableView reloadData];

    }
}
//cell上btn的点击事件
-(void)changPayWay:(UIButton *)sender
{
    if (sender.tag == 1001) {
        _tableViewdataSource =[NSMutableArray arrayWithObjects:@[
        @[@"ALI-Pay",@"支付宝支付",@"flagimagred",],
        @[@"WinxinPay",@"微信支付",@"flagimaggray",]]
                               ,nil];
        payType=@"payTypeZhifubao";
        [_tableView reloadData];
        
    }else if (sender.tag == 1002){
        _tableViewdataSource =[NSMutableArray arrayWithObjects:@[
        @[@"ALI-Pay",@"支付宝支付",@"flagimaggray",],
        @[@"WinxinPay",@"微信支付",@"flagimagred",]]
                               ,nil];
        payType=@"payTypeWeixin";
        [_tableView reloadData];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE_1(60);
}



// 返回首页
-(void)backHomePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// 支付
-(void)gotoPayMoney
{
    if ([payType isEqualToString:@"payTypeZhifubao"]) {
#pragma mark 支付宝支付
        [self showProgress];
        NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:self.orderid,@"orderId",self.type,@"type",nil];
        [ZJHomeRequest zjPostAlipayDebtRequestWithParams:dict result:^(BOOL success, id responseData) {
            [self dismissProgress];
            if (success) {
                
                DLog(@"%@",responseData);
                
                if ([[responseData objectForKey:@"code"]isEqualToString:@"ok"]) {
                    
                    _orderId=[NSString stringWithFormat:@"%@",[responseData objectForKey:@"data"]];
                    
                    [self AlipayAction];
                    
                }else{
                            [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"系统异常"]];
            }
        }];

    }else if ([payType isEqualToString:@"payTypeWeixin"]){
       #pragma mark 微信支付
        [self showProgress];
        NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:self.orderid,@"prepayid",self.type,@"type",nil];
        [ZJHomeRequest zjPostWeiXinDebtRequestWithParams:dict result:^(BOOL success, id responseData) {
            [self dismissProgress];
            if (success) {
                NSLog(@"%@",self.orderid);
                NSLog(@"%@",responseData);
                
                if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                    NSDictionary * dataDic=[[responseData objectForKey:@"data"] objectForKey:@"callWx"];
                    
                    PayReq* req = [[PayReq alloc] init];
                    req.partnerId           = [dataDic objectForKey:@"partnerid"];
                    req.prepayId            = [dataDic objectForKey:@"prepayid"];
                    req.nonceStr            = [dataDic objectForKey:@"noncestr"];
                    req.timeStamp           = [[dataDic objectForKey:@"timestamp"] intValue];
                    req.package             = [dataDic objectForKey:@"package"];
                    req.sign                = [dataDic objectForKey:@"sign"];
                    [WXApi sendReq:req];
                    
                }else{
                    [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"系统异常"]];
            }
        }];
        
        

    }else{  //银联
    
    }
}

#pragma  mark  支付宝
- (void)AlipayAction{
   
        NSString *appScheme = @"zj1301Alipay";
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:_orderId fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            DLog(@"%@",resultDic);
            if ([resultDic[@"resultStatus"] intValue]==9000) {
                
                [ZJUtil showBottomToastWithMsg:@"支付成功"];
            }else if ([resultDic[@"resultStatus"] intValue] == 8000) {
                [ZJUtil showBottomToastWithMsg:@"正在处理中"];
            } else if ([resultDic[@"resultStatus"] intValue] == 4000) {
                [ZJUtil showBottomToastWithMsg:@"订单支付失败"];
            } else if ([resultDic[@"resultStatus"] intValue] == 6001) {
                [ZJUtil showBottomToastWithMsg:@"用户中途取消"];
            } else if ([resultDic[@"resultStatus"] intValue] == 6002) {
                [ZJUtil showBottomToastWithMsg:@"网络连接出错"];
            }
            else {
                
                NSString *resultMes = resultDic[@"memo"];
                resultMes = (resultMes.length<=0?@"支付失败":resultMes);
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",resultMes]];
            }
        }];
}
- (void)apliyPayNotifAction:(NSNotification *)noti {
    NSString *notiString = [noti.userInfo objectForKey:@"errCode"];
    if (![notiString isEqualToString:@""] && notiString != nil) {
        if ([notiString isEqualToString:@"支付成功"]) {
            ZJPaySuccessViewController * paySuccVC=[[ZJPaySuccessViewController alloc]initWithNibName:@"ZJPaySuccessViewController" bundle:nil];
            [self.navigationController pushViewController:paySuccVC animated:YES];
        }
    }
}
- (void)wXinPayNotifAction:(NSNotification *)noti {
    NSString *notiString = [noti.userInfo objectForKey:@"errCode"];
    if (![notiString isEqualToString:@""] && notiString != nil) {
        if ([notiString isEqualToString:@"支付成功"]) {
            ZJPaySuccessViewController * paySuccVC=[[ZJPaySuccessViewController alloc]initWithNibName:@"ZJPaySuccessViewController" bundle:nil];
            [self.navigationController pushViewController:paySuccVC animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
