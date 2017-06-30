//
//  ZJCompanyDebtInfomationViewController.m
//  债云端
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJCompanyDebtInfomationViewController.h"
#import "ZJDebtMangerTableViewCell.h"
#import "ZJPersonBaseInfoTableViewCell.h"
#import "ZJCapitalAndDemandInfoTableViewCell.h"
#import "ZJDebtDetailViewController.h"
#import "ZJDebtStockInfoTableViewCell.h"
#import "ZJDebtOperateTableViewCell.h"
#import "ZJAddEditCapitalViewController.h"
#import "ZJAddDebtInformationViewController.h"
#import "ZJPayMoneyViewController.h"
#import "ZJAddStockInfoViewController.h"
#import "ZJAddOperateInfoViewController.h"
#import "ZJCapitalAndDemandInfoDetailViewController.h"
#import "ZJAddEditDemandViewController.h"
#import "ZJDebtpersonDemandTableViewCell.h"
#define Kwidth  0   //按钮之间的距离
@interface ZJCompanyDebtInfomationViewController ()<UITableViewDataSource,UITableViewDelegate,DebtMangerHomeDelegate,DebtCapitalAndDemandInfoDelegate,DebtStockInfoDelegate,DebtOperateInfoDelegate,DebtDemandInfoDelegate>

@end

