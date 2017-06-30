//  银行卡
//  ZJBankCardViewController.m
//  债云端
//
//  Created by 赵凯强 on 2017/5/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJBankCardViewController.h"
#import "ZJBankCardTableViewCell.h"
#import "ZJaddBankCardController.h"
@interface ZJBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic , strong) NSMutableArray *tableViewdateSource;
@property (weak, nonatomic) IBOutlet UIView *backgroundV;
@property (weak, nonatomic) IBOutlet UITableView *DebtTable;

// 添加银行卡
@property (weak, nonatomic) IBOutlet UIButton *addCardBut;


@end

@implementation ZJBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavcation];
    
}

-(void)setNavcation
{
    self.navigationItem.hidesBackButton = YES;
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"我的银行卡"];
    [self setBottomAddUI];
}

-(void)setBottomAddUI
{
    _DebtTable.top=0;
    _DebtTable.left=0;
    _DebtTable.width=ZJAPPWidth;
    _DebtTable.height=ZJAPPHeight;
    _DebtTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _DebtTable.tableFooterView=_backgroundV;
    _DebtTable.delegate = self;
    
    _backgroundV.top = 0;
    _backgroundV.left = 0;
    _backgroundV.width = ZJAPPWidth;
    _backgroundV.height = TRUE_1(88/2)+10;
    
   
    _addCardBut.top = 10;
    _addCardBut.left = TRUE_1(125/2);
    _addCardBut.width = ZJAPPWidth-TRUE_1(125);
    _addCardBut.height = TRUE_1(88/2);
    _addCardBut.layer.masksToBounds = YES;
    _addCardBut.layer.cornerRadius = 5;
    [_addCardBut.titleLabel setFont:ZJ_TRUE_FONT(15)];
    [_addCardBut addTarget:self action:@selector(addBankCard) forControlEvents:UIControlEventTouchUpInside];

}


//  跳转至添加银行卡页面
-(void)addBankCard
{
    ZJaddBankCardController *addBankCardVC = [[ZJaddBankCardController alloc]initWithNibName:@"ZJaddBankCardController" bundle:nil];
    [self.navigationController pushViewController:addBankCardVC animated:YES];
    
}

-(NSMutableArray *)tableViewdateSource
{
    if (_tableViewdateSource == nil) {
        _tableViewdateSource = [NSMutableArray arrayWithObjects:@[
            @[@"merchantsbank",@"招商银行",@"储蓄卡",@"**** **** **** 0506"],
            @[@"merchantsbank",@"招商银行",@"储蓄卡",@"**** **** **** 0506"],
            @[@"merchantsbank",@"招商银行",@"储蓄卡",@"**** **** **** 0506"]], nil];
    }
    return _tableViewdateSource;
}


#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewdateSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewdateSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  =@"vsd";
    ZJBankCardTableViewCell *bankCardCell = [tableView dequeueReusableCellWithIdentifier:str];
    if (bankCardCell == nil) {
        bankCardCell = [[[NSBundle mainBundle]loadNibNamed:@"ZJBankCardTableViewCell" owner:self options:nil]firstObject];
    }
    bankCardCell.selectionStyle = UITableViewCellSelectionStyleNone;
    bankCardCell.imageV.image = [UIImage imageNamed:self.tableViewdateSource[indexPath.section][indexPath.row][0]];
    bankCardCell.bankNameL.text = self.tableViewdateSource[indexPath.section][indexPath.row][1];
    bankCardCell.bankCardType.text = self.tableViewdateSource[indexPath.section][indexPath.row][2];
    bankCardCell.cardNumber.text = self.tableViewdateSource[indexPath.section][indexPath.row][3];
    return bankCardCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return TRUE_1(240/2);
}

@end
