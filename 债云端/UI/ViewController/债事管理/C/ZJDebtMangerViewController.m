//
//  ZJDebtMangerViewController.m
//  债云端
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJDebtMangerViewController.h"
#import "ZJDebtMangerTableViewCell.h"
#import "ZJDebtMangerItem.h"
#import "ZJAddDebtInformationViewController.h"
#import "ZJDebtDetailViewController.h"
#import "ZJWebViewController.h"
#import "ZJPayMoneyViewController.h"
#import "ZJDeBtManageRequest.h"
@interface ZJDebtMangerViewController ()<UITableViewDataSource,UITableViewDelegate,DebtMangerHomeDelegate> //查看详情的代理

@end

@implementation ZJDebtMangerViewController
{
    __weak IBOutlet UITableView *DebtMangerTable;//tabel
    
    //table的区间头试图
    __weak IBOutlet UIView *tableHeaderview;   //头
    __weak IBOutlet UIView *MiddlelineView;
    __weak IBOutlet UIView *longLineView;
    __weak IBOutlet UIView *redLineview1;   //红线
    __weak IBOutlet UIView *redLineView2;
    __weak IBOutlet UIButton *UnsolvedBtn;//未解决btn
    __weak IBOutlet UIButton *ResolvedBtn;

    NSMutableArray * _dataSource;
    NSInteger  _page;
    NSString * action;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserRoleWithToken];
    //为了 切换用户 后的不刷新数据
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"DebtMangerRequest"]isEqualToString:@"0"]) {
        _page=1;
        [_dataSource removeAllObjects];
        [DebtMangerTable reloadData];
        [self requestDebtMangeListInfo];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"DebtMangerRequest"];
    }
}
//获取用户角色
- (void)getUserRoleWithToken
{
    [ZJHomeRequest zjGetUserRoleRequestresult:^(BOOL success, id responseData) {
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                [ZJUserInfo saveUserInfoWithUserRole:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"data"]]];
            }
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    _dataSource=[NSMutableArray array];
    _page=1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [ZJNavigationPublic setTitleOnTargetNav:self title:@"债事管理"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isfreshData) name:@"DebtManger" object:nil];
    if (_isPopVc) {
        [ZJNavigationPublic setLeftButtonOnTargetNav:self action:@selector(backToVc) With:[UIImage imageNamed:@"back"]];
    }
    [ZJNavigationPublic setRightButtonOnTargetNav:self action:@selector(AddDebtManagerAction) image:[UIImage imageNamed:@"DebtMangerAddPerson"] HighImage:[UIImage imageNamed:@"DebtMangerAddPerson"]];
    [self createUI];
    
}
//刷新数据
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"DebtManger" object:nil];
}
- (void)isfreshData
{
    _page=1;
    [_dataSource removeAllObjects];
    [DebtMangerTable reloadData];
    [self requestDebtMangeListInfo];
}
- (void)requestDebtMangeListInfo
{
    if (_Btntype==ZJDebtMangerUnsolved) {
        action=[NSString stringWithFormat:@"api/debtrelation?ps=5&pn=%ld&issolution=%d",(long)_page,0];
    }else if (_Btntype==ZJDebtMangerResolved){
        action=[NSString stringWithFormat:@"api/debtrelation?ps=5&pn=%ld&issolution=%d",(long)_page,1];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ZJDeBtManageRequest GetDebtManageListRequestWithActions:action result:^(BOOL success, id responseData) {
        
        NSLog(@"%@",responseData);
        if (success) {
            if (_page==1) {
                [_dataSource removeAllObjects];
            }
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
            
                NSArray * itemarray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<itemarray.count; i++) {
                    ZJDebtMangerHomeItem * item=[ZJDebtMangerHomeItem itemForDictionary:[itemarray objectAtIndex:i]];
                    [_dataSource addObject:item];
                }
                [DebtMangerTable reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[NSString stringWithFormat:@"%@",[responseData objectForKey:@"message"]]];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [ZJUtil showBottomToastWithMsg:@"请求失败"];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [DebtMangerTable.mj_header endRefreshing];
        [DebtMangerTable.mj_footer endRefreshing];
    }];
}
//返回页面
-(void)backToVc
{
    [self.navigationController popViewControllerAnimated:NO];
}
//新增债事
- (void)AddDebtManagerAction
{
    ZJAddDebtInformationViewController * addDebtVC=[[ZJAddDebtInformationViewController alloc]initWithNibName:@"ZJAddDebtInformationViewController" bundle:nil];
    if ([ZJUtil getUserIsDebtBank]) {
        addDebtVC.Btntype=ZJDebtRecordTypeVip;
    }else{
        addDebtVC.Btntype=ZJDebtRecordTypeNoVip;
    }
    [addDebtVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:addDebtVC animated:YES];
}
//重设UI
- (void)createUI{
    tableHeaderview.top=64;
    tableHeaderview.left=0;
    tableHeaderview.width=ZJAPPWidth;
    tableHeaderview.height=45;
    
    UnsolvedBtn.top=0;
    UnsolvedBtn.left=0;
    UnsolvedBtn.width=tableHeaderview.width/2;
    UnsolvedBtn.height=tableHeaderview.height;
    
    ResolvedBtn.top=0;
    ResolvedBtn.left=UnsolvedBtn.right;
    ResolvedBtn.width=tableHeaderview.width/2;
    ResolvedBtn.height=tableHeaderview.height;
    
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
    DebtMangerTable.top=64+45;
    DebtMangerTable.left=0;
    DebtMangerTable.width=ZJAPPWidth;
    if (_isPopVc) {
        DebtMangerTable.height=ZJAPPHeight-64-45;
    }else{
        DebtMangerTable.height=ZJAPPHeight-64-49-45;
    }
    
    DebtMangerTable.showsVerticalScrollIndicator = NO;
    DebtMangerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [DebtMangerTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [DebtMangerTable setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    //刷新
    __weak ZJDebtMangerViewController *weakSelf = self;
    DebtMangerTable.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    DebtMangerTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    if (!_Btntype) {
        _Btntype=ZJDebtMangerUnsolved;
    }
    if (_Btntype==ZJDebtMangerUnsolved) {
        [self UnsolvedAction:nil];
    }else if (_Btntype==ZJDebtMangerResolved){
        [self ResolvedAction:nil];
    }
    
}
//刷新
-(void)reloadFirstData
{
    _page=1;
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    [self requestDebtMangeListInfo];
    
}
-(void)loadMoreData
{
    _page+=1;
    [self requestDebtMangeListInfo];
}

//未解决
- (IBAction)UnsolvedAction:(id)sender {
    
    [UnsolvedBtn setTitleColor:ZJColor_red forState:UIControlStateNormal];
    [ResolvedBtn setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
    _Btntype=ZJDebtMangerUnsolved;
    redLineview1.hidden=NO;
    redLineView2.hidden=YES;
    
    //请求
    _page=1;
    [self requestDebtMangeListInfo];
    
}
//已解决
- (IBAction)ResolvedAction:(id)sender {
    
    [ResolvedBtn setTitleColor:ZJColor_red forState:UIControlStateNormal];
    [UnsolvedBtn setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
    _Btntype=ZJDebtMangerResolved;
    redLineView2.hidden=NO;
    redLineview1.hidden=YES;
    
    //请求
    _page=1;
    [self requestDebtMangeListInfo];
}

#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZJDebtMangerTableViewCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"identity_ID";

    ZJDebtMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJDebtMangerTableViewCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ImageFlagLabel.text= [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    cell.delegate = self;
    [cell setitem:[_dataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark--DebtMangerHomeDelegate
//支付
- (void)DebtMangerHomePayActionWithItem:(ZJDebtMangerHomeItem *)item
{
    ZJPayMoneyViewController * zjDdVC=[[ZJPayMoneyViewController alloc]initWithNibName:@"ZJPayMoneyViewController" bundle:nil];
    zjDdVC.isManager=ZJisBankManegerYes;
    zjDdVC.orderid=item.debtorderid;
    zjDdVC.type=@"1";
    zjDdVC.payAmount = item.qianshu;
    [zjDdVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:zjDdVC animated:YES];
}
//查看详情
- (void)DebtMangerHomeSeeDetailActionWithItem:(ZJDebtMangerHomeItem *)item{
    ZJDebtDetailViewController * zjDdVC=[[ZJDebtDetailViewController alloc]initWithNibName:@"ZJDebtDetailViewController" bundle:nil];
    zjDdVC.DetailID=item.debtdebtid;
    [zjDdVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:zjDdVC animated:YES];
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