@implementation ZJCompanyDebtInfomationViewController
{
    __weak IBOutlet UIView *HeaderView;
    __weak IBOutlet UITableView *Infotabel;
    NSMutableArray * _dataSource1; //基本信息
    NSMutableArray * _dataSource2; //资产信息
    NSMutableArray * _dataSource3; //需求信息
    NSMutableArray * _dataSource4; //股权信息
    NSMutableArray * _dataSource5; //经营信息
    NSMutableArray * _dataSource6; //债事信息
    NSInteger _page1;
    NSInteger _page2;
    NSInteger _page3;
    NSInteger _page4;
    NSInteger _page5;
    NSInteger _page6;
    
    UIButton * rightBtn;
    NSString * BtnType;   //直接赋值上面的按钮文字，根据他去判断显示什么布局
    UIScrollView * headerScrollview;
    
    ZJCapitalInfoItem * selectCapitalItem;
    ZJDemandInfoItem * selectDemandItem;
    ZJStockInfoItem * selectStockItem;
    ZJOperateInfoItem * selectOperateItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ZJNavigationPublic setTitleOnTargetNav:self title:[NSString stringWithFormat:@"%@公司",self.companyName]];
    _dataSource1=[NSMutableArray array];
    _dataSource2=[NSMutableArray array];
    _dataSource3=[NSMutableArray array];
    _dataSource4=[NSMutableArray array];
    _dataSource5=[NSMutableArray array];
    _dataSource6=[NSMutableArray array];
    _page1=1;
    _page2=1;
    _page3=1;
    _page4=1;
    _page5=1;
    _page6=1;
    
    BtnType=@"基本信息";
    self.automaticallyAdjustsScrollViewInsets=NO;
    rightBtn=[ZJNavigationPublic setHiddenRightButtonOnTargetNav:self action:@selector(AddInfoBtnAction:) Withtitle:@"新增"];
    rightBtn.hidden=YES;
    rightBtn.tag=5000;
    [self resetUI];
    [self requestBaseInfo];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.isFresh) {
        if ([BtnType isEqualToString:@"资产信息"]){
            _page2=1;
            [self requestCapitalInfo];
        }
        self.isFresh=NO;
    }
}
//新增
-(void)AddInfoBtnAction:(UIButton *)sender
{
    if (sender.tag==5001) { //资产信息
        ZJAddEditCapitalViewController * zjDdVC=[[ZJAddEditCapitalViewController alloc]initWithNibName:@"ZJAddEditCapitalViewController" bundle:nil];
        zjDdVC.Btntype=ZJCapitalAdd;
        zjDdVC.companyId=self.companyId;
        [self.navigationController pushViewController:zjDdVC animated:YES];
    }else if (sender.tag==5002){ //需求信息
        ZJAddEditDemandViewController * zjDdVC=[[ZJAddEditDemandViewController alloc]initWithNibName:@"ZJAddEditDemandViewController" bundle:nil];
        zjDdVC.Btntype=ZJDemandAdd;
        zjDdVC.personId=self.companyId;
        zjDdVC.block=^(NSString * fresh){
            if ([fresh isEqualToString:@"fresh"]) {
                _page3=1;
                [self requestDemandInfo];
            }
        };
        [self.navigationController pushViewController:zjDdVC animated:YES];
    }else if (sender.tag==5003){ //股权信息
        ZJAddStockInfoViewController * zjDdVC=[[ZJAddStockInfoViewController alloc]initWithNibName:@"ZJAddStockInfoViewController" bundle:nil];
        zjDdVC.companyId=self.companyId;
        zjDdVC.block=^(NSString * fresh){
            if ([fresh isEqualToString:@"fresh"]) {
                _page4=1;
                [self requestStockInfo];
            }
        };
        [self.navigationController pushViewController:zjDdVC animated:YES];
    }else if (sender.tag==5004){ //经营信息
        ZJAddOperateInfoViewController * zjDdVC=[[ZJAddOperateInfoViewController alloc]initWithNibName:@"ZJAddOperateInfoViewController" bundle:nil];
        zjDdVC.companyId=self.companyId;
        zjDdVC.block=^(NSString * fresh){
            if ([fresh isEqualToString:@"fresh"]) {
                _page5=1;
                [self requestOperateInfo];
            }
        };
        [self.navigationController pushViewController:zjDdVC animated:YES];
    }else if (sender.tag==5005){ //债事信息
        ZJAddDebtInformationViewController * addDebtVC=[[ZJAddDebtInformationViewController alloc]initWithNibName:@"ZJAddDebtInformationViewController" bundle:nil];
        if ([ZJUtil getUserIsDebtBank]) {
            addDebtVC.Btntype=ZJDebtRecordTypeVip;
        }else{
            addDebtVC.Btntype=ZJDebtRecordTypeNoVip;
        }
        [self.navigationController pushViewController:addDebtVC animated:YES];
    }
}
//UI布局
-(void)resetUI{
    HeaderView.top=64;
    HeaderView.left=0;
    HeaderView.width=ZJAPPWidth;
    HeaderView.height=44;
    headerScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ZJAPPWidth, 44)];
    headerScrollview.userInteractionEnabled=YES;
    headerScrollview.showsVerticalScrollIndicator=NO;
    headerScrollview.showsHorizontalScrollIndicator=NO;
    [HeaderView addSubview:headerScrollview];
    NSMutableArray * infoarray=[NSMutableArray arrayWithObjects:@"基本信息",@"资产信息",@"需求信息",@"股权信息",@"经营信息",@"债事信息", nil];
    for (int i=0; i<infoarray.count; i++) {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*(90+Kwidth), 0, 90, 44);
        [button setTitle:[NSString stringWithFormat:@"%@",[infoarray objectAtIndex:i]] forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:ZJColor_red forState:UIControlStateNormal];
        }else [button setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
        button.tag=1000+i;
        [button.titleLabel setFont:ZJ_FONT(12)];
        [headerScrollview addSubview:button];
        [button addTarget:self action:@selector(infoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIView * lineview=[[UIView alloc]initWithFrame:CGRectMake(15+i*(90+Kwidth), 43, 60, 1)];
        lineview.backgroundColor=ZJColor_red;
        lineview.tag=2000+i;
        [headerScrollview addSubview:lineview];
        if (i==0) {
            lineview.hidden=NO;
        }else lineview.hidden=YES;
        [headerScrollview setContentSize:CGSizeMake(button.right, 0)];
    }
    Infotabel.top=HeaderView.bottom;
    Infotabel.left=0;
    Infotabel.width=ZJAPPWidth;
    Infotabel.height=ZJAPPHeight-44-64;
    Infotabel.separatorStyle = UITableViewCellSeparatorStyleNone;
    Infotabel.showsVerticalScrollIndicator = NO;
    [Infotabel setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [Infotabel setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    //刷新
    __weak ZJCompanyDebtInfomationViewController *weakSelf = self;
    Infotabel.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadFirstData];
    }];
    
    //加载
    Infotabel.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}
