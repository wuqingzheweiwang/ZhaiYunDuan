//
//  ZJPersonDebtInfomationViewController.m
//  债云端
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 ZhongJinZhaiShi. All rights reserved.
//

#import "ZJPersonDebtInfomationViewController.h"
#import "ZJDebtMangerTableViewCell.h"
#import "ZJPersonBaseInfoTableViewCell.h"
#import "ZJCapitalAndDemandInfoTableViewCell.h"
#import "ZJDebtDetailViewController.h"
#import "ZJPayMoneyViewController.h"
#import "ZJAddDebtInformationViewController.h"
#import "ZJAddEditCapitalViewController.h"
#import "ZJCapitalAndDemandInfoDetailViewController.h"
#import "ZJAddEditDemandViewController.h"
#import "ZJDebtpersonDemandTableViewCell.h"
@interface ZJPersonDebtInfomationViewController ()<UITableViewDataSource,UITableViewDelegate,DebtMangerHomeDelegate,DebtCapitalAndDemandInfoDelegate,DebtDemandInfoDelegate,UIAlertViewDelegate>

@end

@implementation ZJPersonDebtInfomationViewController
{
    __weak IBOutlet UIView *HeaderView;
    __weak IBOutlet UITableView *Infotabel;
    NSMutableArray * _dataSource1; //基本信息
    NSMutableArray * _dataSource2; //资产信息
    NSMutableArray * _dataSource3; //需求信息
    NSMutableArray * _dataSource4; //债事信息
    NSInteger _page1;
    NSInteger _page2;
    NSInteger _page3;
    NSInteger _page4;
    UIButton * rightBtn;
    NSString * BtnType;   //直接赋值上面的按钮文字，根据他去判断显示什么布局
    ZJCapitalInfoItem * selectCapitalItem;
    ZJDemandInfoItem * selectDemandItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataSource1=[NSMutableArray array];
    _dataSource2=[NSMutableArray array];
    _dataSource3=[NSMutableArray array];
    _dataSource4=[NSMutableArray array];
    _page1=1;
    _page2=1;
    _page3=1;
    _page4=1;
    BtnType=@"基本信息";
    [ZJNavigationPublic setTitleOnTargetNav:self title:[NSString stringWithFormat:@"%@自然人",self.personName]];
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
        zjDdVC.personId=self.personId;
        [self.navigationController pushViewController:zjDdVC animated:YES];
    }else if (sender.tag==5002){ //需求信息
        ZJAddEditDemandViewController * zjDdVC=[[ZJAddEditDemandViewController alloc]initWithNibName:@"ZJAddEditDemandViewController" bundle:nil];
        zjDdVC.Btntype=ZJDemandAdd;
        zjDdVC.personId=self.personId;
        zjDdVC.block=^(NSString * fresh){
            if ([fresh isEqualToString:@"fresh"]) {
                _page3=1;
                [self requestDemandInfo];
            }
        };
        [self.navigationController pushViewController:zjDdVC animated:YES];
    }else if (sender.tag==5003){ //债事信息
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
    NSMutableArray * infoarray=[NSMutableArray arrayWithObjects:@"基本信息",@"资产信息",@"需求信息",@"债事信息", nil];
    for (int i=0; i<infoarray.count; i++) {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*(90+(ZJAPPWidth-90*4)/3), 0, 90, 44);
        [button setTitle:[NSString stringWithFormat:@"%@",[infoarray objectAtIndex:i]] forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:ZJColor_red forState:UIControlStateNormal];
        }else [button setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
        button.tag=1000+i;
        [button.titleLabel setFont:ZJ_FONT(12)];
        [HeaderView addSubview:button];
        [button addTarget:self action:@selector(infoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIView * lineview=[[UIView alloc]initWithFrame:CGRectMake(15+i*(90+(ZJAPPWidth-90*4)/3), 43, 60, 1)];
        lineview.backgroundColor=ZJColor_red;
        lineview.tag=2000+i;
        [HeaderView addSubview:lineview];
        if (i==0) {
            lineview.hidden=NO;
        }else lineview.hidden=YES;
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
    __weak ZJPersonDebtInfomationViewController *weakSelf = self;
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
    }else if ([BtnType isEqualToString:@"债事信息"]){
        _page4=1;
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
    }else if ([BtnType isEqualToString:@"债事信息"]){
        _page4+=1;
        [self requestDebtInfoMation];
    }
}
//button的点击事件
-(void)infoBtnAction:(UIButton *)sender
{
    //遍历查找btn
    BtnType=sender.titleLabel.text;
    [sender setTitleColor:ZJColor_red forState:UIControlStateNormal];
    for (UIButton *subView in HeaderView.subviews) {
        if ([subView isKindOfClass:[UIButton class]] && subView.tag != sender.tag) {
            [subView setTitleColor:ZJColor_333333 forState:UIControlStateNormal];
        }
    }
    //便利查找红线
    for (UIView *subView in HeaderView.subviews) {
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
    }else if ([BtnType isEqualToString:@"债事信息"]){
        rightBtn.hidden=NO;
        rightBtn.tag=5003;
        _page4=1;
        [self requestDebtInfoMation];
    }
}
#pragma mark  tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([BtnType isEqualToString:@"基本信息"]) {
        return _dataSource1.count;
    }else if ([BtnType isEqualToString:@"资产信息"]){
        return _dataSource2.count;
    }else if ([BtnType isEqualToString:@"需求信息"]){
        return _dataSource3.count;
    }else if ([BtnType isEqualToString:@"债事信息"]){
        return _dataSource4.count;
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
        cell.delegate = self;
        return cell;
    }else if ([BtnType isEqualToString:@"债事信息"]){
        static NSString *ID = @"identity_ID4";
        ZJDebtMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZJDebtMangerTableViewCell" owner:self options:nil]firstObject];
        }
        cell.ImageFlagLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.PayBtn.hidden=YES;
        cell.delegate = self;
        [cell setitem:[_dataSource4 objectAtIndex:indexPath.row]];
        return cell;
    }
    return nil;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([BtnType isEqualToString:@"资产信息"]){
        ZJCapitalAndDemandInfoDetailViewController * CaDDetailVC=[[ZJCapitalAndDemandInfoDetailViewController alloc]initWithNibName:@"ZJCapitalAndDemandInfoDetailViewController" bundle:nil];
        CaDDetailVC.capitalID=[[_dataSource2 objectAtIndex:indexPath.row] capitalid];
        CaDDetailVC.Btntype=ZJCapitalAndDemandTypeCapital;
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
    //没有支付
}
- (void)DebtMangerHomeSeeDetailActionWithItem:(ZJDebtMangerHomeItem *)item{
    ZJDebtDetailViewController * zjDdVC=[[ZJDebtDetailViewController alloc]initWithNibName:@"ZJDebtDetailViewController" bundle:nil];
    zjDdVC.DetailID=item.debtdebtid;
    [self.navigationController pushViewController:zjDdVC animated:YES];
}

