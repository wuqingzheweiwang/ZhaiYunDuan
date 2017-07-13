//
//  ZJMyBillViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/3.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyBillViewController.h"
#import "ZJchongMoneyViewController.h"
#import "ZJupMoneyViewController.h"
#import "ZJBankCardViewController.h"
#import "ZJMyCommissionController.h"
@interface ZJMyBillViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *headerIamge;
@property (weak, nonatomic) IBOutlet UILabel *accountBlance;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (nonatomic , strong) NSMutableArray *tableViewdataSource;


@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ZJMyBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavcaition];
    [self setMyBillUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [NSThread detachNewThreadSelector:@selector(postMyBillDataRequest) toTarget:self withObject:nil];

}
-(void)setNavcaition
{
    self.navigationItem.hidesBackButton = YES;
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"我的钱包"];
    [ZJNavigationPublic setRightButtonOnTargetNav:self action:@selector(itemizedAccount) Withtitle:@"明细" withimage:[UIImage imageNamed:@""]];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)setMyBillUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView =self.headerIamge;
    
    _headerIamge.top = 64;
    _headerIamge.left = 0;
    _headerIamge.width = ZJAPPWidth;
    _headerIamge.height = TRUE_1(100);
    _headerIamge.backgroundColor = ZJColor_red;
    
    _accountBlance.top = TRUE_1(10);
    _accountBlance.left = TRUE_1(30/2);
    _accountBlance.width = TRUE_1(100);
    _accountBlance.height = TRUE_1(15);
    _accountBlance.font = ZJ_TRUE_FONT(12);
    
    _moneyLabel.top = _accountBlance.bottom+TRUE_1(40/2);
    _moneyLabel.left = _accountBlance.left;
    _moneyLabel.width = ZJAPPWidth;
    _moneyLabel.height = TRUE_1(30);
    _moneyLabel.font = ZJ_TRUE_FONT(36);
    
    
}


// 我的钱包请求
-(void)postMyBillDataRequest
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"",nil];
    [self performSelectorOnMainThread:@selector(showProgress) withObject:self waitUntilDone:YES];
    
    // 网络请求
    [ZJMyPageRequest zjPOSTMyBillRequestWithParams:dic result:^(BOOL success, id responseData) {
        
        [self performSelectorOnMainThread:@selector(dismissProgress) withObject:self waitUntilDone:YES];
        
        // 成功
        if (success) {
            
            DLog(@"1111111%@",responseData);
            // 后台设定成功
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                
                [self performSelectorOnMainThread:@selector(reloadUI) withObject:nil waitUntilDone:YES];
                
//                self.accountBlance = [[responseData objectForKey:@"data"]objectForKey:@"balance"];
                
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


-(void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableArray *)tableViewdataSource
{
    
    if (_tableViewdataSource == nil) {
        
        _tableViewdataSource = [NSMutableArray arrayWithObjects:
                                @[
                                    @[@"topup",@"充值"],
                                    @[@"withdrawal",@"提现"],
                                    @[@"bankcard",@"银行卡"],
                                  ],
                                @[
                                  @[@"commission",@"佣金"],
                                  @[@"point",@"积分"],
                                  @[@"coupon",@"优惠券"],
                                  @[@"ideal-money",@"虚拟货币"],
                                   ],
                                nil];
    }
    return _tableViewdataSource;
}


-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ZJAPPWidth, ZJAPPHeight-49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    
    return _tableView;
}

#pragma mark tableViewdelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewdataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tableViewdataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  =@"vsd";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    cell.imageView.image = [UIImage imageNamed:self.tableViewdataSource[indexPath.section][indexPath.row][0]];
    cell.textLabel.text = self.tableViewdataSource[indexPath.section][indexPath.row][1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return TRUE_1(5/2);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return TRUE_1(5/2);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return TRUE_1(100/2);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
        
            ZJchongMoneyViewController *chongzhiVC = [[ZJchongMoneyViewController alloc]initWithNibName:@"ZJchongMoneyViewController" bundle:nil];
            [self.navigationController pushViewController:chongzhiVC animated:YES];
            
        }else if (indexPath.row == 1){
            
            ZJupMoneyViewController *tixianVC = [[ZJupMoneyViewController alloc]initWithNibName:@"ZJupMoneyViewController" bundle:nil];
            [self.navigationController pushViewController:tixianVC animated:YES];
        }
        else if (indexPath.row == 2){
            
            ZJBankCardViewController *bankCardVC = [[ZJBankCardViewController alloc]initWithNibName:@"ZJBankCardViewController" bundle:nil];
            [self.navigationController pushViewController:bankCardVC animated:YES];
        }
    }else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            ZJMyCommissionController *myCommissionVC = [[ZJMyCommissionController alloc]initWithNibName:@"ZJMyCommissionController" bundle:nil];
            [self.navigationController pushViewController:myCommissionVC animated:YES];
             
        }else if (indexPath.row == 1){
            
           
        }
        else if (indexPath.row == 2){
            

        }
        else if (indexPath.row == 2){
            
            
        }

        
    }

}



// 明细
-(void)itemizedAccount
{
    
}


@end