-(void)reloadFirstData
{
    //@weakify(self) 防止循环引用
    //@strongify(self) 防止指针消失
    if ([BtnType isEqualToString:@"基本信息"]){
        [Infotabel.mj_header endRefreshing];
        [Infotabel.mj_footer endRefreshing];
    }else if ([BtnType isEqualToString:@"资产信息"]){
        _page2=1;
        [self requestCapitalInfo];
    }else if ([BtnType isEqualToString:@"需求信息"]){
        _page3=1;
        [self requestDemandInfo];
    }else if ([BtnType isEqualToString:@"股权信息"]){
        _page4=1;
        [self requestStockInfo];
    }else if ([BtnType isEqualToString:@"经营信息"]){
        _page5=1;
        [self requestOperateInfo];
    }else if ([BtnType isEqualToString:@"债事信息"]){
        _page6=1;
        [self requestDebtInfoMation];
    }
    
}
-(void)loadMoreData
{
    if ([BtnType isEqualToString:@"基本信息"]){
        [Infotabel.mj_header endRefreshing];
        [Infotabel.mj_footer endRefreshing];
    }else if ([BtnType isEqualToString:@"资产信息"]){
        _page2+=1;
        [self requestCapitalInfo];
    }else if ([BtnType isEqualToString:@"需求信息"]){
        _page3+=1;
        [self requestDemandInfo];
    }else if ([BtnType isEqualToString:@"股权信息"]){
        _page4+=1;
        [self requestStockInfo];
    }else if ([BtnType isEqualToString:@"经营信息"]){
        _page5+=1;
        [self requestOperateInfo];
    }else if ([BtnType isEqualToString:@"债事信息"]){
        _page6+=1;
        [self requestDebtInfoMation];
    }
}