#pragma mark--DebtCapitalAndDemandInfoDelegate  资产信息的代理
- (void)DebtCapitalAndDemandEditActionWithItem:(ZJCapitalInfoItem *)item//编辑
{
    ZJAddEditCapitalViewController * zjDdVC=[[ZJAddEditCapitalViewController alloc]initWithNibName:@"ZJAddEditCapitalViewController" bundle:nil];
    zjDdVC.Btntype=ZJCapitalEdit;
    zjDdVC.personId=self.personId;
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
    zjDdVC.personId=self.personId;
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
    }
}
#pragma mark--请求基本信息
- (void)requestBaseInfo
{
    NSString * action=[NSString stringWithFormat:@"api/debt?id=%@&type=human",self.personId];
    [self showProgress];
    [ZJDebtPersonRequest GetDebtPersonBaseInfomationRequestWithActions:action result:^(BOOL success, id responseData) {
        [self dismissProgress];
        if (success) {
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                NSDictionary * dic=[responseData objectForKey:@"data"];
                NSMutableDictionary * dic1=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"idCode"],@"text",@"身份证号",@"title",@"human",@"type", nil];
                [_dataSource1 addObject:dic1];
                NSMutableDictionary * dic2=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"area"],@"text",@"所属地区",@"title",@"human",@"type", nil];
                [_dataSource1 addObject:dic2];
                NSMutableDictionary * dic3=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"phoneNumber"],@"text",@"手机号",@"title",@"human",@"type", nil];
                [_dataSource1 addObject:dic3];
                NSMutableDictionary * dic4=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"contactAddress"],@"text",@"联系地址",@"title",@"human",@"type", nil];
                [_dataSource1 addObject:dic4];
                NSMutableDictionary * dic5=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"email"],@"text",@"电子邮箱",@"title",@"human",@"type", nil];
                [_dataSource1 addObject:dic5];
                NSMutableDictionary * dic6=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"qq"],@"text",@"QQ",@"title",@"human",@"type", nil];
                [_dataSource1 addObject:dic6];
                NSMutableDictionary * dic7=[NSMutableDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"weChat"],@"text",@"微信",@"title",@"human",@"type", nil];
                [_dataSource1 addObject:dic7];
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
    NSString * action=[NSString stringWithFormat:@"api/asset?debtId=%@&pn=%ld&ps=8",self.personId,_page2];
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
    NSString * action=[NSString stringWithFormat:@"api/demand?debtid=%@&pn=%ld&ps=8",self.personId,_page3];
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

#pragma mark--请求债事信息
- (void)requestDebtInfoMation
{
    NSString * action=[NSString stringWithFormat:@"api/debtrelation/debtinfo?debtId=%@&ps=8&pn=%ld",self.personId,(long)_page4];
    [self showProgress];
    [ZJDebtPersonRequest GetDebtPersondebtInfomationRequestWithActions:action result:^(BOOL success, id responseData) {
        NSLog(@"%@",responseData);
        [self dismissProgress];
        if (success) {
            
            if ([[responseData objectForKey:@"state"]isEqualToString:@"ok"]) {
                if (_page4==1) {
                    [_dataSource4 removeAllObjects];
                }
                NSArray * dicArray=[[responseData objectForKey:@"data"] objectForKey:@"items"];
                for (int i=0; i<dicArray.count; i++) {
                    ZJDebtMangerHomeItem * item=[ZJDebtMangerHomeItem itemForDictionary:[dicArray objectAtIndex:i]];
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
