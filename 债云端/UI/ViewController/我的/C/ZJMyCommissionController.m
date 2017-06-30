//
//  ZJMyCommissionController.m
//  债云端
//
//  Created by 赵凯强 on 2017/6/23.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJMyCommissionController.h"

@interface ZJMyCommissionController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *headerIamge;
@property (weak, nonatomic) IBOutlet UILabel *allCommissionMoney;
@property (weak, nonatomic) IBOutlet UILabel *moneyTextLabel;
@property (nonatomic , strong) NSMutableArray *tableViewdataSource;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZJMyCommissionController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavcaition];
    [self setMyCommissionUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [NSThread detachNewThreadSelector:@selector(postMyCommissionMoneyDataRequest) toTarget:self withObject:nil];
    
}
-(void)setNavcaition
{
    self.navigationItem.hidesBackButton = YES;
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"我的佣金"];
    [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(leftAction) With:[UIImage imageNamed:@"back"]];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setMyCommissionUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView =self.headerIamge;
    
    _headerIamge.top = 64;
    _headerIamge.left = 0;
    _headerIamge.width = ZJAPPWidth;
    _headerIamge.height = TRUE_1(100);
    _headerIamge.backgroundColor = ZJColor_red;
    
    _allCommissionMoney.top = TRUE_1(10);
    _allCommissionMoney.left = TRUE_1(30/2);
    _allCommissionMoney.width = TRUE_1(100);
    _allCommissionMoney.height = TRUE_1(15);
    _allCommissionMoney.font = ZJ_TRUE_FONT(12);
    
    _moneyTextLabel.top = _allCommissionMoney.bottom+TRUE_1(40/2);
    _moneyTextLabel.left = _allCommissionMoney.left;
    _moneyTextLabel.width = ZJAPPWidth;
    _moneyTextLabel.height = TRUE_1(30);
    _moneyTextLabel.font = ZJ_TRUE_FONT(36);
    
    
}


// 我的钱包请求
-(void)postMyCommissionMoneyDataRequest
{
    NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"",nil];
    [self performSelectorOnMainThread:@selector(showProgress) withObject:self waitUntilDone:YES];
    
    // 网络请求
    [ZJMyPageRequest zjPOSTMyBillRequestWithParams:dic result:^(BOOL success, id responseData) {
        
        [self performSelectorOnMainThread:@selector(dismissProgress) withObject:self waitUntilDone:YES];
        
        // 成功
        if (success) {
            
            NSLog(@"1111111%@",responseData);
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



-(NSMutableArray *)tableViewdataSource
{
    if (_tableViewdataSource == nil) {
        
        _tableViewdataSource = [NSMutableArray arrayWithObjects:
                                @[
                                  @[@"recommend",@"推荐行长佣金",    [NSString stringWithFormat:@"累积0.00元"]],
                                  @[@"for-reference",@"备案佣金",[NSString stringWithFormat:@"累积0.00元"]],
                                  @[@"solve",@"解债佣金",[NSString stringWithFormat:@"累积0.00元"]],
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
        _tableView.backgroundColor = [UIColor whiteColor];
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:self.tableViewdataSource[indexPath.section][indexPath.row][0]];
    cell.textLabel.text = self.tableViewdataSource[indexPath.section][indexPath.row][1];
    cell.textLabel.textColor = ZJColor_333333;
    cell.detailTextLabel.text = self.tableViewdataSource[indexPath.section][indexPath.row][2];
    cell.detailTextLabel.textColor = ZJColor_666666;
    cell.detailTextLabel.font = ZJ_TRUE_FONT(28/2);
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
    if (section == 0) {
        return 0;
    }
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
            
            
        }else if (indexPath.row == 1){
            

        }
        else if (indexPath.row == 2){
            
            
        }
    }else{
        
    }
    
}


    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
