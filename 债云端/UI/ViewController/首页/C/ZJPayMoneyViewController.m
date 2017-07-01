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
#import "ZJMakeToPAYViewController.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "RSADataSigner.h"
#import "WechatAuthSDK.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "ZJHomeRequest.h"
@interface ZJPayMoneyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *payWay;
    UIAlertController *alertcon;
    
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableViewdataSource;
@property (weak, nonatomic) IBOutlet UILabel *allPayLabel;
@property (weak, nonatomic) IBOutlet UIButton *gogoPayBut;


@end

@implementation ZJPayMoneyViewController
{
    //支付宝
    NSString * _rsa2PrivateKey;
    NSString * _body;
    NSString * _subject;
    NSString * _notify_url;
    NSString * _total_amount;
    NSString * _orderId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setPayUI];
  
    
}


-(void)setPayUI
{
    if (self.isManager == ZJisBankManegerYes) {
        
        alertcon = [UIAlertController alertControllerWithTitle:@"备案" message:@"支付500元完成备案!" preferredStyle:UIAlertControllerStyleAlert];
        // 添加按钮
        __weak typeof(alertcon) weakAlert = alertcon;
        [alertcon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
            
        }]];

        
    }else{
        
    alertcon = [UIAlertController alertControllerWithTitle:@"行长" message:@"支付39800元成为云债行行长,享受行长福利待遇!" preferredStyle:UIAlertControllerStyleAlert];
    // 添加按钮
    __weak typeof(alertcon) weakAlert = alertcon;
    [alertcon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
        
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
    if (self.isManager == ZJisBankManegerYes) {
        
        _allPayLabel.text = @"   共计500元";
    }else {
        
        _allPayLabel.text = @"   共计39800元";
    }
    
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
        @[@"ALI-Pay",@"支付宝支付",@"flagimagred",]]
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

//cell上btn的点击事件
-(void)changPayWay:(UIButton *)sender
{
    if (sender.tag == 1001) {
        _tableViewdataSource =[NSMutableArray arrayWithObjects:@[
        @[@"ALI-Pay",@"支付宝支付",@"flagimagred",]]
                               ,nil];
        [_tableView reloadData];
        
    }else if (sender.tag == 1002){
        _tableViewdataSource =[NSMutableArray arrayWithObjects:@[
        @[@"ALI-Pay",@"支付宝支付",@"flagimaggray",]]
                               ,nil];
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
//    ZJMakeToPAYViewController *payMoneyVC = [[ZJMakeToPAYViewController alloc]init];
//    [self.navigationController pushViewController:payMoneyVC animated:YES];
    
#pragma mark 微信支付
      
    //调起微信支付
//    PayReq* req = [[PayReq alloc] init];
//    req.partnerId           = @"1459224702";
//    req.prepayId            = @"wx20170518185901c6c2de300b0896178134";
//    req.nonceStr            = @"jsnPeYgXZCenKVYKVRIOwRHHGfKIDIBj";
//    req.timeStamp           = 1495105141;
//    req.package             = @"Sign=WXPay";
//    req.sign                = @"5E9F0D1BD436ADE5248A0B2721AE4635";
//    [WXApi sendReq:req];
  
    
#pragma mark 支付宝支付
    [self showProgress];
    NSLog(@"%@",self.orderid);
    NSDictionary * dict=[NSDictionary dictionaryWithObjectsAndKeys:self.orderid,@"orderId",self.type,@"type",nil];
    [ZJHomeRequest zjPostAlipayDebtRequestWithParams:dict result:^(BOOL success, id responseData) {
        [self dismissProgress];
        if (success) {
            
            NSLog(@"%@",responseData);
            
            if ([[responseData objectForKey:@"code"]isEqualToString:@"ok"]) {

                _orderId=[NSString stringWithFormat:@"%@",[responseData objectForKey:@"data"]];
                
                [self AlipayAction];
                
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"msg"]]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"请求失败"]];
        }
    }];



    
}
#pragma  mark  支付宝
- (void)AlipayAction{
   
        NSString *appScheme = @"zj1301Alipay";
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:_orderId fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"%@",resultDic);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