//button的点击事件
-(void)infoBtnAction:(UIButton *)sender
{
    //遍历查找btn
    BtnType=sender.titleLabel.text;
    [sender setTitleColor:ZJColor_red forState:UIControlStateNormal];
    for (UIButton *subView in headerScrollview.subviews) {
        if ([subView isKindOfClass:[UIButton class]] && subView.tag != sender.tag) {
            [subView setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
        }
    }
    //便利查找红线
    for (UIView *subView in headerScrollview.subviews) {
        if (![subView isKindOfClass:[UIButton class]] && subView.tag == sender.tag+1000) {
            subView.hidden=NO;
        }
        if (![subView isKindOfClass:[UIButton class]] && subView.tag != sender.tag+1000) {
            subView.hidden=YES;
        }
    }
    if ([BtnType isEqualToString:@"基本信息"]) {
        rightBtn.hidden=YES;
        rightBtn.tag=5000;
        [Infotabel reloadData];
    }else if ([BtnType isEqualToString:@"资产信息"]){
        rightBtn.hidden=NO;
        rightBtn.tag=5001;
        _page2=1;
        [self requestCapitalInfo];
    }else if ([BtnType isEqualToString:@"需求信息"]){
        rightBtn.hidden=NO;
        rightBtn.tag=5002;
        _page3=1;
        [self requestDemandInfo];
    }else if ([BtnType isEqualToString:@"股权信息"]){
        rightBtn.hidden=NO;
        rightBtn.tag=5003;
        _page4=1;
        [self requestStockInfo];
    }else if ([BtnType isEqualToString:@"经营信息"]){
        rightBtn.hidden=NO;
        rightBtn.tag=5004;
        _page5=1;
        [self requestOperateInfo];
    }else if ([BtnType isEqualToString:@"债事信息"]){
        rightBtn.hidden=NO;
        rightBtn.tag=5005;
        _page6=1;
        [self requestDebtInfoMation];
    }
    [Infotabel reloadData];
}
#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([BtnType isEqualToString:@"基本信息"]) {
        return _dataSource1.count;
    }else if ([BtnType isEqualToString:@"资产信息"]){
        return _dataSource2.count;
    }else if ([BtnType isEqualToString:@"需求信息"]){
        return _dataSource3.count;
    }else if ([BtnType isEqualToString:@"股权信息"]){
        return _dataSource4.count;
    }else if ([BtnType isEqualToString:@"经营信息"]){
        return _dataSource5.count;
    }else if ([BtnType isEqualToString:@"债事信息"]){
        return _dataSource6.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([BtnType isEqualToString:@"基本信息"]) {
        return [ZJPersonBaseInfoTableViewCell getCellHeight];
    }else if ([BtnType isEqualToString:@"资产信息"]){
        return [ZJCapitalAndDemandInfoTableViewCell getCellHeight];
    }else if ([BtnType isEqualToString:@"需求信息"]){
        return [ZJDebtpersonDemandTableViewCell getCellHeight];
    }else if ([BtnType isEqualToString:@"股权信息"]){
        return [ZJDebtStockInfoTableViewCell getCellHeight];
    }else if ([BtnType isEqualToString:@"经营信息"]){
        return [ZJDebtOperateTableViewCell getCellHeight];
    }else if ([BtnType isEqualToString:@"债事信息"]){
        return [ZJDebtMangerTableViewCell getCellHeight];
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([BtnType isEqualToString:@"基本信息"]) {
        static NSString *ID = @"identity_ID1";
        ZJPersonBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJPersonBaseInfoTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        [cell setitem:[_dataSource1 objectAtIndex:indexPath.row]];
        return cell;
        
    }else if ([BtnType isEqualToString:@"资产信息"]){
        static NSString *ID = @"identity_ID2";
        ZJCapitalAndDemandInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJCapitalAndDemandInfoTableViewCell" owner:self options:nil]firstObject];
        }
        cell.ImageFlagLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        [cell setitem:[_dataSource2 objectAtIndex:indexPath.row]];
        cell.delegate = self;
        return cell;
    }else if ([BtnType isEqualToString:@"需求信息"]){
        static NSString *ID = @"identity_ID3";
        ZJDebtpersonDemandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJDebtpersonDemandTableViewCell" owner:self options:nil]firstObject];
        }
        cell.ImageFlagLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        [cell setitem:[_dataSource3 objectAtIndex:indexPath.row]];
        cell.editBtn.hidden=YES;
        cell.delegate = self;
        return cell;
    }else if ([BtnType isEqualToString:@"股权信息"]){
        static NSString *ID = @"identity_ID4";
        ZJDebtStockInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJDebtStockInfoTableViewCell" owner:self options:nil]firstObject];
        }
        cell.ImageFlagLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        [cell setitem:[_dataSource4 objectAtIndex:indexPath.row]];
        return cell;
    }else if ([BtnType isEqualToString:@"经营信息"]){
        static NSString *ID = @"identity_ID5";
        ZJDebtOperateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJDebtOperateTableViewCell" owner:self options:nil]firstObject];
        }
        cell.ImageFlagLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        [cell setitem:[_dataSource5 objectAtIndex:indexPath.row]];
        cell.delegate=self;
        return cell;
    }else if ([BtnType isEqualToString:@"债事信息"]){
        static NSString *ID = @"identity_ID6";
        ZJDebtMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJDebtMangerTableViewCell" owner:self options:nil]firstObject];
        }
        cell.ImageFlagLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.PayBtn.hidden=YES;
        cell.delegate = self;
        [cell setitem:[_dataSource6 objectAtIndex:indexPath.row]];
        return cell;
    }
    return nil;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([BtnType isEqualToString:@"资产信息"]){
        ZJCapitalAndDemandInfoDetailViewController * CaDDetailVC=[[ZJCapitalAndDemandInfoDetailViewController alloc]initWithNibName:@"ZJCapitalAndDemandInfoDetailViewController" bundle:nil];
        CaDDetailVC.Btntype=ZJCapitalAndDemandTypeCapital;
        CaDDetailVC.capitalID=[[_dataSource2 objectAtIndex:indexPath.row] capitalid];
        [self.navigationController pushViewController:CaDDetailVC animated:YES];
    }else if ([BtnType isEqualToString:@"需求信息"]){
        ZJCapitalAndDemandInfoDetailViewController * CaDDetailVC=[[ZJCapitalAndDemandInfoDetailViewController alloc]initWithNibName:@"ZJCapitalAndDemandInfoDetailViewController" bundle:nil];
        CaDDetailVC.Btntype=ZJCapitalAndDemandTypeDemand;
        CaDDetailVC.capitalID=[[_dataSource3 objectAtIndex:indexPath.row] demandid];
        [self.navigationController pushViewController:CaDDetailVC animated:YES];
    }
}

