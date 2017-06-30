//
//  ZJAddDemandViewController.m
//  债云端
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJAddDemandViewController.h"
#import "ZJAddDemandTableViewCell.h"
@interface ZJAddDemandViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZJAddDemandViewController
{
    __weak IBOutlet UITableView *DebtTable;//tabel
    
    //table的区间头试图
    __weak IBOutlet UIView *tableHeaderview;   //头
    __weak IBOutlet UIView *MiddlelineView;
    __weak IBOutlet UIView *longLineView;
    __weak IBOutlet UIView *redLineview1;   //红线
    __weak IBOutlet UIView *redLineView2;
    __weak IBOutlet UIButton *AllBtn;//未解决btn
    __weak IBOutlet UIButton *KuaiSuBtn;
    
    NSMutableArray * _dataSource;
    NSInteger  _page;
    NSString * typeClass;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"新增需求信息"];
    [ZJNavigationPublic setRightButtonOnTargetNav:self action:@selector(SaveBtnAction) Withtitle:@"完成" withimage:nil];
    _dataSource=[NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    _page=1;
    typeClass=@"全部";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
}
//完成
-(void)SaveBtnAction
{
    int i=0;
    for (NSString * stringnum in _dataSource) {
        if ([stringnum isEqualToString:@"0"]) {
            i++;
        }
    }
    if (i==_dataSource.count) {
        [ZJUtil showBottomToastWithMsg:@"请选择您新增的需求信息"];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//重设UI
- (void)createUI{
    tableHeaderview.top=64;
    tableHeaderview.left=0;
    tableHeaderview.width=ZJAPPWidth;
    tableHeaderview.height=45;
    
    AllBtn.top=0;
    AllBtn.left=0;
    AllBtn.width=tableHeaderview.width/2;
    AllBtn.height=tableHeaderview.height;
    
    KuaiSuBtn.top=0;
    KuaiSuBtn.left=AllBtn.right;
    KuaiSuBtn.width=tableHeaderview.width/2;
    KuaiSuBtn.height=tableHeaderview.height;
    
    MiddlelineView.width=1;
    MiddlelineView.height=25;
    MiddlelineView.top=10;
    MiddlelineView.left=(ZJAPPWidth-1)/2;
    
    longLineView.width=ZJAPPWidth;
    longLineView.height=1;
    longLineView.top=44;
    longLineView.left=0;
    
    redLineview1.top=43;
    redLineView2.top=redLineview1.top;
    redLineview1.left= (tableHeaderview.width/2-100)/2;
    redLineView2.left= (tableHeaderview.width/2-100)/2+tableHeaderview.width/2;
    redLineview1.width=100;
    redLineview1.height=1;
    redLineView2.width=redLineview1.width;
    redLineView2.height=redLineview1.height;
    
    
    //table
    DebtTable.top=64+45;
    DebtTable.left=0;
    DebtTable.width=ZJAPPWidth;
    DebtTable.height=ZJAPPHeight-64-45;
    DebtTable.showsVerticalScrollIndicator = NO;
    DebtTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [DebtTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [DebtTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    
}
//全部
- (IBAction)UnsolvedAction:(id)sender {
    
    
    [AllBtn setTitleColor:ZJColor_red forState:UIControlStateNormal];
    [KuaiSuBtn setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
    redLineview1.hidden=NO;
    redLineView2.hidden=YES;
    typeClass=@"全部";
    ///请求
    //
    
    
}
//快速匹配
- (IBAction)ResolvedAction:(id)sender {
    
    [KuaiSuBtn setTitleColor:ZJColor_red forState:UIControlStateNormal];
    [AllBtn setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
    redLineView2.hidden=NO;
    redLineview1.hidden=YES;
    typeClass=@"快速匹配";
    ///请求
    //
}

#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZJAddDemandTableViewCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"identity_ID";
    
    ZJAddDemandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJAddDemandTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    [cell setitem:nil];
    //暂时先这样
    if ([[_dataSource objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        [cell.FlagImage setImage:[UIImage imageNamed:@"flagimaggray"]];
    }else{
        [cell.FlagImage setImage:[UIImage imageNamed:@"flagimagred"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([[_dataSource objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        [_dataSource removeObjectAtIndex:indexPath.row];
        [_dataSource insertObject:@"1" atIndex:indexPath.row];
    }else{
        [_dataSource removeObjectAtIndex:indexPath.row];
        [_dataSource insertObject:@"0" atIndex:indexPath.row];
    }
    [DebtTable reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