#pragma mark--DebtMangerHomeDelegate  债事信息的代理
- (void)DebtMangerHomePayActionWithItem:(ZJDebtMangerHomeItem *)item
{
    ZJPayMoneyViewController * zjDdVC=[[ZJPayMoneyViewController alloc]initWithNibName:@"ZJPayMoneyViewController" bundle:nil];
    zjDdVC.type=@"1";
    zjDdVC.isManager=ZJisBankManegerYes;
    [self.navigationController pushViewController:zjDdVC animated:YES];
}
- (void)DebtMangerHomeSeeDetailActionWithItem:(ZJDebtMangerHomeItem *)item{
    ZJDebtDetailViewController * zjDdVC=[[ZJDebtDetailViewController alloc]initWithNibName:@"ZJDebtDetailViewController" bundle:nil];
    [self.navigationController pushViewController:zjDdVC animated:YES];
}

#pragma mark--DebtCapitalAndDemandInfoDelegate  资产信息的代理
- (void)DebtCapitalAndDemandEditActionWithItem:(ZJCapitalInfoItem *)item//编辑
{
    ZJAddEditCapitalViewController * zjDdVC=[[ZJAddEditCapitalViewController alloc]initWithNibName:@"ZJAddEditCapitalViewController" bundle:nil];
    zjDdVC.Btntype=ZJCapitalEdit;
    zjDdVC.companyId=self.companyId;
    zjDdVC.capitalId=item.capitalid;
    [self.navigationController pushViewController:zjDdVC animated:YES];
}
- (void)DebtCapitalAndDemandDeleteActionWithItem:(ZJCapitalInfoItem *)item //删除
{
    selectCapitalItem=item;
    UIAlertView * alteview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定删除吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" ,nil];
    alteview.tag=324;
    [alteview show];
}
#pragma mark--DebtCapitalAndDemandInfoDelegate  需求信息的代理
- (void)DebtDemandEditActionWithItem:(ZJDemandInfoItem *)item//编辑
{
    ZJAddEditDemandViewController * zjDdVC=[[ZJAddEditDemandViewController alloc]initWithNibName:@"ZJAddEditDemandViewController" bundle:nil];
    zjDdVC.Btntype=ZJDemandEdit;
    zjDdVC.personId=self.companyId;
    zjDdVC.demandId=item.demandid;
    zjDdVC.block=^(NSString * fresh){
        if ([fresh isEqualToString:@"fresh"]) {
            _page3=1;
            [self requestDemandInfo];
        }
    };
    [self.navigationController pushViewController:zjDdVC animated:YES];
}
- (void)DebtDemandDeleteActionWithItem:(ZJDemandInfoItem *)item //删除
{
    selectDemandItem=item;
    UIAlertView * alteview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定删除吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" ,nil];
    alteview.tag=325;
    [alteview show];
}
//删除  资产  和   需求
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==324) {
        NSMutableDictionary * dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:selectCapitalItem.capitalid,@"assetId", nil];
        [ZJDebtPersonRequest postDeleteDebtPersonCapitalInfoRequestWithParms:dict result:^(BOOL success, id responseData) {
            if (success) {
                if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                    [_dataSource2 removeObject:selectCapitalItem];
                    [Infotabel reloadData];
                }else{
                    [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:responseData];
            }
        }];
    }else if (alertView.tag==325){
        NSString * action=[NSString stringWithFormat:@"api/demand/delete?demandid=%@",selectDemandItem.demandid];
        [ZJDebtPersonRequest getDeleteDebtPersonDemandInfoRequestWithActions:action result:^(BOOL success, id responseData) {
            if (success) {
                if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                    [_dataSource3 removeObject:selectDemandItem];
                    [Infotabel reloadData];
                }else{
                    [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:responseData];
            }
        }];
    }else if (alertView.tag==326){  //删除股权信息

        NSMutableDictionary * dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:selectStockItem.stockid,@"quityid", nil];
        [ZJDebtPersonRequest postdeleteDebtCompanyStockInfoRequestWithParms:dict result:^(BOOL success, id responseData) {
            if (success) {
                if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                    [_dataSource4 removeObject:selectStockItem];
                    [Infotabel reloadData];
                }else{
                    [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:responseData];
            }
        }];
    }else if (alertView.tag==327){//删除经营信息
        NSMutableDictionary * dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:selectOperateItem.operateid,@"manageStateId", nil];
        [ZJDebtPersonRequest postdeleteDebtCompanyOperateInfoRequestWithParms:dic result:^(BOOL success, id responseData) {
            if (success) {
                if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                    [_dataSource5 removeObject:selectOperateItem];
                    [Infotabel reloadData];
                }else{
                    [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
                }
            }else{
                [ZJUtil showBottomToastWithMsg:responseData];
            }
        }];
    
    }
}
#pragma mark--DebtStockInfoDelegate  股权信息的代理
- (void)DebtStockDeleteActionWithItem:(ZJStockInfoItem *)item //删除
{
    selectStockItem=item;
    UIAlertView * alteview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定删除吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" ,nil];
    alteview.tag=326;
    [alteview show];
}
#pragma mark--DebtOperateInfoDelegate  经营信息的代理
- (void)DebtOperateDeleteActionWithItem:(ZJOperateInfoItem *)item //删除
{
    selectOperateItem=item;
    UIAlertView * alteview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定删除吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" ,nil];
    alteview.tag=327;
    [alteview show];
}

#pragma mark--请求基本信息
- (void)requestBaseInfo
{
    NSString * action=[NSString stringWithFormat:@"api/debt?id=%@&type=company",self.companyId];
    [self showProgress];
    [ZJDebtPersonRequest GetDebtPersonBaseInfomationRequestWithActions:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSDictionary * dic=[responseData objectForKey:@"data"];
                NSMutableDictionary * dic1=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"organCode"],@"text",@"组织机构代码",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic1];
                NSMutableDictionary * dic2=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"legalPersonName"],@"text",@"企业法人姓名",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic2];
                NSMutableDictionary * dic3=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"legalPersonId"],@"text",@"法人身份证号",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic3];
                NSMutableDictionary * dic4=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"area"],@"text",@"所属地区",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic4];
                NSMutableDictionary * dic5=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"phoneNumber"],@"text",@"联系电话",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic5];
                NSMutableDictionary * dic6=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"registeredCapital"],@"text",@"注册资本",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic6];
                NSMutableDictionary * dic7=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"contactAddress"],@"text",@"联系地址",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic7];
                NSMutableDictionary * dic8=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"category"],@"text",@"所属行业",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic8];
                NSMutableDictionary * dic9=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"email"],@"text",@"电子邮箱",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic9];
                NSMutableDictionary * dic10=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"qq"],@"text",@"QQ",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic10];
                NSMutableDictionary * dic11=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"weChat"],@"text",@"微信",@"title",@"company",@"type", nil];
                [_dataSource1 addObject:dic11];
                [Infotabel reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"网络请求错误"];
        }
        
    }];
}
#pragma mark--请求资产信息
- (void)requestCapitalInfo
{
    NSString * action=[NSString stringWithFormat:@"api/asset?debtId=%@&pn=%ld&ps=8",self.companyId,_page2];
    [self showProgress];
    [ZJDebtPersonRequest GetDebtPersonCapitalInfomationRequestWithActions:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        NSLog(@"%@",responseData);
        if (success) {
            
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                if (_page2==1) {
                    [_dataSource2 removeAllObjects];
                }
                NSArray * dicArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<dicArray.count; i++) {
                    ZJCapitalInfoItem * item=[ZJCapitalInfoItem itemForDictionary:[dicArray objectAtIndex:i]];
                    [_dataSource2 addObject:item];
                }
                [Infotabel reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"网络请求错误"];
        }
        [Infotabel.mj_header endRefreshing];
        [Infotabel.mj_footer endRefreshing];
        
    }];
    
}
#pragma mark--请求需求信息
- (void)requestDemandInfo
{
    NSString * action=[NSString stringWithFormat:@"api/demand?debtid=%@&pn=%ld&ps=8",self.companyId,_page3];
    [self showProgress];
    [ZJDebtPersonRequest GetDebtPersonCapitalInfomationRequestWithActions:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        NSLog(@"%@",responseData);
        if (success) {
            
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                if (_page3==1) {
                    [_dataSource3 removeAllObjects];
                }
                NSArray * dicArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<dicArray.count; i++) {
                    ZJDemandInfoItem * item=[ZJDemandInfoItem itemForDictionary:[dicArray objectAtIndex:i]];
                    [_dataSource3 addObject:item];
                }
                [Infotabel reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"网络请求错误"];
        }
        [Infotabel.mj_header endRefreshing];
        [Infotabel.mj_footer endRefreshing];
        
    }];
    
    
}
#pragma mark--请求股权信息
- (void)requestStockInfo
{
    NSString * action=[NSString stringWithFormat:@"api/equity/getequity?debtid=%@&ps=8&pn=%ld",self.companyId,(long)_page4];
    [self showProgress];
    [ZJDebtPersonRequest GetDebtCompanyequityRequestWithActions:action result:^(BOOL success, id responseData) {
        NSLog(@"%@",responseData);
        [self dismissProgress];
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                if (_page4==1) {
                    [_dataSource4 removeAllObjects];
                }
                NSArray * dicArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<dicArray.count; i++) {
                    ZJStockInfoItem * item=[ZJStockInfoItem itemForDictionary:[dicArray objectAtIndex:i]];
                    [_dataSource4 addObject:item];
                }
                [Infotabel reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"网络请求错误"];
        }
        [Infotabel.mj_header endRefreshing];
        [Infotabel.mj_footer endRefreshing];
        
    }];
}
#pragma mark--请求经营信息
- (void)requestOperateInfo
{
    NSString * action=[NSString stringWithFormat:@"api/managestate/find?debtId=%@&ps=8&pn=%ld",self.companyId,(long)_page5];
    [self showProgress];
    [ZJDebtPersonRequest GetDebtCompanyOperateRequestWithActions:action result:^(BOOL success, id responseData) {
        NSLog(@"%@",responseData);
        [self dismissProgress];
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                if (_page5==1) {
                    [_dataSource5 removeAllObjects];
                }
                NSArray * dicArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<dicArray.count; i++) {
                    ZJOperateInfoItem * item=[ZJOperateInfoItem itemForDictionary:[dicArray objectAtIndex:i]];
                    [_dataSource5 addObject:item];
                }
                [Infotabel reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"网络请求错误"];
        }
        [Infotabel.mj_header endRefreshing];
        [Infotabel.mj_footer endRefreshing];
        
    }];
}
#pragma mark--请求债事信息
- (void)requestDebtInfoMation
{
    NSString * action=[NSString stringWithFormat:@"api/debtrelation/debtinfo?debtId=%@&ps=8&pn=%ld",self.companyId,(long)_page6];
    [self showProgress];
    [ZJDebtPersonRequest GetDebtPersondebtInfomationRequestWithActions:action result:^(BOOL success, id responseData) {
        NSLog(@"%@",responseData);
        [self dismissProgress];
        if (success) {
            
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                if (_page6==1) {
                    [_dataSource6 removeAllObjects];
                }
                NSArray * dicArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<dicArray.count; i++) {
                    ZJDebtMangerHomeItem * item=[ZJDebtMangerHomeItem itemForDictionary:[dicArray objectAtIndex:i]];
                    [_dataSource6 addObject:item];
                }
                [Infotabel reloadData];
            }else{
                [ZJUtil showBottomToastWithMsg:[responseData objectForKey:@"message"]];
            }
        }else{
            [ZJUtil showBottomToastWithMsg:@"网络请求错误"];
        }
        [Infotabel.mj_header endRefreshing];
        [Infotabel.mj_footer endRefreshing];
        
    }];
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
